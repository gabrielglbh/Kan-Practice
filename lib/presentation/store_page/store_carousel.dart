import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/store_page/widgets/context_carousel.dart';
import 'package:kanpractice/presentation/store_page/widgets/market_carousel.dart';
import 'package:kanpractice/presentation/store_page/widgets/ocr_carousel.dart';
import 'package:kanpractice/presentation/store_page/widgets/translation_carousel.dart';

class StoreCarousel extends StatefulWidget {
  const StoreCarousel({super.key});

  @override
  State<StoreCarousel> createState() => _StoreCarouselState();
}

class _StoreCarouselState extends State<StoreCarousel> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  List<Widget> _updates = [];

  String get _locale {
    final locale = WidgetsBinding.instance.window.locale.languageCode;
    if (locale != 'es' && locale != 'en') return 'en';
    return locale;
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _updates = [
          TranslationCarousel(locale: _locale),
          OCRCarousel(locale: _locale),
          ContextCarousel(locale: _locale),
          MarketCarousel(locale: _locale),
        ];
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: CarouselSlider(
            items: _updates,
            carouselController: _controller,
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height / 1.5,
              viewportFraction: 1,
              aspectRatio: 16 / 9,
              onPageChanged: (index, reason) {
                setState(() => _current = index);
              },
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _updates.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: KPMargins.margin8,
                height: KPMargins.margin8,
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: KPColors.getSecondaryColor(context)
                      .withOpacity(_current == entry.key ? 0.9 : 0.4),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
