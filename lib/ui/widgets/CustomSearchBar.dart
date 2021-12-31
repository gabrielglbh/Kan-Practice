import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kanpractice/core/database/models/list.dart';
import 'package:kanpractice/ui/theme/consts.dart';

class CustomSearchBar extends StatefulWidget {
  /// Action to perform when the query is ready to be searched on the db
  final Function(String) onQuery;
  /// Action to perform when the user exits the search, usually load all lists
  final Function onExitSearch;
  /// Hint text to show on the search bar when not used
  final String hint;
  /// [TextEditingController] in case the parent widget wants to handle it itself
  final TextEditingController? controller;
  /// [FocusNode] of the search bar created in the parent widget
  final FocusNode? focus;
  /// Padding to apply to the search bar, defaults to 8
  final double top, bottom, right, left;
  final bool enabled;
  CustomSearchBar({
    required this.onQuery,
    required this.onExitSearch,
    required this.hint,
    required this.focus,
    this.controller,
    this.top = Margins.margin8,
    this.bottom = 0,
    this.left = Margins.margin8,
    this.right = Margins.margin8,
    this.enabled = true
  });

  @override
  _CustomSearchBarState createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  TextEditingController? _controller;

  List<KanjiList> _filteredLists = [];
  bool _hasFocus = false;
  bool _showCursor = false;

  @override
  void initState() {
    if (widget.controller == null) _controller = TextEditingController();
    else _controller = widget.controller;
    super.initState();
  }

  @override
  void dispose() {
    if (widget.controller == null) _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(
          left: widget.left, right: widget.right,
          top: widget.top, bottom: widget.bottom
        ),
        child: Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: Margins.margin8),
            child: _searchBar()
          )
        ])
      )
    );
  }

  Stack _searchBar() {
    return Stack(children: <Widget>[
      TextField(
        controller: _controller,
        textInputAction: TextInputAction.search,
        focusNode: widget.focus,
        textCapitalization: TextCapitalization.sentences,
        showCursor: _showCursor,
        enabled: widget.enabled,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(
              top: Margins.margin24, bottom: Margins.margin16,
              left: Margins.margin48, right: Margins.margin48
          ),
          hintText: widget.hint,
          filled: false
        ),
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
      Positioned(
          bottom: Margins.margin4,
          left: 0,
          child: _back()
      ),
      Visibility(
        visible: _hasFocus,
        child: Positioned(
          bottom: Margins.margin4,
          right: 0,
          child: _clear(),
        ),
      ),
    ],
    );
  }

  Container _back() {
    return Container(
      width: CustomSizes.defaultSizeSearchBarIcons,
      height: CustomSizes.defaultSizeSearchBarIcons,
      child: InkWell(
        borderRadius: BorderRadius.circular(CustomRadius.radius32),
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
        child: _hasFocus ? Icon(Icons.arrow_left) : Icon(Icons.search),
      )
    );
  }

  Container _clear() {
    return Container(
      width: CustomSizes.defaultSizeSearchBarIcons,
      height: CustomSizes.defaultSizeSearchBarIcons,
      child: InkWell(
        borderRadius: BorderRadius.circular(CustomRadius.radius32),
        onTap: () {
          setState(() {
            _clearSearch();
          });
        },
        child: Icon(Icons.clear),
      )
    );
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