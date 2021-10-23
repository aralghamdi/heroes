import 'package:flutter/widgets.dart';

///
/// This Class is used to implements responsive sizing for any widget in the app
///

class SizeConfig {
  static MediaQueryData? _mediaQueryData;
  static double? _screenWidth;
  static double? _screenHeight;
  static double? blockSizeHorizontal;
  static double? blockSizeVertical;

  static double? _safeAreaHorizontal;
  static double? _safeAreaVertical;
  static double? safeBlockHorizontal;
  static double? safeBlockVertical;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    _screenWidth = _mediaQueryData!.size.width;
    _screenHeight = _mediaQueryData!.size.height;
    blockSizeHorizontal = _screenWidth! / 100;
    blockSizeVertical = _screenHeight! / 100;

    _safeAreaHorizontal = _mediaQueryData!.padding.left +
        _mediaQueryData!.padding.right;
    _safeAreaVertical = _mediaQueryData!.padding.top +
        _mediaQueryData!.padding.bottom;
    safeBlockHorizontal = (_screenWidth! -
        _safeAreaHorizontal!) / 100;
    safeBlockVertical = (_screenHeight! -
        _safeAreaVertical!) / 100;


  }
}