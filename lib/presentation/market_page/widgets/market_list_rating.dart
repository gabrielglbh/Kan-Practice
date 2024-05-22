import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:kanpractice/application/rate/rate_bloc.dart';
import 'package:kanpractice/application/snackbar/snackbar_bloc.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

class MarketListRating extends StatelessWidget {
  final String listId;
  final double? initialRating;
  const MarketListRating({super.key, required this.listId, this.initialRating});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<RateBloc>(),
      child: BlocConsumer<RateBloc, RateState>(
        listener: (context, state) {
          state.mapOrNull(error: (error) {
            context.read<SnackbarBloc>().add(SnackbarEventShow(error.message));
          });
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
      itemSize: KPMargins.margin32,
      glow: false,
      itemBuilder: (context, _) => Icon(Icons.star_rounded,
          color: Theme.of(context).colorScheme.primary),
      onRatingUpdate: (rate) {
        context.read<RateBloc>().add(RateEventUpdate(listId, rate));
      },
    );
  }
}
