import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gawa/modules/auth/presentiation/bloc/auth_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constants.dart';
import '../../../../core/common/widgets/loader.dart';
import '../../../../core/common/widgets/show_snackbar.dart';
import '../../../../utils/get_screen_size.dart';
import '../widgets/auth_action_button.dart';
import '../widgets/auth_input_field.dart';

class LoginScreen extends StatefulWidget {
  final Function()? toggleScreen;
  LoginScreen({super.key, this.toggleScreen});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signIn() async {
    context.read<AuthBloc>().add(AuthLogin(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        ));
  }

  void googleSignIn() {
    print('Google Sign In');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthFailure) {
                showSnackBar(context, state.message);
              }
            },
            builder: (context, state) {
              if (state is AuthLoading) {
                return const Loader();
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.04,
                  ),
                  Image.asset(
                    'assets/images/padlock.png',
                    width: SizeConfig.screenWidth * 0.32,
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.04,
                  ),
                  Text(
                    "GAWA",
                    style: GoogleFonts.raleway(
                        color: Colors.black45,
                        fontSize: 46,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.01,
                  ),
                  Text(
                    "Powering plans beyond the group chart",
                    style:
                        GoogleFonts.raleway(color: Colors.black, fontSize: 18),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.04,
                  ),
                  AuthInput(
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false,
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.024,
                  ),
                  AuthInput(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.screenWidth * 0.05,
                        vertical: SizeConfig.screenHeight * 0.008),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Forgot Password?",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.005,
                  ),
                  AuthActionButton(text: "Login", onTap: signIn),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.02,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.screenWidth * 0.02),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Divider(
                            thickness: 2,
                            color: Colors.grey,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.screenWidth * 0.02),
                          child: const Text(
                            "Or Continue With",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                        const Expanded(
                          child: Divider(
                            thickness: 2,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.02,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: googleSignIn,
                      child: Container(
                        padding: EdgeInsets.all(SizeConfig.screenWidth * 0.036),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black26, width: 2),
                            borderRadius: BorderRadius.circular(50)),
                        child: Image.asset(
                          'assets/logos/google.png',
                          width: SizeConfig.screenWidth * 0.12,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account? "),
                      GestureDetector(
                        onTap: widget.toggleScreen,
                        child: const Text(
                          "Register",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
