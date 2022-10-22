import 'package:flutter/material.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

class KPScaffold extends StatelessWidget {
  /// Should be [Widget] or [String]
  final dynamic appBarTitle;
  final List<Widget>? appBarActions;
  final Future<bool> Function()? onWillPop;
  final Widget child;
  final Widget? floatingActionButton;
  final bool? centerTitle;
  final double toolbarHeight;
  final bool automaticallyImplyLeading;
  final bool resizeToAvoidBottomInset;
  final Widget? bottomNavigationWidget;

  /// For the KPCanvas. Defaults to true to properly dismiss keyboard instances
  /// across the app.
  ///
  /// Can be set to false when KPCanvas is used as it uses GestureDetector to function
  /// and this one overrides it.
  final bool setGestureDetector;
  const KPScaffold(
      {Key? key,
      required this.appBarTitle,
      this.appBarActions,
      this.onWillPop,
      required this.child,
      this.floatingActionButton,
      this.centerTitle = false,
      this.toolbarHeight = KPSizes.appBarHeight,
      this.automaticallyImplyLeading = true,
      this.resizeToAvoidBottomInset = false,
      this.bottomNavigationWidget,
      this.setGestureDetector = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        appBar: AppBar(
          toolbarHeight: toolbarHeight,
          automaticallyImplyLeading: automaticallyImplyLeading,
          title: appBarTitle is String
              ? FittedBox(fit: BoxFit.fitWidth, child: Text(appBarTitle))
              : appBarTitle is Widget
                  ? appBarTitle
                  : const Text(""),
          actions: appBarActions,
          centerTitle: centerTitle,
        ),
        body: SafeArea(
          child: setGestureDetector
              ? GestureDetector(
                  /// Remove keyboard on touch anywhere else
                  onTap: () => FocusManager.instance.primaryFocus?.unfocus(),

                  /// Dismiss keyboard if possible whenever a vertical or horizontal
                  /// drag down occurs on screen
                  onVerticalDragStart: (details) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  onHorizontalDragStart: (details) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  child: _child(),
                )
              : _child(),
        ),
        bottomNavigationBar: bottomNavigationWidget,
        floatingActionButton: floatingActionButton,
      ),
    );
  }

  Widget _child() => Padding(
      padding: const EdgeInsets.symmetric(horizontal: KPMargins.margin8),
      child: child);
}
