part of 'rate_bloc.dart';

abstract class RateEvent extends Equatable {
  const RateEvent();

  @override
  List<Object> get props => [];
}

class RateEventUpdate extends RateEvent {
  final String id;
  final double rate;

  const RateEventUpdate(this.id, this.rate);

  @override
  List<Object> get props => [id, rate];
}
