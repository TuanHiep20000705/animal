import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  double get viewInsets => MediaQuery.of(this).viewInsets.bottom;
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
  double get paddingBottom => MediaQuery.of(this).padding.bottom;
}