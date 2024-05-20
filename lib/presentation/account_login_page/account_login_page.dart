import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/auth/auth_bloc.dart';
import 'package:kanpractice/presentation/core/types/sign_in_mode.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/presentation/core/widgets/kp_progress_indicator.dart';
import 'package:kanpractice/presentation/core/widgets/kp_scaffold.dart';
import 'package:kanpractice/presentation/core/widgets/kp_text_form.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

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
      context
          .read<AuthBloc>()
          .add(AuthSubmitEmailProvider(_mode, email, password));
    }
  }

  _handleGoogleLogin() {
    context.read<AuthBloc>().add(AuthSubmitGoogleProvider());
  }

  @override
  Widget build(BuildContext context) {
    return KPScaffold(
      appBarTitle: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return state.maybeWhen(
            loaded: (user) {
              return FittedBox(
                fit: BoxFit.fitWidth,
                child: Text("settings_account_label".tr()),
              );
            },
            initial: (_, __) {
              return FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  _mode == SignMode.login
                      ? SignMode.login.name
                      : SignMode.signup.name,
                  style: Theme.of(context).appBarTheme.titleTextStyle,
                ),
              );
            },
            orElse: () => const SizedBox(),
          );
        },
      ),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          state.mapOrNull(
            initial: (i) {
              if (i.shouldPop) Navigator.of(context).pop();
            },
            loaded: (l) {
              Navigator.of(context).pop();
            },
          );
        },
        builder: (context, state) {
          return state.maybeWhen(
            loading: () => const KPProgressIndicator(),
            initial: (error, __) =>
                SingleChildScrollView(child: _idleState(context, error)),
            orElse: () => const SizedBox(),
          );
        },
      ),
    );
  }

  Column _idleState(BuildContext bloc, String error) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(KPMargins.margin16),
          child: Text("login_formDisclaimer".tr(),
              style: Theme.of(context).textTheme.bodyLarge),
        ),
        const Divider(),
        if (!Platform.isIOS)
          ElevatedButton(
            onPressed: () => _handleGoogleLogin(),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/images/google-signin.png', scale: 3.5),
                const SizedBox(width: KPMargins.margin12),
                Text("google_signin".tr(),
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary))
              ],
            ),
          ),
        const SizedBox(height: KPMargins.margin16),
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
          visible: error != "",
          child: Padding(
            padding: const EdgeInsets.all(KPMargins.margin16),
            child: Text("login_authentication_failed".tr(),
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Theme.of(context).colorScheme.error)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: KPMargins.margin16),
          child: ElevatedButton(
            onPressed: () => _handleLogin(),
            child: Text("login_form_positive".tr(),
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(color: Theme.of(context).colorScheme.onPrimary)),
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
                  .bodyLarge
                  ?.copyWith(decoration: TextDecoration.underline),
            ),
          ),
        ),
      ],
    );
  }
}
