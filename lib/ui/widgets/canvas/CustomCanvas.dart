import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:kanpractice/ui/theme/consts.dart';
import 'package:kanpractice/ui/widgets/CustomButton.dart';

import 'kanji_painter.dart';

class CustomCanvas extends StatefulWidget {
  /// List of [Offset] points to draw over the canvas
  final List<Offset?> line;
  /// Whether to allow the user to paint or not
  final bool allowEdit;
  /// Whether the canvas allow to predict the drawn kanji or not
  final bool allowPrediction;
  const CustomCanvas({required this.line, this.allowEdit = true, this.allowPrediction = false});

  @override
  _CustomCanvasState createState() => _CustomCanvasState();
}

class _CustomCanvasState extends State<CustomCanvas> {
  /// In charge of keeping the indexes on the widget line for removal
  List<int> _lineIndex = [];

  Future<ByteData?> _saveToImage(List<Offset?> points) async {
    final canvasSize = MediaQuery.of(context).size.width;
    final ui.PictureRecorder recorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(recorder, Rect.fromPoints(
      Offset(0, 0), Offset(canvasSize, canvasSize)));
    final Paint paint = KanjiPainter.kanjiPaint;

    for (int i = 0; i < points.length - 1; i++) {
      Offset? prev = points[i];
      Offset? next = points[i + 1];
      if (prev != null && next != null) canvas.drawLine(prev, next, paint);
    }

    final ui.Picture picture = recorder.endRecording();
    final ui.Image img = await picture.toImage(canvasSize.toInt(), canvasSize.toInt());
    return await img.toByteData(format: ui.ImageByteFormat.png);
  }

  @override
  Widget build(BuildContext context) {
    /// We subtract 32 padding to the size as we have an inherent 16 - 16
    /// padding on the sides on the parent
    final double size = MediaQuery.of(context).size.width - Margins.margin16;
    return Container(
      width: size,
      height: size,
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
                    borderRadius: BorderRadius.circular(CustomRadius.radius16),
                    color: Colors.yellow[100],
                  ),
                  child: CustomPaint(
                    painter: KanjiPainter(
                      points: widget.line,
                      size: size
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
              top: Margins.margin8, left: Margins.margin16,
              child: GestureDetector(
                onTap: () => _undoLine(),
                child: Container(
                  height: CustomSizes.defaultSizeSearchBarIcons,
                  width: CustomSizes.defaultSizeSearchBarIcons,
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(CustomRadius.radius16)
                  ),
                  child: Icon(Icons.undo_rounded, size: FontSizes.fontSize32, color: Colors.black),
                ),
              )
            ),
          ),
          Visibility(
            visible: widget.allowEdit,
            child: Positioned(
              top: Margins.margin8, right: Margins.margin16,
              child: GestureDetector(
                onTap: () => _clear(),
                child: Container(
                  height: CustomSizes.defaultSizeSearchBarIcons,
                  width: CustomSizes.defaultSizeSearchBarIcons,
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(CustomRadius.radius16)
                  ),
                  child: Icon(Icons.redo_rounded, size: FontSizes.fontSize32, color: Colors.black),
                ),
              )
            ),
          ),
          Visibility(
            visible: widget.allowPrediction,
            child: Positioned(
              bottom: 0,
              right: MediaQuery.of(context).size.width / 3,
              left: MediaQuery.of(context).size.width / 3,
              child: CustomButton(
                onTap: () async => await _saveToImage(widget.line),
                title2: 'Search',
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
