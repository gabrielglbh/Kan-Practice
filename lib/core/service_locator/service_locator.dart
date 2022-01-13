import 'package:get_it/get_it.dart';
import 'package:kanpractice/ui/pages/backup/bloc/backup_bloc.dart';
import 'package:kanpractice/ui/pages/dictionary/bloc/dict_bloc.dart';
import 'package:kanpractice/ui/pages/firebase_login/bloc/login_bloc.dart';
import 'package:kanpractice/ui/pages/jisho/bloc/jisho_bloc.dart';
import 'package:kanpractice/ui/pages/kanji_list_details/bloc/details_bloc.dart';
import 'package:kanpractice/ui/pages/kanji_lists/bloc/lists_bloc.dart';
import 'package:kanpractice/ui/pages/settings/bloc/settings_bloc.dart';
import 'package:kanpractice/ui/pages/test_history/bloc/test_bloc.dart';
import 'package:kanpractice/ui/widgets/kanji_bottom_sheet/bloc/kanji_bs_bloc.dart';

final GetIt getIt = GetIt.I;

init() {
  getIt
    /*..registerFactory<KanjiListBloc>(() => KanjiListBloc())
    ..registerFactory<KanjiListDetailBloc>(() => KanjiListDetailBloc())
    ..registerFactory<DictBloc>(() => DictBloc())
    ..registerFactory<JishoBloc>(() => JishoBloc())
    ..registerFactory<KanjiBSBloc>(() => KanjiBSBloc())
    ..registerFactory<SettingsBloc>(() => SettingsBloc())
    ..registerFactory<BackUpBloc>(() => BackUpBloc())
    ..registerFactory<LoginBloc>(() => LoginBloc())
    ..registerFactory<TestListBloc>(() => TestListBloc());*/
    ..registerLazySingleton<KanjiListBloc>(() => KanjiListBloc())
    ..registerFactory<KanjiListDetailBloc>(() => KanjiListDetailBloc())
    ..registerFactory<DictBloc>(() => DictBloc())
    ..registerFactory<JishoBloc>(() => JishoBloc())
    ..registerFactory<KanjiBSBloc>(() => KanjiBSBloc())
    ..registerFactory<SettingsBloc>(() => SettingsBloc())
    ..registerFactory<BackUpBloc>(() => BackUpBloc())
    ..registerLazySingleton<LoginBloc>(() => LoginBloc())
    ..registerFactory<TestListBloc>(() => TestListBloc());
}