import 'package:flutter/material.dart';
import 'package:kanpractice/ui/widgets/kp_scaffold.dart';
import 'package:kanpractice/ui/widgets/kp_search_bar.dart';

class MarketPlace extends StatelessWidget {
  const MarketPlace({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KPScaffold(
      appBarTitle: "Market Place",
      appBarActions: [
        IconButton(
          onPressed: () {
            // TODO: Add list: Show BS of KanLists and select
          },
          icon: const Icon(Icons.add)
        )
      ],
      child: Column(
        children: [
          KPSearchBar(
            onQuery: (q) {
              // TODO: Algolia?
            },
            onExitSearch: () {

            },
            hint: "Search for lists",
            focus: FocusNode()
          ),

        ],
      )
    );
  }
}
