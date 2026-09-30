import 'dart:math';

class CodeGeneratorHelper {
  CodeGeneratorHelper._();

  static final Random _random = Random();

  /// Generates a code in the format `PREFIX-XXXXX` (e.g., `EMP-23211`).
  static String generateEmployeeCode({String prefix = 'EMP'}) {
    final number = 10000 + _random.nextInt(90000);
    return '$prefix-$number';
  }

  /// Generates a worker code in the format `PREFIX-XXXXX` (e.g., `WRK-48291`).
  static String generateWorkerCode({String prefix = 'WRK'}) {
    final number = 10000 + _random.nextInt(90000);
    return '$prefix-$number';
  }
}
