import 'package:image/image.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kanpractice/core/tflite/classifier.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';

part 'dict_event.dart';
part 'dict_state.dart';

class DictBloc extends Bloc<DictEvent, DictState> {
  DictBloc() : super(DictStateLoading()) {
    late Classifier model;
    on<DictEventIdle>((_, __) {});

    on<DictEventStart>((event, emit) async {
      try {
        emit(DictStateLoading());

        /// Instantiate the classifier once the page has been animated in
        await Future.delayed(const Duration(milliseconds: 500), () {
          model = Classifier();
        });
        emit(const DictStateLoaded());
      } on Exception {
        emit(DictStateFailure());
      }
    });

    on<DictEventLoading>((event, emit) async {
      try {
        emit(DictStateLoading());
        List<Category> categories = model.predict(event.image);
        categories =
            categories.getRange(0, CustomSizes.numberOfPredictedKanji).toList();
        emit(DictStateLoaded(categories));
      } on Exception {
        emit(DictStateFailure());
      }
    });
  }
}
