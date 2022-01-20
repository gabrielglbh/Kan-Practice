part of 'tutorial_bloc.dart';

abstract class TutorialEvent extends Equatable {
  const TutorialEvent();

  @override
  List<Object> get props => [];
}

class TutorialEventIdle extends TutorialEvent {}

class TutorialEventLoading extends TutorialEvent {
  final BuildContext context;

  TutorialEventLoading(this.context);

  @override
  List<Object> get props => [context];
}