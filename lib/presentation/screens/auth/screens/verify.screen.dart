import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:uae_meditation_center/presentation/components/app.buttons.dart';
import 'package:uae_meditation_center/core/alerts/app.top.snackbar.dart';
import 'package:uae_meditation_center/core/alerts/loading.popup.dart';
import 'package:uae_meditation_center/presentation/screens/auth/services/auth.services.dart';

class VerifyScreen extends StatelessWidget {
  const VerifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    void verify() async {
      
          LoadingPopup.show('Verifying...');

      final result = await AuthServices.isEmailVerified();
      if (result) {
        context.pushReplacement('/main');
        EasyLoading.dismiss();
        EasyLoading.showSuccess('Verified !', duration: const Duration(seconds: 2));
      } else {
        EasyLoading.dismiss();
        AppTopSnackbar.showTopSnackBar(context, "Email not verified !");
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.email_outlined,
                size: 80,
                color: theme.primaryColor,
              ),
              const SizedBox(height: 32),
              Text(
                'Check your inbox',
                style: theme.textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'We\'ve sent a verification link to your email address. Please check your inbox and click the link to verify your account.',
                style: theme.textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              AppButtons(
                text: "Verify",
                isPrimary: true,
                width: double.infinity,
                height: 50,
                icon: Icons.check,
                onTap: () {
                  verify();
                },
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.arrow_back_ios_new_rounded,
                      color: theme.primaryColor, size: 14),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      context.pop();
                    },
                    child: Text(
                      'Back to Create Account',
                      style: theme.textTheme.bodySmall!
                          .copyWith(color: theme.primaryColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
