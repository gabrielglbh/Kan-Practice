import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:image/image.dart' as im;
import 'package:flutter/material.dart';
import 'package:kanpractice/ui/theme/consts.dart';

import 'kanji_painter.dart';

class CustomCanvas extends StatefulWidget {
  /// List of [Offset] points to draw over the canvas
  final List<Offset?> line;
  /// Whether to allow the user to paint or not
  final bool allowEdit;
  /// Whether the canvas allow to predict the drawn kanji or not
  final bool allowPrediction;
  /// Function to perform when the [im.Image] has been extracted
  final Function(im.Image)? handleImage;
  const CustomCanvas({required this.line, this.allowEdit = true, this.allowPrediction = false,
    this.handleImage
  });

  @override
  _CustomCanvasState createState() => _CustomCanvasState();
}

class _CustomCanvasState extends State<CustomCanvas> {
  /// In charge of keeping the indexes on the widget line for removal
  List<int> _lineIndex = [];

  Future<void> _convertCanvasToImage(List<Offset?> points) async {
    final canvasSize = MediaQuery.of(context).size.width;
    final ui.PictureRecorder recorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(recorder, Rect.fromPoints(
      Offset(0, 0), Offset(canvasSize, canvasSize)));
    final Paint paint = KanjiPainter.kanjiPaint;

    /// Repaints again the _line of Offsets in a new Canvas to get the proper
    /// picture with PictureRecorder
    for (int i = 0; i < points.length - 1; i++) {
      Offset? prev = points[i];
      Offset? next = points[i + 1];
      if (prev != null && next != null) canvas.drawLine(prev, next, paint);
    }

    /// Transforms the ui.Image to a im.Image to feed to the tflite model
    final ui.Picture picture = recorder.endRecording();
    final ui.Image img = await picture.toImage(canvasSize.toInt(), canvasSize.toInt());
    final ByteData? byteData = await img.toByteData(format: ui.ImageByteFormat.png);
    if (byteData != null) {
      im.Image? image = im.decodeImage(byteData.buffer.asUint8List());
      if (image != null) {
        if (widget.handleImage != null) widget.handleImage!(image);
        else print('Function handleImage is null');
      }
      else print('Image is null');
    }
    else print('ByteData is null');
  }

  @override
  Widget build(BuildContext context) {
    /// We subtract 32 padding to the size as we have an inherent 16 - 16
    /// padding on the sides on the parent
    final double size = MediaQuery.of(context).size.width - Margins.margin32;
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
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.grey[300] : Colors.grey[600],
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
          _actionIcon(action: () => _undoLine(), icon: Icons.undo_rounded, right: null),
          _actionIcon(action: () => _clear(), icon: Icons.redo_rounded, left: null),
        ],
      ),
    );
  }

  _actionIcon({required Function() action, required IconData icon,
    double? left = Margins.margin16, double? right = Margins.margin16}) {
    return Visibility(
      visible: widget.allowEdit,
      child: Positioned(
        top: Margins.margin8, left: left, right: right,
        child: GestureDetector(
          onTap: action,
          child: Container(
            height: CustomSizes.defaultSizeSearchBarIcons,
            width: CustomSizes.defaultSizeSearchBarIcons,
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.white : Colors.black,
              borderRadius: BorderRadius.circular(CustomRadius.radius16)
            ),
            child: Icon(icon, size: FontSizes.fontSize32,
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.black : Colors.white),
          )
        )
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
    if (widget.allowPrediction) _convertCanvasToImage(widget.line);
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
    if (widget.allowPrediction) _convertCanvasToImage(widget.line);
  }
}
