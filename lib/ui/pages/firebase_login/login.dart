import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/core/routing/pages.dart';
import 'package:kanpractice/ui/pages/firebase_login/bloc/login_bloc.dart';
import 'package:kanpractice/ui/theme/consts.dart';
import 'package:kanpractice/ui/widgets/CustomAlertDialog.dart';
import 'package:kanpractice/ui/widgets/CustomTextForm.dart';
import 'package:kanpractice/ui/widgets/ProgressIndicator.dart';
import 'package:easy_localization/easy_localization.dart';

enum SignMode { login, signup }

extension SignModeExt on SignMode {
  String get name {
    switch(this) {
      case SignMode.login:
        return "login_login_title".tr();
      case SignMode.signup:
        return "login_signUp_title".tr();
    }
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage();

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController? _emailController;
  TextEditingController? _passwordController;
  FocusNode? _emailFocus;
  FocusNode? _passwordFocus;

  SignMode _mode = SignMode.login;

  LoginBloc _bloc = LoginBloc();

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
    super.dispose();
  }

  _handleLogin() {
    String? email = _emailController?.text;
    String? password = _passwordController?.text;
    if (email != null && password != null) {
      _bloc..add(LoginSubmitting(_mode, email, password));
    }
  }

  _changePassword(String prevPass, String newPass) {
    if (prevPass.isNotEmpty && newPass.isNotEmpty) _bloc..add(ChangePassword(prevPass, newPass));
  }

  _removeAccount(String pass) {
    if (pass.isNotEmpty) _bloc..add(RemoveAccount(pass));
  }

  _changePasswordDialog() {
    TextEditingController _currPassword = TextEditingController();
    TextEditingController _newPassword = TextEditingController();
    FocusNode _currPasswordFn = FocusNode();
    FocusNode _newPasswordFn = FocusNode();
    showDialog(context: context, builder: (context) {
      return CustomDialog(
        title: Text("login_changePasswordDialog_title".tr()),
        content: Column(
          children: [
            CustomTextForm(
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
              padding: EdgeInsets.only(top: Margins.margin16),
              child: CustomTextForm(
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
      return CustomDialog(
        title: Text("login_removeAccountDialog_title".tr()),
        content: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: Margins.margin16),
              child: Text("login_removeAccountDialog_content".tr()),
            ),
            CustomTextForm(
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
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: CustomSizes.appBarHeight,
        title: BlocProvider(
            create: (_) => _bloc..add(LoginIdle()),
            child: BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                if (state is LoginStateSuccessful)
                  return FittedBox(fit: BoxFit.fitWidth,
                      child: Text("settings_account_label".tr()));
                else if (state is LoginStateIdle)
                  return FittedBox(fit: BoxFit.fitWidth,
                    child: Text(_mode == SignMode.login
                        ? SignMode.login.name
                        : SignMode.signup.name));
                else
                  return Container();
              },
            )
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            BlocProvider(
              create: (_) => _bloc..add(LoginIdle()),
              child: BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  if (state is LoginStateLoading)
                    return CustomProgressIndicator();
                  else if (state is LoginStateSuccessful)
                    return _successfulState(state);
                  else if (state is LoginStateIdle)
                    return _idleState(state);
                  else if (state is LoginStateLoggedOut)
                    return _loggedOut(state);
                  else
                    return Container();
                },
              )
            ),
          ],
        ),
      )
    );
  }

  Padding _idleState(LoginStateIdle state) {
    return Padding(
      padding: EdgeInsets.only(right: Margins.margin16, left: Margins.margin16),
      child: Column(
        children: [
          Icon(Icons.info_outline_rounded, color: CustomColors.secondaryColor),
          Padding(
            padding: EdgeInsets.only(top: Margins.margin16, bottom: Margins.margin16),
            child: Text("login_formDisclaimer".tr()),
          ),
          CustomTextForm(
            header: "login_email_header".tr(),
            hint: "login_email_hint".tr(),
            inputType: TextInputType.emailAddress,
            controller: _emailController,
            focusNode: _emailFocus,
            onEditingComplete: () => _passwordFocus?.requestFocus()
          ),
          Padding(
            padding: EdgeInsets.only(top: Margins.margin32),
            child: CustomTextForm(
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
              padding: EdgeInsets.all(Margins.margin16),
              child: Text("${"login_authentication_failed".tr()} ${state.error}",
                  style: TextStyle(color: CustomColors.secondaryColor)),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: Margins.margin16),
            child: ElevatedButton(
              onPressed: () => _handleLogin(),
              child: Text("login_form_positive".tr()),
            ),
          ),
          GestureDetector(
            onTap: () => setState(() {
              if (_mode == SignMode.login) _mode = SignMode.signup;
              else if (_mode == SignMode.signup) _mode = SignMode.login;
            }),
            child: Padding(
              padding: EdgeInsets.all(Margins.margin16),
              child: Text(_mode == SignMode.login ? SignMode.signup.name : SignMode.login.name,
                style: TextStyle(decoration: TextDecoration.underline),
              ),
            ),
          )
        ],
      ),
    );
  }

  Center _successfulState(LoginStateSuccessful state) {
    return Center(
      child: Column(
        children: [
          Icon(Icons.check_circle_rounded, color: CustomColors.secondaryColor,
              size: CustomSizes.maxHeightValidationCircle),
          Padding(
            padding: EdgeInsets.all(Margins.margin16),
            child: Text("${"login_current_account_logged".tr()} ${state.user.email}.",
                textAlign: TextAlign.center),
          ),
          Container(
            height: CustomSizes.appBarHeight,
            child: Padding(
              padding: EdgeInsets.all(Margins.margin16),
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pushNamed(KanPracticePages.backUpPage,
                    arguments: state.user.uid),
                child: Text("login_manage_backup_title".tr()),
              ),
            ),
          ),
          ListTile(
            title: Text("login_miscellaneous_title".tr(),
                style: TextStyle(fontSize: FontSizes.fontSize26, fontWeight: FontWeight.bold)),
          ),
          _loggedUserActions()
        ],
      )
    );
  }

  Column _loggedUserActions() {
    return Column(
      children: [
        Divider(),
        ListTile(
          leading: Icon(Icons.lock),
          title: Text("login_changePasswordDialog_title".tr()),
          onTap: () => _changePasswordDialog(),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.logout),
          title: Text("login_close_session_title".tr()),
          onTap: () => _bloc..add(CloseSession()),
        ),
        Divider(),
        Padding(
          padding: EdgeInsets.only(bottom: Margins.margin32),
          child: ListTile(
            leading: Icon(Icons.delete),
            title: Text("login_removeAccountDialog_title".tr(),
                style: TextStyle(color: CustomColors.secondaryColor)),
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
          Icon(Icons.check_circle_rounded, color: CustomColors.secondaryColor,
              size: CustomSizes.maxHeightValidationCircle),
          Padding(
            padding: EdgeInsets.all(Margins.margin16),
            child: Text(state.message, textAlign: TextAlign.center),
          ),
        ],
      )
    );
  }
}
