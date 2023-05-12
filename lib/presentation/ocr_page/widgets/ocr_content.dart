import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/ocr_page/ocr_page_bloc.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/widgets/kp_progress_indicator.dart';
import 'package:kanpractice/presentation/ocr_page/widgets/image_canvas.dart';
import 'package:kanpractice/presentation/ocr_page/widgets/ocr_text_canvas.dart';

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
          alignment: Alignment.bottomRight,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width,
                maxHeight: MediaQuery.of(context).size.height / 1.6,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const ImageCanvas(),
                  state.maybeWhen(
                    imageLoaded: (text, _) => OCRTextCanvas(text: text),
                    translationLoaded: (translation) => SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(KPMargins.margin8),
                        child: Text(
                          translation,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                color: Colors.black,
                                backgroundColor: Colors.white70,
                                fontWeight: FontWeight.normal,
                              ),
                        ),
                      ),
                    ),
                    loading: () => const KPProgressIndicator(),
                    orElse: () => const SizedBox(),
                  ),
                ],
              ),
            ),
            state.maybeWhen(
              imageLoaded: (text, __) => Positioned(
                right: KPMargins.margin24,
                child: GestureDetector(
                  onTap: () {
                    context
                        .read<OCRPageBloc>()
                        .add(OCRPageEventTraverseText(text));
                  },
                  child: Container(
                    width: KPMargins.margin48,
                    height: KPMargins.margin48,
                    margin: const EdgeInsets.only(bottom: KPMargins.margin16),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: KPColors.secondaryColor,
                    ),
                    child: const Icon(Icons.text_format_rounded,
                        color: Colors.white),
                  ),
                ),
              ),
              orElse: () => const SizedBox(),
            ),
          ],
        );
      },
    );
  }
}
