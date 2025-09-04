import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:uae_meditation_center/core/theme/app.colors.dart';

class AppTopSnackbar {
  static Future showTopSnackBar(
    BuildContext context,
    String message,
  ) {
    late Flushbar flush;

    flush = Flushbar(
      flushbarStyle: FlushbarStyle.FLOATING,
      icon: Icon(
        Icons.error,
        color: AppColors.whiteColor,
      ),
      messageText: Text(
        message,
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: Colors.white,
            ),
      ),
      mainButton: TextButton(
        onPressed: () {
          flush.dismiss();
        },
        child: Text(
          "Undo",
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Colors.white,
              ),
        ),
      ),
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.red,
      flushbarPosition: FlushbarPosition.TOP,
      margin: const EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8),
    );

    return flush.show(context);
  }
}
