import 'package:flutter/material.dart';
import 'package:uae_meditation_center/core/theme/app.colors.dart';

class IntroductionText {
  static Widget text(
    ThemeData theme,
    String text,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2.5),
            child: Icon(Icons.do_not_disturb_on,
                size: 14, color: AppColors.whiteColor),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: theme.textTheme.bodySmall!
                  .copyWith(color: AppColors.whiteColor),
            ),
          ),
        ],
      ),
    );
  }
}