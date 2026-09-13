import 'package:flutter/material.dart';

class AppMotion {
  const AppMotion._();

  static const Duration routeEnter = Duration(milliseconds: 320);
  static const Duration routeExit = Duration(milliseconds: 240);
  static const Duration tabSwitch = Duration(milliseconds: 260);
  static const Curve enterCurve = Curves.easeOutCubic;
  static const Curve exitCurve = Curves.easeInCubic;
  static const double routeScaleBegin = 0.985;
  static const double routeSlideBegin = 0.035;
}
