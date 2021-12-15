import 'package:flutter/material.dart';
import 'package:kanpractice/ui/theme/consts.dart';

class BulletPageView extends StatefulWidget {
  final List<Widget> pageViewChildren;
  final int bullets;
  final Function(int) onChanged;
  BulletPageView({
    required this.pageViewChildren,
    required this.bullets,
    required this.onChanged
  });

  @override
  _BulletPageViewState createState() => _BulletPageViewState();
}

class _BulletPageViewState extends State<BulletPageView> {

  int _selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: MediaQuery.of(context).size.height - (Margins.margin64*2),
          child: PageView(
            scrollDirection: Axis.horizontal,
            children: widget.pageViewChildren,
            onPageChanged: (newPageIndex) {
              widget.onChanged(newPageIndex);
              setState(() => _selectedPage = newPageIndex);
            },
          ),
        ),
        Container(
          height: 15,
          alignment: Alignment.center,
          margin: EdgeInsets.only(bottom: Margins.margin16),
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: widget.bullets,
            itemBuilder: (context, i) => _bullet(i),
          )
        ),
      ],
    );
  }

  Padding _bullet(int i) {
    return Padding(
      padding: EdgeInsets.all(2),
      child: Container(
        width: 16, height: 16,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _selectedPage == i ? CustomColors.secondaryColor : CustomColors.secondarySubtleColor
        ),
      ),
    );
  }
}