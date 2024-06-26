import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kanpractice/domain/list/list.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

class KPSearchBar extends StatefulWidget {
  /// Action to perform when the query is ready to be searched on the db
  final Function(String) onQuery;

  /// Action to perform when the user exits the search, usually load all lists
  final Function onExitSearch;

  /// Hint text to show on the search bar when not used
  final String hint;

  /// [FocusNode] of the search bar created in the parent widget
  final FocusNode? focus;

  /// Padding to apply to the search bar, defaults to 8
  final double top, bottom, right, left;
  final TextEditingController? controller;
  const KPSearchBar(
      {super.key,
      required this.onQuery,
      required this.onExitSearch,
      required this.hint,
      required this.focus,
      this.top = 0,
      this.bottom = 0,
      this.left = KPMargins.margin8,
      this.right = KPMargins.margin8,
      this.controller});

  @override
  State<KPSearchBar> createState() => _KPSearchBarState();
}

class _KPSearchBarState extends State<KPSearchBar> {
  TextEditingController? _controller;

  final List<WordList> _filteredLists = [];
  bool _hasFocus = false;
  bool _showCursor = false;

  @override
  void initState() {
    _controller = widget.controller ?? TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    if (widget.controller == null) _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
            left: widget.left,
            right: widget.right,
            top: widget.top,
            bottom: widget.bottom),
        child: Column(children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(bottom: KPMargins.margin8),
              child: _searchBar())
        ]));
  }

  Stack _searchBar() {
    return Stack(
      children: <Widget>[
        TextField(
          controller: _controller,
          textInputAction: TextInputAction.search,
          focusNode: widget.focus,
          textCapitalization: TextCapitalization.sentences,
          showCursor: _showCursor,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(
                  top: KPMargins.margin24,
                  bottom: KPMargins.margin16,
                  left: KPMargins.margin48,
                  right: KPMargins.margin48),
              hintText: widget.hint,
              filled: false),
          onTap: () {
            setState(() {
              _hasFocus = true;
              _showCursor = true;
            });
          },
          onChanged: (query) {
            if (query.length >= 3) {
              _filterValues(_controller?.text);
            } else {
              setState(() => _filteredLists.clear());
            }
          },
          onEditingComplete: () {
            _filterValues(_controller?.text);
            _hideKeyboard();
          },
        ),
        Positioned(bottom: KPMargins.margin8, left: 0, child: _back()),
        Visibility(
          visible: _hasFocus,
          child: Positioned(
            bottom: KPMargins.margin8,
            right: 0,
            child: _clear(),
          ),
        ),
      ],
    );
  }

  SizedBox _back() {
    return SizedBox(
        width: KPSizes.defaultSizeSearchBarIcons,
        height: KPSizes.defaultSizeSearchBarIcons,
        child: InkWell(
          borderRadius: BorderRadius.circular(KPRadius.radius32),
          onTap: () {
            if (_hasFocus) {
              widget.onExitSearch();
              widget.focus?.unfocus();
              setState(() {
                _clearSearch();
                _hasFocus = false;
              });
            }
          },
          child: _hasFocus
              ? const Icon(Icons.arrow_left)
              : const Icon(Icons.search),
        ));
  }

  SizedBox _clear() {
    return SizedBox(
        width: KPSizes.defaultSizeSearchBarIcons,
        height: KPSizes.defaultSizeSearchBarIcons,
        child: InkWell(
          borderRadius: BorderRadius.circular(KPRadius.radius32),
          onTap: () {
            setState(() {
              _clearSearch();
            });
          },
          child: const Icon(Icons.clear),
        ));
  }

  _filterValues(String? q) async {
    if (q != null && q.trim().isNotEmpty) widget.onQuery(q);
  }

  _hideKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  _clearSearch({bool onCreatingSomething = true}) {
    _controller?.clear();
    if (!onCreatingSomething) {
      widget.focus?.unfocus();
      setState(() {
        _hasFocus = false;
      });
    }
  }
}
