import 'package:flutter/material.dart';
import 'package:kanpractice/ui/theme/consts.dart';

part 'dial_child.dart';

class Dial extends StatefulWidget {
  const Dial({
    Key? key,
    required this.icon,
    required this.dialChildren,
    required this.color
  }) : super(key: key);

  /// AnimatedIcon to be displayed
  final AnimatedIconData icon;

  /// A list of [DialChild] to display when the [Dial] is open.
  final List<DialChild> dialChildren;

  /// Color of the primary color icon
  final Color color;

  @override
  State<StatefulWidget> createState() => _DialState();
}

class _DialState extends State<Dial> with TickerProviderStateMixin {
  late AnimationController _animationController, _iconAnimationController;
  final List<Animation<double>> _dialChildAnimations = <Animation<double>>[];

  final Duration _animationDuration = Duration(milliseconds: 450);

  @override
  void initState() {
    _iconAnimationController = AnimationController(vsync: this, duration: _animationDuration);
    _animationController = AnimationController(vsync: this, duration: _animationDuration);
    _animationController.addListener(() {
      if (mounted) setState(() {});
    });

    final double fractionOfOneDialChild = 1.0 / widget.dialChildren.length;
    for (int speedDialChildIndex = 0; speedDialChildIndex < widget.dialChildren.length; ++speedDialChildIndex) {
      final List<TweenSequenceItem<double>> tweenSequenceItems = <TweenSequenceItem<double>>[];

      final double firstWeight = fractionOfOneDialChild * speedDialChildIndex;
      if (firstWeight > 0.0) {
        tweenSequenceItems.add(TweenSequenceItem<double>(
          tween: ConstantTween<double>(0.0),
          weight: firstWeight,
        ));
      }

      tweenSequenceItems.add(TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0.0, end: 1.0),
        weight: fractionOfOneDialChild,
      ));

      final double lastWeight = fractionOfOneDialChild * (widget.dialChildren.length - 1 - speedDialChildIndex);
      if (lastWeight > 0.0) {
        tweenSequenceItems.add(TweenSequenceItem<double>(tween: ConstantTween<double>(1.0), weight: lastWeight));
      }

      _dialChildAnimations.insert(0, TweenSequence<double>(tweenSequenceItems).animate(_animationController));
    }

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int dialChildAnimationIndex = 0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        if (!_animationController.isDismissed)
          Padding(
            padding: const EdgeInsets.only(right: Margins.margin4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: widget.dialChildren.map<Widget>((DialChild dialChild) {
                final Widget dialChildWidget = Opacity(
                  opacity: _dialChildAnimations[dialChildAnimationIndex].value,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ScaleTransition(
                        scale: _dialChildAnimations[dialChildAnimationIndex],
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: Margins.margin4),
                          child: FloatingActionButton(
                            heroTag: dialChildAnimationIndex,
                            mini: true,
                            child: dialChild.child,
                            onPressed: () => _onTap(dialChild),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
                dialChildAnimationIndex++;
                return dialChildWidget;
              }).toList(),
            ),
          ),
        Padding(
          padding: const EdgeInsets.only(top: Margins.margin8),
          child: FloatingActionButton(
            child: AnimatedIcon(
              icon: widget.icon,
              color: widget.color,
              progress: _iconAnimationController
            ),
            onPressed: () {
              if (_animationController.isDismissed) {
                _animationController.forward();
                _iconAnimationController.forward();
              } else {
                _animationController.reverse();
                _iconAnimationController.reverse();
              }
            },
          ),
        )
      ],
    );
  }

  // TODO: Test on tapped
  void _onTap(DialChild dialChild) {
    _animationController.reverse();
    dialChild.onPressed.call();
  }
}