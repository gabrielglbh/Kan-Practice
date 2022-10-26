import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/auth/auth_bloc.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/core/routing/pages.dart';
import 'package:kanpractice/presentation/core/types/sign_in_mode.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/presentation/core/ui/kp_alert_dialog.dart';
import 'package:kanpractice/presentation/core/ui/kp_progress_indicator.dart';
import 'package:kanpractice/presentation/core/ui/kp_scaffold.dart';
import 'package:kanpractice/presentation/core/ui/kp_text_form.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
    super.dispose();
  }

  _handleLogin() {
    String? email = _emailController?.text;
    String? password = _passwordController?.text;
    if (email != null && password != null) {
      getIt<AuthBloc>().add(AuthSubmitting(_mode, email, password));
    }
  }

  _changePassword(String prevPass, String newPass) {
    if (prevPass.isNotEmpty && newPass.isNotEmpty) {
      getIt<AuthBloc>().add(ChangePassword(prevPass, newPass));
    }
  }

  _removeAccount(String pass) {
    if (pass.isNotEmpty) {
      getIt<AuthBloc>().add(RemoveAccount(pass));
    }
  }

  _changePasswordDialog() {
    TextEditingController currPassword = TextEditingController();
    TextEditingController newPassword = TextEditingController();
    FocusNode currPasswordFn = FocusNode();
    FocusNode newPasswordFn = FocusNode();
    showDialog(
        context: context,
        builder: (context) {
          return KPDialog(
              title: Text("login_changePasswordDialog_title".tr()),
              content: Column(
                children: [
                  KPTextForm(
                    hint: 'login_changePasswordDialog_hint'.tr(),
                    header: 'login_changePasswordDialog_old_header'.tr(),
                    inputType: TextInputType.visiblePassword,
                    controller: currPassword,
                    focusNode: currPasswordFn,
                    autofocus: true,
                    obscure: true,
                    onEditingComplete: () => newPasswordFn.requestFocus(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: KPMargins.margin16),
                    child: KPTextForm(
                      hint: 'login_changePasswordDialog_hint'.tr(),
                      header: 'login_changePasswordDialog_new_header'.tr(),
                      inputType: TextInputType.visiblePassword,
                      controller: newPassword,
                      focusNode: newPasswordFn,
                      obscure: true,
                      onEditingComplete: () {
                        Navigator.of(context).pop();
                        _changePassword(currPassword.text, newPassword.text);
                      },
                    ),
                  )
                ],
              ),
              positiveButtonText: "login_changePasswordDialog_positive".tr(),
              onPositive: () =>
                  _changePassword(currPassword.text, newPassword.text));
        });
  }

  _removeAccountDialog() {
    TextEditingController currPassword = TextEditingController();
    FocusNode currPasswordFn = FocusNode();
    showDialog(
        context: context,
        builder: (context) {
          return KPDialog(
              title: Text("login_removeAccountDialog_title".tr()),
              content: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: KPMargins.margin16),
                    child: Text("login_removeAccountDialog_content".tr(),
                        style: Theme.of(context).textTheme.bodyText1),
                  ),
                  KPTextForm(
                    hint: 'login_removeAccountDialog_hint'.tr(),
                    header: 'login_removeAccountDialog_header'.tr(),
                    inputType: TextInputType.visiblePassword,
                    controller: currPassword,
                    focusNode: currPasswordFn,
                    obscure: true,
                    onEditingComplete: () {
                      Navigator.of(context).pop();
                      _removeAccount(currPassword.text);
                    },
                  ),
                ],
              ),
              positiveButtonText: "login_removeAccountDialog_positive".tr(),
              onPositive: () => _removeAccount(currPassword.text));
        });
  }

  @override
  Widget build(BuildContext context) {
    return KPScaffold(
        appBarTitle: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthStateSuccessful) {
              return FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text("settings_account_label".tr()));
            } else if (state is AuthStateIdle) {
              return FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                      _mode == SignMode.login
                          ? SignMode.login.name
                          : SignMode.signup.name,
                      style: Theme.of(context).appBarTheme.titleTextStyle));
            } else {
              return Container();
            }
          },
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthStateIdle) {
                    if (state.shouldPop) Navigator.of(context).pop();
                  }
                },
                builder: (context, state) {
                  if (state is AuthStateLoading) {
                    return const KPProgressIndicator();
                  } else if (state is AuthStateSuccessful) {
                    return _successfulState(context, state);
                  } else if (state is AuthStateIdle) {
                    return _idleState(context, state);
                  }
                  return const SizedBox();
                },
              ),
            ],
          ),
        ));
  }

  Column _idleState(BuildContext bloc, AuthStateIdle state) {
    return Column(
      children: [
        Icon(Icons.info_outline_rounded,
            color: KPColors.getSecondaryColor(context)),
        Padding(
          padding: const EdgeInsets.only(
              top: KPMargins.margin16, bottom: KPMargins.margin16),
          child: Text("login_formDisclaimer".tr(),
              style: Theme.of(context).textTheme.bodyText1),
        ),
        KPTextForm(
            header: "login_email_header".tr(),
            hint: "login_email_hint".tr(),
            inputType: TextInputType.emailAddress,
            controller: _emailController,
            focusNode: _emailFocus,
            onEditingComplete: () => _passwordFocus?.requestFocus()),
        Padding(
          padding: const EdgeInsets.only(top: KPMargins.margin32),
          child: KPTextForm(
              header: "login_password_header".tr(),
              hint: "login_password_hint".tr(),
              inputType: TextInputType.visiblePassword,
              obscure: true,
              controller: _passwordController,
              focusNode: _passwordFocus,
              action: TextInputAction.done,
              onEditingComplete: () => _handleLogin()),
        ),
        Visibility(
          visible: state.error != "",
          child: Padding(
            padding: const EdgeInsets.all(KPMargins.margin16),
            child: Text("login_authentication_failed".tr(),
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(color: KPColors.getSecondaryColor(context))),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: KPMargins.margin16),
          child: ElevatedButton(
            onPressed: () => _handleLogin(),
            child: Text("login_form_positive".tr(),
                style: Theme.of(context).textTheme.button),
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
            padding: const EdgeInsets.all(KPMargins.margin16),
            child: Text(
              _mode == SignMode.login
                  ? SignMode.signup.name
                  : SignMode.login.name,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(decoration: TextDecoration.underline),
            ),
          ),
        )
      ],
    );
  }

  Center _successfulState(BuildContext bloc, AuthStateSuccessful state) {
    return Center(
        child: Column(
      children: [
        Icon(Icons.check_circle_rounded,
            color: KPColors.getSecondaryColor(context),
            size: KPSizes.maxHeightValidationCircle),
        Padding(
          padding: const EdgeInsets.all(KPMargins.margin16),
          child: Text(
              "${"login_current_account_logged".tr()} ${state.user.email}.",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1),
        ),
        SizedBox(
          height: KPSizes.appBarHeight,
          child: Padding(
            padding: const EdgeInsets.all(KPMargins.margin16),
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).pushNamed(
                  KanPracticePages.backUpPage,
                  arguments: state.user.uid),
              child: Text("login_manage_backup_title".tr(),
                  style: Theme.of(context).textTheme.button),
            ),
          ),
        ),
        ListTile(
          title: Text("login_miscellaneous_title".tr(),
              style: Theme.of(context).textTheme.headline5),
        ),
        _loggedUserActions()
      ],
    ));
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
          onTap: () => getIt<AuthBloc>().add(CloseSession()),
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.only(bottom: KPMargins.margin32),
          child: ListTile(
            leading: const Icon(Icons.delete),
            title: Text("login_removeAccountDialog_title".tr(),
                style: TextStyle(color: KPColors.getSecondaryColor(context))),
            onTap: () => _removeAccountDialog(),
          ),
        ),
      ],
    );
  }
}
