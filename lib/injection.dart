import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/injection.config.dart';

final GetIt getIt = GetIt.instance;

@injectableInit
GetIt configureInjection() => $initGetIt(getIt);
