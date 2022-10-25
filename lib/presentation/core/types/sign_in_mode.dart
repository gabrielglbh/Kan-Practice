import 'package:easy_localization/easy_localization.dart';

enum SignMode { login, signup }

extension SignModeExt on SignMode {
  String get name {
    switch (this) {
      case SignMode.login:
        return "login_login_title".tr();
      case SignMode.signup:
        return "login_signUp_title".tr();
    }
  }
}
