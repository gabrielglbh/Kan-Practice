import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/ocr_page/ocr_page_bloc.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/widgets/kp_progress_indicator.dart';
import 'package:kanpractice/presentation/ocr_page/widgets/image_canvas.dart';
import 'package:kanpractice/presentation/ocr_page/widgets/transcript.dart';

class OCRContent extends StatefulWidget {
  const OCRContent({super.key});

  @override
  State<OCRContent> createState() => _OCRContentState();
}

class _OCRContentState extends State<OCRContent> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OCRPageBloc, OCRPageState>(
      builder: (context, state) {
        return Stack(
          alignment: Alignment.center,
          children: [
            const ImageCanvas(),
            state.maybeWhen(
              imageLoaded: (text, __) => Transcript(text: text),
              translationLoaded: (translation, __) => SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(KPMargins.margin8),
                  child: Text(
                    translation,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.black,
                          backgroundColor: Colors.grey.shade100.withOpacity(.8),
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                ),
              ),
              loading: () => const KPProgressIndicator(),
              orElse: () => const SizedBox(),
            ),
          ],
        );
      },
    );
  }
}
