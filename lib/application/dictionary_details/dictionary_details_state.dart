part of 'dictionary_details_bloc.dart';

class DictionaryDetailsState extends Equatable {
  const DictionaryDetailsState();

  @override
  List<Object?> get props => [];
}

class DictionaryDetailsStateLoaded extends DictionaryDetailsState {
  final KanjiData data;

  const DictionaryDetailsStateLoaded({required this.data});

  @override
  List<Object> get props => [data];
}

class DictionaryDetailsStateLoading extends DictionaryDetailsState {}

class DictionaryDetailsStateFailure extends DictionaryDetailsState {}
