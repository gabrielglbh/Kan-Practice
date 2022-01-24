part of 'tutorial_bloc.dart';

class TutorialState extends Equatable {
  const TutorialState();

  @override
  List<Object?> get props => [];
}

class TutorialStateIdle extends TutorialState {}

class TutorialStateLoading extends TutorialState {}

class TutorialStateLoaded extends TutorialState {}

class TutorialStateFailure extends TutorialState {}