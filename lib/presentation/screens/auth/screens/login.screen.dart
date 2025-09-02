import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:go_router/go_router.dart';
import 'package:uae_meditation_center/presentation/components/app.buttons.dart';
import 'package:uae_meditation_center/presentation/components/app.input.dart';
import 'package:uae_meditation_center/presentation/components/app.logo.dart';
import 'package:uae_meditation_center/core/alerts/app.top.snackbar.dart';
import 'package:uae_meditation_center/core/alerts/loading.popup.dart';
import 'package:uae_meditation_center/core/theme/app.colors.dart';
import 'package:uae_meditation_center/presentation/screens/auth/services/auth.services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool obscureText = true;

  bool isEmailError = false;
  bool isEPassError = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login() async {
    setState(() {
      isEmailError = emailController.text.isEmpty;
      isEPassError = passwordController.text.isEmpty;
    });

    // continue login
    if (!isEPassError && !isEmailError) {
      
      if (AuthServices.isValidEmail(emailController.text)) {
        LoadingPopup.show('Logging...');
        final result = await AuthServices.signInWithEmail(
            emailController.text, passwordController.text);

              if (!mounted) return;

        if (result == 'errCode1') {
          AppTopSnackbar.showTopSnackBar(context, "User not found");
          EasyLoading.dismiss();
        } else if (result == 'errCode2') {
          AppTopSnackbar.showTopSnackBar(context, "Wrong password");
          EasyLoading.dismiss();
        } else if (result == 'Something went wrong') {
          AppTopSnackbar.showTopSnackBar(
              context, "invalid email or password");
          EasyLoading.dismiss();
        } else if (result == 'Successfully') {
          context.pushReplacement(
            '/main',
          );
          EasyLoading.dismiss();
        }
      } else {
        AppTopSnackbar.showTopSnackBar(context, "Please enter a valid email");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: double.infinity,
          child: LayoutBuilder(builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Spacer(),
                        Center(
                          child: AppLogo(
                            width: 100,
                            height: 100,
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            "Sign in to Continue",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02),
                        AppInput(
                          hasError: isEmailError,
                          controller: emailController,
                          hintText: isEmailError
                              ? "Please enter email address"
                              : "Email address",
                          prefixIcon: Icons.email_outlined,
                          suffixIcon: Icons.cancel_sharp,
                          onTapIcon: () {
                            setState(() {
                              emailController.clear();
                            });
                          },
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02),
                        AppInput(
                          hasError: isEPassError,
                          controller: passwordController,
                          obscureText: obscureText,
                          hintText: isEPassError
                              ? "Please enter password"
                              : "Password",
                          prefixIcon: Icons.lock_outline,
                          suffixIcon: !obscureText
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          onTapIcon: () {
                            setState(() {
                              obscureText = !obscureText;
                            });
                          },
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                context.push('/forgot');
                              },
                              child: Text(
                                "Forgot password?",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      color: AppColors.textColor,
                                    ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02),
                        AppButtons(
                          isPrimary: true,
                          text: "Login",
                          width: double.infinity,
                          height: 50,
                          icon: Icons.login,
                          onTap: () {
                            login();
                          },
                        ),
                        Spacer(),
                        Center(
                          child: Text(
                            "OR",
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: AppColors.textColor,
                                    ),
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                                onTap: () async {
                                  LoadingPopup.show('Logging...');
                                  final status =
                                      await AuthServices().signInWithGoogle();
                                  if (status.user!.uid != '') {
                                    context.pushReplacement('/main');
                                    EasyLoading.dismiss();
                                  }
                                },
                                child: _socialIcon(
                                    "assets/icons/google.png", 40, 40)),
                            SizedBox(width: 5),
                            _socialIcon("assets/icons/facebook.png", 40, 40),
                          ],
                        ),
                        Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account? ",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    color: AppColors.textColor,
                                  ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            GestureDetector(
                              onTap: () {
                                context.push('/create');
                              },
                              child: Text(
                                "Create",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      color: AppColors.primaryColor,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _socialIcon(String iconPath, double? width, double? height) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Image.asset(
        iconPath,
        width: width ?? 40,
        height: height ?? 40,
      ),
    );
  }
}
