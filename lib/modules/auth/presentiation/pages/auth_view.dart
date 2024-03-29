import 'package:flutter/material.dart';

import 'login.dart';
import 'sign_up.dart';

class LoginAndRegisterView extends StatefulWidget {
  const LoginAndRegisterView({super.key});

  @override
  State<LoginAndRegisterView> createState() => _LoginAndRegisterViewState();
}

class _LoginAndRegisterViewState extends State<LoginAndRegisterView> {
  bool showLoginScreen = true;

  void toggleScreen() {
    setState(() {
      showLoginScreen = !showLoginScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginScreen) {
      return LoginScreen(
        toggleScreen: toggleScreen,
      );
    } else {
      return RegisterScreen(
        toggleScreen: toggleScreen,
      );
    }
  }
}
