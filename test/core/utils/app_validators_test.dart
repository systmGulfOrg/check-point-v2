import 'package:flutter_test/flutter_test.dart';
import 'package:check_point_v2/core/utils/app_validators.dart';

void main() {
  group('AppValidators Tests', () {
    test('required validator correctly validates values', () {
      final validator = AppValidators.required(message: 'Required');
      expect(validator(null), 'Required');
      expect(validator(''), 'Required');
      expect(validator('   '), 'Required');
      expect(validator('valid text'), isNull);
    });

    test('name validator checks minimum length and empty', () {
      final validator = AppValidators.name(minLength: 3, message: 'Invalid name');
      expect(validator(null), 'Invalid name');
      expect(validator(''), 'Invalid name');
      expect(validator('ab'), 'Invalid name');
      expect(validator('abc'), isNull);
      expect(validator('Ahmed Ali'), isNull);
    });

    test('email validator checks proper format', () {
      final requiredValidator = AppValidators.email(message: 'Invalid email');
      expect(requiredValidator(null), 'Invalid email');
      expect(requiredValidator('not-an-email'), 'Invalid email');
      expect(requiredValidator('test@'), 'Invalid email');
      expect(requiredValidator('test@company.com'), isNull);

      final optionalValidator = AppValidators.email(isRequired: false, message: 'Invalid email');
      expect(optionalValidator(null), isNull);
      expect(optionalValidator(''), isNull);
      expect(optionalValidator('test@company.com'), isNull);
      expect(optionalValidator('invalid'), 'Invalid email');
    });

    test('phone validator checks digits format', () {
      final validator = AppValidators.phone(message: 'Invalid phone');
      expect(validator(null), 'Invalid phone');
      expect(validator('123'), 'Invalid phone');
      expect(validator('01012345678'), isNull);
      expect(validator('+201012345678'), isNull);
    });

    test('nationalId validator checks 14 digits', () {
      final validator = AppValidators.nationalId(message: 'Invalid ID');
      expect(validator(null), 'Invalid ID');
      expect(validator('123456'), 'Invalid ID');
      expect(validator('123456789012345'), 'Invalid ID');
      expect(validator('29901011234567'), isNull);
    });

    test('password validator checks minimum length', () {
      final validator = AppValidators.password(minLength: 6, message: 'Too short');
      expect(validator(null), 'Too short');
      expect(validator('12345'), 'Too short');
      expect(validator('123456'), isNull);
      expect(validator('strongPassword!'), isNull);
    });

    test('confirmPassword validator checks match', () {
      var password = 'Password123';
      final validator = AppValidators.confirmPassword(
        passwordGetter: () => password,
        message: 'Mismatch',
      );
      expect(validator('Password456'), 'Mismatch');
      expect(validator('Password123'), isNull);
    });

    test('number and positiveNumber validator check numerical values', () {
      final numValidator = AppValidators.number(min: 1, max: 100, message: 'Invalid number');
      expect(numValidator(null), 'Invalid number');
      expect(numValidator('abc'), 'Invalid number');
      expect(numValidator('0'), 'Invalid number');
      expect(numValidator('150'), 'Invalid number');
      expect(numValidator('50'), isNull);

      final posValidator = AppValidators.positiveNumber(message: 'Positive required');
      expect(posValidator('-5'), 'Positive required');
      expect(posValidator('10'), isNull);
    });

    test('coordinate validator checks lat/lng bounds', () {
      final latValidator = AppValidators.coordinate(isLatitude: true, message: 'Invalid lat');
      expect(latValidator('95'), 'Invalid lat');
      expect(latValidator('-95'), 'Invalid lat');
      expect(latValidator('30.0444'), isNull);

      final lngValidator = AppValidators.coordinate(isLatitude: false, message: 'Invalid lng');
      expect(lngValidator('190'), 'Invalid lng');
      expect(lngValidator('31.2357'), isNull);
    });
  });
}
