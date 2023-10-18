import 'dart:io';
import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kanpractice/application/auth/auth_bloc.dart';
import 'package:kanpractice/application/purchases/purchases_bloc.dart';
import 'package:kanpractice/presentation/core/routing/pages.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';
import 'package:kanpractice/presentation/core/widgets/kp_button.dart';
import 'package:kanpractice/presentation/core/widgets/kp_pro_perks.dart';
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
                          customIcon: Padding(
                            padding: const EdgeInsets.only(
                                bottom: KPMargins.margin12),
                            child: Icon(
                                Platform.isAndroid
                                    ? FontAwesomeIcons.googlePlay
                                    : FontAwesomeIcons.appStore,
                                color: Colors.white),
                          ),
                          color: Colors.amber.shade700,
                          onTap: () {
                            state.maybeWhen(
                              loaded: (_) {
                                context
                                    .read<PurchasesBloc>()
                                    .add(PurchasesEventBuy(product));
                              },
                              orElse: () {
                                Navigator.of(context).pushNamed(
                                  KanPracticePages.loginPage,
                                  arguments: product,
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
            updatedToPro: () => const KPProPerks(),
            orElse: () => const Center(child: KPProgressIndicator()),
          );
        },
      ),
    );
  }
}
