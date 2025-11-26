import 'package:flutter/widgets.dart';

class Responsive {
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 700;

  static bool isTablet(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return w >= 700 && w < 1100;
  }

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;
}
