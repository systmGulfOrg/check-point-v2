class EgyptianNationalIdInfo {
  const EgyptianNationalIdInfo({
    required this.isValid,
    this.birthDate,
    this.gender,
    this.governorate,
    this.governorateCode,
    this.century,
  });

  final bool isValid;
  final String? birthDate; // YYYY-MM-DD
  final String? gender; // Male, Female
  final String? governorate;
  final String? governorateCode;
  final String? century;

  static const Map<String, String> governorateCodes = {
    '01': 'القاهرة',
    '02': 'الإسكندرية',
    '03': 'بورسعيد',
    '04': 'السويس',
    '11': 'دمياط',
    '12': 'الدقهلية',
    '13': 'الشرقية',
    '14': 'القليوبية',
    '15': 'كفر الشيخ',
    '16': 'الغربية',
    '17': 'المنوفية',
    '18': 'البحيرة',
    '19': 'الإسماعيلية',
    '21': 'الجيزة',
    '22': 'بني سويف',
    '23': 'الفيوم',
    '24': 'المنيا',
    '25': 'أسيوط',
    '26': 'سوهاج',
    '27': 'قنا',
    '28': 'أسوان',
    '29': 'الأقصر',
    '31': 'البحر الأحمر',
    '32': 'الوادي الجديد',
    '33': 'مطروح',
    '34': 'شمال سيناء',
    '35': 'جنوب سيناء',
    '88': 'خارج الجمهورية',
  };
}

class EgyptianNationalIdParser {
  EgyptianNationalIdParser._();

  static EgyptianNationalIdInfo parse(String? id) {
    if (id == null) {
      return const EgyptianNationalIdInfo(isValid: false);
    }
    final cleanId = id.trim();
    if (cleanId.length != 14 || !RegExp(r'^[2-3][0-9]{13}$').hasMatch(cleanId)) {
      return const EgyptianNationalIdInfo(isValid: false);
    }

    final centuryDigit = cleanId[0];
    final yearPart = cleanId.substring(1, 3);
    final monthPart = cleanId.substring(3, 5);
    final dayPart = cleanId.substring(5, 7);
    final govPart = cleanId.substring(7, 9);
    final genderDigit = int.tryParse(cleanId[12]) ?? 0;

    final fullYear = centuryDigit == '2' ? '19$yearPart' : '20$yearPart';
    final month = int.tryParse(monthPart) ?? 0;
    final day = int.tryParse(dayPart) ?? 0;

    if (month < 1 || month > 12 || day < 1 || day > 31) {
      return const EgyptianNationalIdInfo(isValid: false);
    }

    final birthDateStr = '$fullYear-$monthPart-$dayPart';
    final governorateName = EgyptianNationalIdInfo.governorateCodes[govPart] ?? 'غير محدد';
    final genderName = (genderDigit % 2 != 0) ? 'Male' : 'Female';
    final centuryName = centuryDigit == '2' ? '1900s' : '2000s';

    return EgyptianNationalIdInfo(
      isValid: true,
      birthDate: birthDateStr,
      gender: genderName,
      governorate: governorateName,
      governorateCode: govPart,
      century: centuryName,
    );
  }
}
