import 'package:flutter/material.dart';

class ResponsiveUtil {
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 600;
  }

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= 600 && width < 1200;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1200;
  }

  // Método para obtener un tamaño escalado basado en la pantalla
  static double responsiveValue({
    required BuildContext context,
    required double mobileValue,
    double? tabletValue,
    double? desktopValue,
  }) {
    if (isDesktop(context)) {
      return desktopValue ?? tabletValue ?? mobileValue;
    } else if (isTablet(context)) {
      return tabletValue ?? mobileValue;
    } else {
      return mobileValue;
    }
  }
}
