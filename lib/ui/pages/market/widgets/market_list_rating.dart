import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:kanpractice/ui/general_utils.dart';
import 'package:kanpractice/ui/pages/market/rate_bloc/rate_bloc.dart';
import 'package:kanpractice/ui/consts.dart';

class MarketListRating extends StatelessWidget {
  final String listId;
  final double? initialRating;
  const MarketListRating({Key? key, required this.listId, this.initialRating})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RateBloc>(
      create: (_) => RateBloc()..add(RateEventIdle()),
      child: BlocConsumer<RateBloc, RateState>(
        listener: (context, state) {
          if (state is RateStateFailure) {
            GeneralUtils.getSnackBar(context, state.message);
          }
        },
        builder: (context, state) {
          return _rateSystem(context, initialRating ?? 0);
        },
      ),
    );
  }

  Widget _rateSystem(BuildContext context, double r) {
    return RatingBar.builder(
      initialRating: r,
      minRating: 0,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemSize: Margins.margin32,
      glow: false,
      itemBuilder: (context, _) =>
          const Icon(Icons.star_rounded, color: CustomColors.secondaryColor),
      onRatingUpdate: (rate) {
        context.read<RateBloc>().add(RateEventUpdate(listId, rate));
      },
    );
  }
}
