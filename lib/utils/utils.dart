import 'package:customer_app/theme/app_colors.dart';
import 'package:customer_app/theme/theme.dart';
import 'package:flutter/material.dart';

class Utils {
  static showStatusSnackBar(String statusMsg, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(milliseconds: 2000),
        backgroundColor: AppColors.blackColor.withOpacity(0.5),
        behavior: SnackBarBehavior.floating,
        content: Text(
          statusMsg,
          style: FontTheme.bodyText.copyWith(color: AppColors.whiteColor),
        ),
      ),
    );
  }
}
