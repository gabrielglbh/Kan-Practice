import 'package:image/image.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/infrastructure/classifier/classifier_repository_impl.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';

part 'dict_event.dart';
part 'dict_state.dart';

@lazySingleton
class DictBloc extends Bloc<DictEvent, DictState> {
  DictBloc() : super(DictStateLoading()) {
    on<DictEventIdle>((_, __) {});

    on<DictEventStart>((event, emit) async {
      try {
        emit(DictStateLoading());

        /// Instantiate the classifier once the page has been animated in
        await Future.delayed(const Duration(milliseconds: 500), () async {
          await getIt<ClassifierRepositoryImpl>().loadModel();
        });
        emit(const DictStateLoaded());
      } on Exception {
        emit(DictStateFailure());
      }
    });

    on<DictEventLoading>((event, emit) async {
      try {
        emit(DictStateLoading());
        List<Category> categories =
            getIt<ClassifierRepositoryImpl>().predict(event.image);
        categories =
            categories.getRange(0, KPSizes.numberOfPredictedKanji).toList();
        emit(DictStateLoaded(categories));
      } on Exception {
        emit(DictStateFailure());
      }
    });
  }
}
