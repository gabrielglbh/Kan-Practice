import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/auth/auth_bloc.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';
import 'package:kanpractice/presentation/core/widgets/kp_alert_dialog.dart';
import 'package:kanpractice/presentation/core/widgets/kp_scaffold.dart';
import 'package:kanpractice/presentation/core/widgets/kp_text_form.dart';

class AccountManagementPage extends StatefulWidget {
  const AccountManagementPage({super.key});

  @override
  State<AccountManagementPage> createState() => _AccountManagementPageState();
}

class _AccountManagementPageState extends State<AccountManagementPage> {
  _changePassword(String prevPass, String newPass) {
    if (prevPass.isNotEmpty && newPass.isNotEmpty) {
      context.read<AuthBloc>().add(ChangePassword(prevPass, newPass));
    }
  }

  _removeAccount(String pass) {
    if (pass.isNotEmpty) {
      context.read<AuthBloc>().add(RemoveAccount(pass));
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
                        style: Theme.of(context).textTheme.bodyLarge),
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
      appBarTitle: FittedBox(
        fit: BoxFit.fitWidth,
        child: Text("settings_account_label".tr()),
      ),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          state.mapOrNull(
            initial: (_) {
              Navigator.of(context).pop();
            },
          );
        },
        builder: (context, state) {
          return state.maybeWhen(
            loaded: (user) {
              final isEmailProvider =
                  user.providerData[0].providerId == "password";
              final isGoogleProvider =
                  user.providerData[0].providerId == "google.com";
              return SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      Icon(Icons.check_circle_rounded,
                          color: Theme.of(context).colorScheme.primary,
                          size: KPSizes.maxHeightValidationCircle),
                      Padding(
                        padding: const EdgeInsets.all(KPMargins.margin16),
                        child: Text(
                            "${"login_current_account_logged".tr()} ${user.email}.",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyLarge),
                      ),
                      ListTile(
                        title: Row(
                          children: [
                            Text("login_miscellaneous_title".tr(),
                                style:
                                    Theme.of(context).textTheme.headlineSmall),
                            const SizedBox(width: KPMargins.margin12),
                            if (isGoogleProvider)
                              Image.asset('assets/images/google-signin.png',
                                  scale: 3.5),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          if (isEmailProvider) const Divider(),
                          if (isEmailProvider)
                            ListTile(
                              leading: const Icon(Icons.lock),
                              title:
                                  Text("login_changePasswordDialog_title".tr()),
                              onTap: () => _changePasswordDialog(),
                            ),
                          const Divider(),
                          ListTile(
                            leading: const Icon(Icons.logout),
                            title: Text("login_close_session_title".tr()),
                            onTap: () {
                              if (isEmailProvider) {
                                context
                                    .read<AuthBloc>()
                                    .add(CloseEmailProviderSession());
                              } else {
                                context
                                    .read<AuthBloc>()
                                    .add(CloseGoogleProviderSession());
                              }
                            },
                          ),
                          const Divider(),
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: KPMargins.margin32),
                            child: ListTile(
                              leading: const Icon(Icons.delete),
                              title: Text(
                                  "login_removeAccountDialog_title".tr(),
                                  style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.error)),
                              onTap: () async {
                                if (isEmailProvider) {
                                  _removeAccountDialog();
                                } else {
                                  context
                                      .read<AuthBloc>()
                                      .add(CloseGoogleProviderSession());
                                  final Uri emailLaunchUri = Uri(
                                      scheme: 'mailto',
                                      path: 'devgglop@gmail.com',
                                      queryParameters: {
                                        'subject':
                                            "I want to remove my Google Account from KanPractice",
                                      });
                                  String url = emailLaunchUri
                                      .toString()
                                      .replaceAll("+", "%20");
                                  await Utils.launch(context, url);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
            orElse: () => const SizedBox(),
          );
        },
      ),
    );
  }
}
