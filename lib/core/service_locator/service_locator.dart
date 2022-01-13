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

/// Instead of singletons, which maintain the state even navigating back,
/// we should consider Factories instead of Singletons.
init() {
  getIt
    ..registerSingleton<KanjiListBloc>(KanjiListBloc())
    ..registerSingleton<KanjiListDetailBloc>(KanjiListDetailBloc())
    ..registerSingleton<DictBloc>(DictBloc())
    ..registerSingleton<JishoBloc>(JishoBloc())
    /// Always showing the same kanji. Rest untested
    ..registerSingleton<KanjiBSBloc>(KanjiBSBloc())
    ..registerSingleton<SettingsBloc>(SettingsBloc())
    ..registerSingleton<BackUpBloc>(BackUpBloc())
    /// No update whatsoever
    ..registerSingleton<LoginBloc>(LoginBloc())
    ..registerSingleton<TestListBloc>(TestListBloc());
}