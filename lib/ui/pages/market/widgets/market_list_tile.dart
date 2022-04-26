import 'package:flutter/material.dart';
import 'package:kanpractice/core/firebase/models/market_list.dart';

class MarketListTile extends StatelessWidget {
  final MarketList list;
  final Function()? onDownload;
  final Function()? onRating;
  const MarketListTile({
    Key? key,
    required this.list,
    this.onDownload,
    this.onRating
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
