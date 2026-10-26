import 'dart:math';

class UuidHelper {
  static final Random _random = Random.secure();

  static String generateV4() {
    final values = List<int>.generate(16, (i) => _random.nextInt(256));
    // Set version 4: 0100 in high 4 bits of byte 6
    values[6] = (values[6] & 0x0f) | 0x40;
    // Set variant: 10 in high 2 bits of byte 8
    values[8] = (values[8] & 0x3f) | 0x80;

    final hex = values.map((b) => b.toRadixString(16).padLeft(2, '0')).toList();
    return '${hex.sublist(0, 4).join()}-${hex.sublist(4, 6).join()}-${hex.sublist(6, 8).join()}-${hex.sublist(8, 10).join()}-${hex.sublist(10, 16).join()}';
  }
}
