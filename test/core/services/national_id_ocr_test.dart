import 'package:flutter_test/flutter_test.dart';

import 'package:check_point_v2/core/services/national_id_ocr.dart';

void main() {
  group('extractNationalIdFromText', () {
    test('extracts a 14 digit national ID from OCR text', () {
      expect(
        extractNationalIdFromText('Name\n29801011234567\nEgypt'),
        '29801011234567',
      );
    });

    test('normalizes Arabic and Persian digits', () {
      expect(extractNationalIdFromText('٢٩٨٠١٠١١٢٣٤٥٦٧'), '29801011234567');
      expect(extractNationalIdFromText('۲۹۸۰۱۰۱۱۲۳۴۵۶۷'), '29801011234567');
    });

    test('does not join separate numeric values into a false ID', () {
      expect(
        extractNationalIdFromText('Employee 1234567 Code 8901234'),
        isNull,
      );
    });
  });

  group('extractNationalIdScanResult', () {
    test('extracts the national ID and a Latin full name', () {
      final result = extractNationalIdScanResult(
        'OSAMA MAHMOUD\n29801011234567\nEgypt',
      );

      expect(result, isNotNull);
      expect(result!.nationalId, '29801011234567');
      expect(result.fullName, 'OSAMA MAHMOUD');
    });

    test('returns null when the national ID is not recognized', () {
      expect(
        extractNationalIdScanResult('OSAMA MAHMOUD\nEmployee card'),
        isNull,
      );
    });

    test('normalizes Arabic-Indic digits in a scanned card result', () {
      final result = extractNationalIdScanResult(
        'الرقم القومي\n٢٩٨٠١٠١١٢٣٤٥٦٧',
      );

      expect(result?.nationalId, '29801011234567');
    });

    test('joins spaced Arabic-Indic digits from a card number line', () {
      final result = extractNationalIdScanResult('٢٩٨٠ ١٠١١ ٢٣٤٥ ٦٧');

      expect(result?.nationalId, '29801011234567');
    });

    test('extracts an Arabic full name from OCR text', () {
      final result = extractNationalIdScanResult(
        'عبد الحميد محمد عبد العزيز\n٢٩٨٠١٠١١٢٣٤٥٦٧',
      );

      expect(result?.fullName, 'عبد الحميد محمد عبد العزيز');
    });
  });
}
