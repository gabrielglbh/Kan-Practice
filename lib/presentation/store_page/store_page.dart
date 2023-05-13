import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/purchases/purchases_bloc.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';
import 'package:kanpractice/presentation/core/widgets/kp_button.dart';
import 'package:kanpractice/presentation/core/widgets/kp_progress_indicator.dart';
import 'package:kanpractice/presentation/core/widgets/kp_scaffold.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

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
      child: BlocConsumer<PurchasesBloc, PurchasesState>(
        listener: (context, state) {
          state.mapOrNull(error: (e) {
            Utils.getSnackBar(context, e.message);
            context.read<PurchasesBloc>().add(PurchasesEventLoadProducts());
          });
        },
        builder: (context, state) {
          return state.maybeWhen(
            loaded: (products) => _listOfProducts(products.first),
            updatedToPro: () => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.local_play_rounded,
                    color: KPColors.getSecondaryColor(context),
                    size: KPSizes.maxHeightValidationCircle / 1.5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(KPMargins.margin16),
                    child: Text("already_pro".tr(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge),
                  ),
                  const SizedBox(height: KPMargins.margin24),
                  Flexible(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.travel_explore_rounded, size: 32),
                        const SizedBox(width: KPMargins.margin12),
                        ShaderMask(
                          shaderCallback: (bounds) {
                            return const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.blue,
                                  Colors.green,
                                  Colors.yellow,
                                  Colors.red,
                                  Colors.purple
                                ]).createShader(bounds);
                          },
                          child: const Icon(Icons.camera,
                              color: Colors.white, size: 32),
                        ),
                        const SizedBox(width: KPMargins.margin12),
                        const Icon(Icons.psychology_outlined, size: 32),
                        const SizedBox(width: KPMargins.margin12),
                        Icon(Icons.g_translate_rounded,
                            color: Colors.amber.shade800, size: 32),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            loading: () => const Center(child: KPProgressIndicator()),
            orElse: () => const SizedBox(),
          );
        },
      ),
    );
  }

  Widget _listOfProducts(StoreProduct product) {
    final theme = Theme.of(context)
        .textTheme
        .titleLarge
        ?.copyWith(fontWeight: FontWeight.normal);
    return Padding(
      padding: const EdgeInsets.all(KPMargins.margin16),
      child: Column(
        children: [
          Icon(
            Icons.local_play_rounded,
            color: KPColors.getSecondaryColor(context),
            size: KPSizes.maxHeightValidationCircle / 1.5,
          ),
          const SizedBox(height: KPMargins.margin24),
          Expanded(
            child: Scrollbar(
              thumbVisibility: true,
              child: ListView(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.travel_explore_rounded, size: 32),
                      const SizedBox(width: KPMargins.margin12),
                      Flexible(
                          child: Text("pro_translation".tr(), style: theme)),
                    ],
                  ),
                  const SizedBox(height: KPMargins.margin12),
                  const Divider(),
                  const SizedBox(height: KPMargins.margin12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShaderMask(
                        shaderCallback: (bounds) {
                          return const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.blue,
                                Colors.green,
                                Colors.yellow,
                                Colors.red,
                                Colors.purple
                              ]).createShader(bounds);
                        },
                        child: const Icon(Icons.camera,
                            color: Colors.white, size: 32),
                      ),
                      const SizedBox(width: KPMargins.margin12),
                      Flexible(child: Text("pro_ocr".tr(), style: theme)),
                    ],
                  ),
                  const SizedBox(height: KPMargins.margin12),
                  const Divider(),
                  const SizedBox(height: KPMargins.margin12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.psychology_outlined, size: 32),
                      const SizedBox(width: KPMargins.margin12),
                      Flexible(child: Text("pro_context".tr(), style: theme)),
                    ],
                  ),
                  const SizedBox(height: KPMargins.margin12),
                  const Divider(),
                  const SizedBox(height: KPMargins.margin12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.g_translate_rounded,
                          color: Colors.amber.shade800, size: 32),
                      const SizedBox(width: KPMargins.margin12),
                      Flexible(
                          child: Text("pro_translation_market".tr(),
                              style: theme)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: KPMargins.margin24),
          KPButton(
            title2:
                '${'upgrade_to_pro'.tr()} ${product.priceString} ${product.currencyCode}',
            icon: Icons.shopping_cart_checkout_rounded,
            color: Colors.amber.shade700,
            onTap: () {
              context
                  .read<PurchasesBloc>()
                  .add(PurchasesEventBuy(product.identifier));
            },
          ),
        ],
      ),
    );
  }
}
