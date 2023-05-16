import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/auth/auth_bloc.dart';
import 'package:kanpractice/application/purchases/purchases_bloc.dart';
import 'package:kanpractice/presentation/core/routing/pages.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';
import 'package:kanpractice/presentation/core/widgets/kp_button.dart';
import 'package:kanpractice/presentation/core/widgets/kp_markdown.dart';
import 'package:kanpractice/presentation/core/widgets/kp_progress_indicator.dart';
import 'package:kanpractice/presentation/core/widgets/kp_scaffold.dart';
import 'package:kanpractice/presentation/store_page/store_carousel.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  @override
  void initState() {
    super.initState();
    if (context.read<PurchasesBloc>().state is! PurchasesUpdatedToPro) {
      context.read<PurchasesBloc>().add(PurchasesEventLoadProducts());
    }
  }

  @override
  Widget build(BuildContext context) {
    return KPScaffold(
      appBarTitle: 'pro_version'.tr(),
      onWillPop: () {
        if (context.read<PurchasesBloc>().state is! PurchasesUpdatedToPro) {
          context.read<PurchasesBloc>().add(PurchasesEventDidNotPurchase());
        }
        return Future.value(true);
      },
      appBarActions: [
        BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return state.maybeWhen(
              loaded: (_) => BlocBuilder<PurchasesBloc, PurchasesState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    updatedToPro: () => const SizedBox(),
                    orElse: () => IconButton(
                      onPressed: () {
                        context
                            .read<PurchasesBloc>()
                            .add(PurchasesEventRestorePurchases());
                      },
                      icon: const Icon(Icons.restore),
                    ),
                  );
                },
              ),
              orElse: () => const SizedBox(),
            );
          },
        )
      ],
      child: BlocConsumer<PurchasesBloc, PurchasesState>(
        listener: (context, state) {
          state.mapOrNull(error: (e) {
            Utils.getSnackBar(context, e.message);
            context.read<PurchasesBloc>().add(PurchasesEventLoadProducts());
          }, nonPro: (_) {
            //Utils.getSnackBar(context, 'buy_error_3'.tr());
            context.read<PurchasesBloc>().add(PurchasesEventLoadProducts());
          });
        },
        builder: (context, state) {
          return state.maybeWhen(
            loaded: (products) {
              final product = products.first;
              return Padding(
                padding: const EdgeInsets.only(
                  bottom: KPMargins.margin16,
                  right: KPMargins.margin16,
                  left: KPMargins.margin16,
                ),
                child: Column(
                  children: [
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        return state.maybeWhen(
                          loaded: (_) => Row(
                            children: [
                              Expanded(
                                child: Text('store_restore'.tr()),
                              ),
                              const SizedBox(width: KPMargins.margin12),
                              Transform.rotate(
                                angle: -90 * (pi / 180),
                                child: Icon(
                                  Icons.subdirectory_arrow_right_rounded,
                                  color: KPColors.getSubtle(context),
                                ),
                              ),
                            ],
                          ),
                          orElse: () => Text('pro_login_disclaimer'.tr()),
                        );
                      },
                    ),
                    Icon(
                      Icons.local_play_rounded,
                      color: KPColors.getSecondaryColor(context),
                      size: 100,
                    ),
                    const Divider(),
                    const Expanded(child: StoreCarousel()),
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        return KPButton(
                          title2:
                              '${'upgrade_to_pro'.tr()} ${product.priceString} ${product.currencyCode}',
                          icon: Icons.shopping_cart_checkout_rounded,
                          color: Colors.amber.shade700,
                          onTap: () {
                            state.maybeWhen(
                              loaded: (_) {
                                context
                                    .read<PurchasesBloc>()
                                    .add(PurchasesEventBuy(product.identifier));
                              },
                              orElse: () {
                                Navigator.of(context).pushNamed(
                                  KanPracticePages.loginPage,
                                  arguments: product.identifier,
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              );
            },
            updatedToPro: () {
              final dash = Padding(
                padding: const EdgeInsets.only(
                  top: KPMargins.margin8,
                  bottom: KPMargins.margin8,
                  left: KPMargins.margin8,
                ),
                child: Text(
                  '✅',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              );
              final theme = Theme.of(context).textTheme.bodyLarge;
              return Padding(
                padding: const EdgeInsets.only(
                  bottom: KPMargins.margin16,
                  right: KPMargins.margin12,
                  left: KPMargins.margin12,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.local_play_rounded,
                        color: KPColors.getSecondaryColor(context),
                        size: KPSizes.maxHeightValidationCircle,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(KPMargins.margin16),
                        child: Text("already_pro".tr(),
                            textAlign: TextAlign.center, style: theme),
                      ),
                      const SizedBox(height: KPMargins.margin24),
                      Flexible(
                        child: ListView(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                dash,
                                const SizedBox(width: KPMargins.margin8),
                                Flexible(
                                    child: KPMarkdown(
                                  data: "updated_pro_translation"
                                      .tr()
                                      .replaceAll('ChatGPT', '**ChatGPT**')
                                      .replaceAll('ML', '**ML**')
                                      .replaceAll('Google', '**Google**')
                                      .replaceAll('Kit', '**Kit**'),
                                  shrinkWrap: true,
                                )),
                              ],
                            ),
                            const SizedBox(height: KPMargins.margin12),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                dash,
                                const SizedBox(width: KPMargins.margin8),
                                Flexible(
                                    child: KPMarkdown(
                                  data: "updated_pro_ocr"
                                      .tr()
                                      .replaceAll('ML', '**ML**')
                                      .replaceAll('Google', '**Google**')
                                      .replaceAll('Kit', '**Kit**'),
                                  shrinkWrap: true,
                                )),
                              ],
                            ),
                            const SizedBox(height: KPMargins.margin12),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                dash,
                                const SizedBox(width: KPMargins.margin8),
                                Flexible(
                                    child: KPMarkdown(
                                  data: "updated_pro_context"
                                      .tr()
                                      .replaceAll('ChatGPT', '**ChatGPT**'),
                                  shrinkWrap: true,
                                )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            orElse: () => const Center(child: KPProgressIndicator()),
          );
        },
      ),
    );
  }
}
