import 'package:demo_ecom/core/provider/auth.dart';
import 'package:demo_ecom/core/screen/bottom_navigator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  final void Function(bool)? setShowSignupScreen;

  LoginScreen({this.setShowSignupScreen});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameInputController = TextEditingController();
  final _passwordInputController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Future? _login;

  String version = '';
  String copyright = "";
  String appName = '';
  String packageName = '';
  String buildNumber = "";
  bool _isObscure = true;

  @override
  void initState() {
    // _loadUser();
    // getInfo();

    super.initState();
  }

  // void _loadUser() async {
  //   try {
  //     SharedPreferences _prefs = await SharedPreferences.getInstance();
  //     var _email = _prefs.getString("r_username") ?? "";
  //     var _password = _prefs.getString("r_password") ?? "";

  //     _usernameInputController.text = _email;
  //     _passwordInputController.text = _password;
  //     var _rememberMe = _prefs.getBool("remember_me") ?? false;

  //     if (_rememberMe) {
  //       setState(() {
  //         _isRemember = true;
  //       });
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // void getInfo() {
  //   PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
  //     if (mounted) {
  //       setState(() {
  //         appName = packageInfo.appName;
  //         packageName = packageInfo.packageName;
  //         version = packageInfo.version;
  //         buildNumber = packageInfo.buildNumber;
  //       });
  //     }
  //   });
  // }
  void login() {
    final authData = Provider.of<AuthProvider>(context, listen: false);
    authData
        .login(_usernameInputController.text, _passwordInputController.text)
        .then((value) {
      if (value.statusCode == 200) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => BottomNavBar(
                      navIndex: 0,
                    )));
      }
    });
  }

  @override
  void dispose() {
    _usernameInputController.dispose();
    _passwordInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 30.0, right: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Form(
              key: _formKey,
              child: AutofillGroup(
                child: Column(
                  children: [
                    TextFormField(
                        autofillHints: [AutofillHints.username],
                        controller: _usernameInputController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Username is required';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Username',
                          enabledBorder: UnderlineInputBorder(),
                        ),
                        textInputAction: TextInputAction.next),
                    const SizedBox(height: 20),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      autofillHints: [AutofillHints.password],
                      controller: _passwordInputController,
                      validator: (value) => value == null || value.isEmpty
                          ? 'Password is required'
                          : null,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            icon: Icon(_isObscure
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            }),
                        labelText: 'Password',
                        enabledBorder: UnderlineInputBorder(),
                      ),
                      obscureText: _isObscure,
                      enableSuggestions: false,
                      autocorrect: false,
                      textInputAction: TextInputAction.go,
                    ),
                    const SizedBox(height: 20),
                    FutureBuilder<void>(
                        future: _login,
                        builder: (ctx, snapshot) {
                          return ElevatedButton(
                            child: const Text("Login"),
                            onPressed: () {
                              if (_formKey.currentState != null &&
                                  _formKey.currentState!.validate() &&
                                  !(snapshot.connectionState ==
                                      ConnectionState.waiting)) {
                                login();
                              }
                            },
                          );
                        }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
