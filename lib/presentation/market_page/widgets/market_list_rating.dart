import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:kanpractice/application/rate/rate_bloc.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';

class MarketListRating extends StatelessWidget {
  final String listId;
  final double? initialRating;
  const MarketListRating({Key? key, required this.listId, this.initialRating})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RateBloc, RateState>(
      listener: (context, state) {
        if (state is RateStateFailure) {
          Utils.getSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        return _rateSystem(context, initialRating ?? 0);
      },
    );
  }

  Widget _rateSystem(BuildContext context, double r) {
    return RatingBar.builder(
      initialRating: r,
      minRating: 0,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemSize: KPMargins.margin32,
      glow: false,
      itemBuilder: (context, _) =>
          const Icon(Icons.star_rounded, color: KPColors.secondaryColor),
      onRatingUpdate: (rate) {
        getIt<RateBloc>().add(RateEventUpdate(listId, rate));
      },
    );
  }
}
