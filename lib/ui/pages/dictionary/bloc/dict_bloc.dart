import 'package:image/image.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kanpractice/core/tflite/classifier.dart';
import 'package:kanpractice/ui/theme/consts.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';

part 'dict_event.dart';
part 'dict_state.dart';

class DictBloc extends Bloc<DictEvent,DictState> {
  DictBloc() : super(DictStateLoading()) {
    late Classifier model;
    on<DictEventIdle>((event, emit) async {
      try {
        model = Classifier();
      } on Exception {
        emit(DictStateFailure());
      }
    });

    on<DictEventLoading>((event, emit) async {
      try {
        emit(DictStateLoading());
        List<Category> categories = model.predict(event.image);
        List<String> predictions = [];
        categories = categories.getRange(0, CustomSizes.numberOfPredictedKanji).toList();
        categories.forEach((cat) => predictions.add(cat.label));
        emit(DictStateLoaded(predictions));
      } on Exception {
        emit(DictStateFailure());
      }
    });
  }
}