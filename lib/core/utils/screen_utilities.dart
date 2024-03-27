import 'package:flutter/material.dart';

class ScreenUtilities {
  
  double getMaxChildSize(BuildContext context) {
    var isTablet = MediaQuery.of(context).size.shortestSide > 600;
    return isTablet ? 0.91 : 0.88; // Example adjustment, customize as needed
  }

  double getMinChildSize(BuildContext context) {
    var isTablet = MediaQuery.of(context).size.shortestSide > 600;
    return isTablet ? 0.89 : 0.84; // Example adjustment, customize as needed
  }

  double customScaleFactor(BuildContext context) {
    var isTablet = MediaQuery.of(context).size.shortestSide > 600;
    return isTablet ? 0.6 : 1.0; // Example adjustment, customize as needed
  }
}