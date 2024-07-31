import 'package:customer_app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

String interFontFamily = 'Inter';

class FontTheme {
  static TextStyle get title => GoogleFonts.getFont(
        interFontFamily,
        color: AppColors.blackColor,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      );

  static TextStyle get subTitle => GoogleFonts.getFont(
        interFontFamily,
        color: AppColors.customGreyColor,
        fontWeight: FontWeight.w600,
        fontSize: 14,
      );

  static TextStyle get bodyText => GoogleFonts.getFont(
        interFontFamily,
        color: AppColors.blackColor,
        fontWeight: FontWeight.w400,
        fontSize: 14,
      );
}

extension TextStyleHelper on TextStyle {
  TextStyle override({
    String? fontFamily,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    FontStyle? fontStyle,
    bool useGoogleFonts = true,
    TextDecoration? decoration,
    double? lineHeight,
  }) =>
      useGoogleFonts
          ? GoogleFonts.getFont(
              fontFamily = interFontFamily,
              color: color ?? this.color,
              fontSize: fontSize ?? this.fontSize,
              letterSpacing: letterSpacing ?? this.letterSpacing,
              fontWeight: fontWeight ?? this.fontWeight,
              fontStyle: fontStyle ?? this.fontStyle,
              decoration: decoration,
              height: lineHeight,
            )
          : copyWith(
              fontFamily: fontFamily,
              color: color,
              fontSize: fontSize,
              letterSpacing: letterSpacing,
              fontWeight: fontWeight,
              fontStyle: fontStyle,
              decoration: decoration,
              height: lineHeight,
            );
}
