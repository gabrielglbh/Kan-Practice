import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/core/routing/pages.dart';
import 'package:kanpractice/core/types/sign_in_mode.dart';
import 'package:kanpractice/ui/pages/firebase_login/bloc/login_bloc.dart';
import 'package:kanpractice/ui/theme/consts.dart';
import 'package:kanpractice/ui/widgets/kp_alert_dialog.dart';
import 'package:kanpractice/ui/widgets/kp_text_form.dart';
import 'package:kanpractice/ui/widgets/kp_progress_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/ui/widgets/kp_scaffold.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginBloc _bloc = LoginBloc();

  TextEditingController? _emailController;
  TextEditingController? _passwordController;
  FocusNode? _emailFocus;
  FocusNode? _passwordFocus;

  SignMode _mode = SignMode.login;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _emailFocus = FocusNode();
    _passwordFocus = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _emailController?.dispose();
    _passwordController?.dispose();
    _emailFocus?.dispose();
    _passwordFocus?.dispose();
    _bloc.close();
    super.dispose();
  }

  _handleLogin() {
    String? email = _emailController?.text;
    String? password = _passwordController?.text;
    if (email != null && password != null) {
      _bloc.add(LoginSubmitting(_mode, email, password));
    }
  }

  _changePassword(String prevPass, String newPass) {
    if (prevPass.isNotEmpty && newPass.isNotEmpty) {
      _bloc.add(ChangePassword(prevPass, newPass));
    }
  }

  _removeAccount(String pass) {
    if (pass.isNotEmpty) _bloc.add(RemoveAccount(pass));
  }

  _changePasswordDialog() {
    TextEditingController _currPassword = TextEditingController();
    TextEditingController _newPassword = TextEditingController();
    FocusNode _currPasswordFn = FocusNode();
    FocusNode _newPasswordFn = FocusNode();
    showDialog(context: context, builder: (context) {
      return KPDialog(
        title: Text("login_changePasswordDialog_title".tr()),
        content: Column(
          children: [
            KPTextForm(
              hint: 'login_changePasswordDialog_hint'.tr(),
              header: 'login_changePasswordDialog_old_header'.tr(),
              inputType: TextInputType.visiblePassword,
              controller: _currPassword,
              focusNode: _currPasswordFn,
              autofocus: true,
              obscure: true,
              onEditingComplete: () => _newPasswordFn.requestFocus(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: Margins.margin16),
              child: KPTextForm(
                hint: 'login_changePasswordDialog_hint'.tr(),
                header: 'login_changePasswordDialog_new_header'.tr(),
                inputType: TextInputType.visiblePassword,
                controller: _newPassword,
                focusNode: _newPasswordFn,
                obscure: true,
                onEditingComplete: () {
                  Navigator.of(context).pop();
                  _changePassword(_currPassword.text, _newPassword.text);
                },
              ),
            )
          ],
        ),
        positiveButtonText: "login_changePasswordDialog_positive".tr(),
        onPositive: () => _changePassword(_currPassword.text, _newPassword.text)
      );
    });
  }

  _removeAccountDialog() {
    TextEditingController _currPassword = TextEditingController();
    FocusNode _currPasswordFn = FocusNode();
    showDialog(context: context, builder: (context) {
      return KPDialog(
        title: Text("login_removeAccountDialog_title".tr()),
        content: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: Margins.margin16),
              child: Text("login_removeAccountDialog_content".tr()),
            ),
            KPTextForm(
              hint: 'login_removeAccountDialog_hint'.tr(),
              header: 'login_removeAccountDialog_header'.tr(),
              inputType: TextInputType.visiblePassword,
              controller: _currPassword,
              focusNode: _currPasswordFn,
              obscure: true,
              onEditingComplete: () {
                Navigator.of(context).pop();
                _removeAccount(_currPassword.text);
              },
            ),
          ],
        ),
        positiveButtonText: "login_removeAccountDialog_positive".tr(),
        onPositive: () => _removeAccount(_currPassword.text)
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return KPScaffold(
      appBarTitle: BlocProvider<LoginBloc>(
        create: (_) => _bloc..add(LoginIdle()),
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            if (state is LoginStateSuccessful) {
              return FittedBox(fit: BoxFit.fitWidth,
                  child: Text("settings_account_label".tr()));
            } else if (state is LoginStateIdle) {
              return FittedBox(fit: BoxFit.fitWidth,
                  child: Text(_mode == SignMode.login
                      ? SignMode.login.name
                      : SignMode.signup.name));
            } else {
              return Container();
            }
          },
        )
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            BlocProvider<LoginBloc>(
              create: (_) => _bloc..add(LoginIdle()),
              child: BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  if (state is LoginStateLoading) {
                    return const KPProgressIndicator();
                  } else if (state is LoginStateSuccessful) {
                    return _successfulState(state);
                  } else if (state is LoginStateIdle) {
                    return _idleState(state);
                  } else if (state is LoginStateLoggedOut) {
                    return _loggedOut(state);
                  } else {
                    return Container();
                  }
                },
              )
            ),
          ],
        ),
      )
    );
  }

  Column _idleState(LoginStateIdle state) {
    return Column(
      children: [
        Icon(Icons.info_outline_rounded, color: CustomColors.getSecondaryColor(context)),
        Padding(
          padding: const EdgeInsets.only(top: Margins.margin16, bottom: Margins.margin16),
          child: Text("login_formDisclaimer".tr()),
        ),
        KPTextForm(
          header: "login_email_header".tr(),
          hint: "login_email_hint".tr(),
          inputType: TextInputType.emailAddress,
          controller: _emailController,
          focusNode: _emailFocus,
          onEditingComplete: () => _passwordFocus?.requestFocus()
        ),
        Padding(
          padding: const EdgeInsets.only(top: Margins.margin32),
          child: KPTextForm(
            header: "login_password_header".tr(),
            hint: "login_password_hint".tr(),
            inputType: TextInputType.visiblePassword,
            obscure: true,
            controller: _passwordController,
            focusNode: _passwordFocus,
            action: TextInputAction.done,
            onEditingComplete: () => _handleLogin()
          ),
        ),
        Visibility(
          visible: state.error != "",
          child: Padding(
            padding: const EdgeInsets.all(Margins.margin16),
            child: Text("${"login_authentication_failed".tr()} ${state.error}",
                style: TextStyle(color: CustomColors.getSecondaryColor(context))),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: Margins.margin16),
          child: ElevatedButton(
            onPressed: () => _handleLogin(),
            child: Text("login_form_positive".tr()),
          ),
        ),
        GestureDetector(
          onTap: () => setState(() {
            if (_mode == SignMode.login) {
              _mode = SignMode.signup;
            } else if (_mode == SignMode.signup) {
              _mode = SignMode.login;
            }
          }),
          child: Padding(
            padding: const EdgeInsets.all(Margins.margin16),
            child: Text(_mode == SignMode.login ? SignMode.signup.name : SignMode.login.name,
              style: const TextStyle(decoration: TextDecoration.underline),
            ),
          ),
        )
      ],
    );
  }

  Center _successfulState(LoginStateSuccessful state) {
    return Center(
      child: Column(
        children: [
          Icon(Icons.check_circle_rounded, color: CustomColors.getSecondaryColor(context),
              size: CustomSizes.maxHeightValidationCircle),
          Padding(
            padding: const EdgeInsets.all(Margins.margin16),
            child: Text("${"login_current_account_logged".tr()} ${state.user.email}.",
                textAlign: TextAlign.center),
          ),
          SizedBox(
            height: CustomSizes.appBarHeight,
            child: Padding(
              padding: const EdgeInsets.all(Margins.margin16),
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pushNamed(KanPracticePages.backUpPage,
                    arguments: state.user.uid),
                child: Text("login_manage_backup_title".tr()),
              ),
            ),
          ),
          ListTile(
            title: Text("login_miscellaneous_title".tr(),
                style: const TextStyle(fontSize: FontSizes.fontSize26, fontWeight: FontWeight.bold)),
          ),
          _loggedUserActions()
        ],
      )
    );
  }

  Column _loggedUserActions() {
    return Column(
      children: [
        const Divider(),
        ListTile(
          leading: const Icon(Icons.lock),
          title: Text("login_changePasswordDialog_title".tr()),
          onTap: () => _changePasswordDialog(),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.logout),
          title: Text("login_close_session_title".tr()),
          onTap: () => _bloc..add(CloseSession()),
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.only(bottom: Margins.margin32),
          child: ListTile(
            leading: const Icon(Icons.delete),
            title: Text("login_removeAccountDialog_title".tr(),
                style: TextStyle(color: CustomColors.getSecondaryColor(context))),
            onTap: () => _removeAccountDialog(),
          ),
        ),
      ],
    );
  }

  Center _loggedOut(LoginStateLoggedOut state) {
    return Center(
      child: Column(
        children: [
          Icon(Icons.check_circle_rounded, color: CustomColors.getSecondaryColor(context),
              size: CustomSizes.maxHeightValidationCircle),
          Padding(
            padding: const EdgeInsets.all(Margins.margin16),
            child: Text(state.message, textAlign: TextAlign.center),
          ),
        ],
      )
    );
  }
}
