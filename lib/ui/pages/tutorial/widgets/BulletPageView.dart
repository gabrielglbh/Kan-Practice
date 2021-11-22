import 'package:flutter/material.dart';
import 'package:kanpractice/ui/theme/consts.dart';

class BulletPageView extends StatefulWidget {
  final List<Widget> pageViewChildren;
  final int bullets;
  final double height;
  BulletPageView({
    required this.pageViewChildren,
    required this.bullets,
    required this.height});

  @override
  _BulletPageViewState createState() => _BulletPageViewState();
}

class _BulletPageViewState extends State<BulletPageView> {

  int _selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height / widget.height,
          child: PageView(
            scrollDirection: Axis.horizontal,
            children: widget.pageViewChildren,
            onPageChanged: (newPageIndex) => setState(() => _selectedPage = newPageIndex),
          ),
        ),
        Container(
          height: 15,
          alignment: Alignment.center,
          child: Center(
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: widget.bullets,
              itemBuilder: (context, i) => _bullet(i),
            ),
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
          color: _selectedPage == i ? CustomColors.secondaryColor : Colors.white60
        ),
      ),
    );
  }
}