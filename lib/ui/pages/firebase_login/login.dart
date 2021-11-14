import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/core/routing/pages.dart';
import 'package:kanpractice/ui/pages/firebase_login/bloc/login_bloc.dart';
import 'package:kanpractice/ui/theme/theme_consts.dart';
import 'package:kanpractice/ui/widgets/CustomAlertDialog.dart';
import 'package:kanpractice/ui/widgets/CustomTextForm.dart';
import 'package:kanpractice/ui/widgets/ProgressIndicator.dart';

enum SignMode { login, signup }

extension SignModeExt on SignMode {
  String get name {
    switch(this) {
      case SignMode.login:
        return "Log In";
      case SignMode.signup:
        return "Sign Up";
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
        title: Text("Change Password"),
        content: Container(
          height: 256,
          child: Column(
            children: [
              CustomTextForm(
                hint: 'Password',
                header: 'Current Password',
                inputType: TextInputType.visiblePassword,
                controller: _currPassword,
                focusNode: _currPasswordFn,
                autofocus: true,
                obscure: true,
                onEditingComplete: () => _newPasswordFn.requestFocus(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: CustomTextForm(
                  hint: 'Password',
                  header: 'New Password',
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
        ),
        positiveButtonText: "Change",
        onPositive: () => _changePassword(_currPassword.text, _newPassword.text)
      );
    });
  }

  _removeAccountDialog() {
    TextEditingController _currPassword = TextEditingController();
    FocusNode _currPasswordFn = FocusNode();
    showDialog(context: context, builder: (context) {
      return CustomDialog(
        title: Text("Remove Account"),
        content: Container(
          height: 200,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: Text("Removing your account will remove all your back ups too. Although you"
                    "will still be able to use the app :)"),
              ),
              CustomTextForm(
                hint: 'Password',
                header: 'Current Password',
                inputType: TextInputType.visiblePassword,
                controller: _currPassword,
                focusNode: _currPasswordFn,
                autofocus: true,
                obscure: true,
                onEditingComplete: () {
                  Navigator.of(context).pop();
                  _removeAccount(_currPassword.text);
                },
              ),
            ],
          ),
        ),
        positiveButtonText: "Remove",
        onPositive: () => _removeAccount(_currPassword.text)
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: appBarHeight,
        title: Text(_mode == SignMode.login ? "Log In" : "Sign Up"),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - appBarHeight,
          child: BlocProvider(
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
        ),
      )
    );
  }

  Padding _idleState(LoginStateIdle state) {
    return Padding(
      padding: EdgeInsets.only(right: 16, left: 16),
      child: Column(
        children: [
          Icon(Icons.info_outline_rounded, color: secondaryColor),
          Padding(
            padding: EdgeInsets.only(top: 16, bottom: 16),
            child: Text(
              "By creating an account or logging in, you gain access to back ups. "
              "Back ups will allow you to maintain your current lists and scores "
              "across devices. \n\nRead the dialogs prompted when creating, merging "
              "or removing a back up for more information on these operations."
            ),
          ),
          CustomTextForm(
            header: "Email",
            hint: "someone@provider.com",
            inputType: TextInputType.emailAddress,
            controller: _emailController,
            focusNode: _emailFocus,
            onEditingComplete: () => _passwordFocus?.requestFocus()
          ),
          Padding(
            padding: EdgeInsets.only(top: 32),
            child: CustomTextForm(
              header: "Password",
              hint: "••••••••••",
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
              padding: EdgeInsets.all(16),
              child: Text("Something went wrong while authenticating: ${state.error}",
                  style: TextStyle(color: secondaryColor)),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 16),
            child: ElevatedButton(
              onPressed: () => _handleLogin(),
              child: Text("Submit"),
            ),
          ),
          GestureDetector(
            onTap: () => setState(() {
              if (_mode == SignMode.login) _mode = SignMode.signup;
              else if (_mode == SignMode.signup) _mode = SignMode.login;
            }),
            child: Padding(
              padding: EdgeInsets.all(16),
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
          Icon(Icons.check_circle_rounded, color: secondaryColor, size: 256),
          Padding(
            padding: EdgeInsets.all(16),
            child: Text("You are logged in with ${state.user.email}.", textAlign: TextAlign.center),
          ),
          Container(
            height: appBarHeight,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pushReplacementNamed(backUpPage,
                    arguments: state.user.uid),
                child: Text("Manage your back up"),
              ),
            ),
          ),
          ListTile(
            title: Text("Misc", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
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
          title: Text("Change Password"),
          onTap: () => _changePasswordDialog(),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.delete),
          title: Text("Remove Account"),
          onTap: () => _removeAccountDialog(),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.logout),
          title: Text("Close Session"),
          onTap: () => _bloc..add(CloseSession()),
        )
      ],
    );
  }

  Center _loggedOut(LoginStateLoggedOut state) {
    return Center(
      child: Column(
        children: [
          Icon(Icons.check_circle_rounded, color: secondaryColor, size: 256),
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(state.message, textAlign: TextAlign.center),
          ),
        ],
      )
    );
  }
}
