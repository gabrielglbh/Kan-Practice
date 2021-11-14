import 'package:flutter/material.dart';

import '../kanji_painter.dart';

class CustomCanvas extends StatefulWidget {
  /// List of [Offset] points to draw over the canvas
  final List<Offset?> line;
  /// Whether to allow the user to paint or not
  final bool allowEdit;
  /// Value to subtract to the height of the parent to the canvas
  final double fatherPadding;
  const CustomCanvas({required this.line, this.allowEdit = true, required this.fatherPadding});

  @override
  _CustomCanvasState createState() => _CustomCanvasState();
}

class _CustomCanvasState extends State<CustomCanvas> {
  /// In charge of keeping the indexes on the widget line for removal
  List<int> _lineIndex = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width - widget.fatherPadding,
      child: Stack(
        children: [
          GestureDetector(
            onPanStart: _onPanStart,
            onPanUpdate: _onPanUpdate,
            onPanEnd: _onPanEnd,
            child: RepaintBoundary(
              /// To contain the CustomPaint inside the Container
              child: ClipRect(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: Colors.yellow[100],
                  ),
                  child: CustomPaint(
                    painter: KanjiPainter(
                      points: widget.line,
                      size: MediaQuery.of(context).size.width - widget.fatherPadding
                    ),
                    size: Size.square(MediaQuery.of(context).size.width),
                  )
                ),
              )
            ),
          ),
          Visibility(
            visible: widget.allowEdit,
            child: Positioned(
              top: 8, left: 16,
              child: GestureDetector(
                onTap: () => _undoLine(),
                child: Container(
                  height: 50, width: 50,
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(18)
                  ),
                  child: Icon(Icons.undo_rounded, size: 32, color: Colors.black),
                ),
              )
            ),
          ),
          Visibility(
            visible: widget.allowEdit,
            child: Positioned(
              top: 8, right: 16,
              child: GestureDetector(
                onTap: () => _clear(),
                child: Container(
                  height: 50, width: 50,
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(18)
                  ),
                  child: Icon(Icons.redo_rounded, size: 32, color: Colors.black),
                ),
              )
            ),
          )
        ],
      ),
    );
  }

  _onPanStart(DragStartDetails details) {
    if (widget.allowEdit) {
      final box = context.findRenderObject() as RenderBox;
      final point = box.globalToLocal(details.globalPosition);
      setState(() => widget.line.add(point));
      _lineIndex.add(widget.line.indexOf(point));
    }
  }

  _onPanUpdate(DragUpdateDetails details) {
    if (widget.allowEdit) {
      final box = context.findRenderObject() as RenderBox;
      final point = box.globalToLocal(details.globalPosition);
      setState(() => widget.line.add(point));
    }
  }

  _onPanEnd(DragEndDetails details) {
    if (widget.allowEdit) setState(() => widget.line.add(null));
  }

  _clear() => setState(() => widget.line.clear());

  _undoLine() {
    int currentLines = _lineIndex.length - 1;
    if (currentLines >= 0) {
      final int start = _lineIndex[currentLines];
      final int end = widget.line.length;
      setState(() => widget.line.removeRange(start, end));
      _lineIndex.removeLast();
    }
  }
}
