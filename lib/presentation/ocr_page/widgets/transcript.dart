import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/ocr_page/ocr_page_bloc.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/ocr_page/widgets/transcript_context_menu.dart';

class Transcript extends StatefulWidget {
  final String text;
  const Transcript({super.key, required this.text});

  @override
  State<Transcript> createState() => _TranscriptState();
}

class _TranscriptState extends State<Transcript> {
  final _textEditingController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    _textEditingController.text = widget.text;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OCRPageBloc, OCRPageState>(
      listener: (context, ocrState) {
        ocrState.mapOrNull(
          imageLoaded: (i) {
            _textEditingController.text = i.text;
          },
        );
      },
      child: SingleChildScrollView(
        child: TextField(
          controller: _textEditingController,
          focusNode: _focusNode,
          cursorColor: Theme.of(context).colorScheme.primary,
          maxLines: null,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: Colors.black,
                backgroundColor: Colors.grey.shade100.withOpacity(.8),
                fontWeight: FontWeight.normal,
                height: 1.2,
              ),
          decoration: const InputDecoration(
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            contentPadding: EdgeInsets.all(KPMargins.margin8),
          ),
          onTapOutside: (event) {
            context
                .read<OCRPageBloc>()
                .add(OCRPageEventShowUpdateText(_textEditingController.text));
          },
          contextMenuBuilder: ((context, editableTextState) {
            final ts = editableTextState.currentTextEditingValue.selection;
            final selectedText = editableTextState.currentTextEditingValue.text
                .substring(ts.baseOffset, ts.extentOffset);
            final anchor = editableTextState.contextMenuAnchors.primaryAnchor;

            return TranscriptContextMenu(
                anchor: anchor, selectedText: selectedText);
          }),
        ),
      ),
    );
  }
}
