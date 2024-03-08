import 'package:flutter/cupertino.dart';

// A utility class for screen size adaptation.
class ScreenAdapter {

  // Declaration of MediaQueryData for getting media information.
  static late MediaQueryData _mediaQueryData;

  // Screen width in logical pixels.
  static late double screenWidth;

  // Screen height in logical pixels.
  static late double screenHeight;

  // The ratio of the actual screen width to the base width used for UI design.
  static late double ratio;

  // Initializes the ScreenAdapter with the context and an optional base width
  // (default is 375px). This base width is typically the width of the design mock-up
  static init(BuildContext context, {double baseWidth=375}) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    ratio = screenWidth / baseWidth;
  }

  // Static method to get the adapted pixel size based on the design size & screen ratio
  static double getPx(double size) {
    return ScreenAdapter.ratio * size;
  }
}

// An extension on the `int` type for pixel adaptation.
extension IntFix on int {
  double get px {
    return ScreenAdapter.getPx(toDouble());
  }
}

// An extension on the `double` type for pixel adaptation.
extension DoubleFix on double {
  double get px {
    return ScreenAdapter.getPx(this);
  }
}