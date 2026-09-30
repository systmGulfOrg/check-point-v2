import 'package:flutter_test/flutter_test.dart';
import 'package:check_point_v2/core/utils/code_generator_helper.dart';

void main() {
  group('CodeGeneratorHelper', () {
    test('generateEmployeeCode generates format EMP-XXXXX with 5 digits', () {
      final code = CodeGeneratorHelper.generateEmployeeCode();
      expect(code.startsWith('EMP-'), isTrue);
      final numberPart = code.substring(4);
      expect(numberPart.length, equals(5));
      final parsed = int.tryParse(numberPart);
      expect(parsed, isNotNull);
      expect(parsed! >= 10000 && parsed <= 99999, isTrue);
    });

    test('generateEmployeeCode supports custom prefix', () {
      final code = CodeGeneratorHelper.generateEmployeeCode(prefix: 'CUSTOM');
      expect(code.startsWith('CUSTOM-'), isTrue);
    });

    test('generateWorkerCode generates format WRK-XXXXX with 5 digits', () {
      final code = CodeGeneratorHelper.generateWorkerCode();
      expect(code.startsWith('WRK-'), isTrue);
      final numberPart = code.substring(4);
      expect(numberPart.length, equals(5));
      final parsed = int.tryParse(numberPart);
      expect(parsed, isNotNull);
      expect(parsed! >= 10000 && parsed <= 99999, isTrue);
    });
  });
}
