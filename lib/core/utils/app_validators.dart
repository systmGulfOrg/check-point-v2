import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';

class AppValidators {
  AppValidators._();

  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)+$',
  );

  static final RegExp _phoneRegExp = RegExp(r'^\+?[0-9]{8,15}$');
  static final RegExp _nationalIdRegExp = RegExp(r'^[0-9]{14}$');

  /// Validates that a string value is not null and not empty.
  static FormFieldValidator<String> required({
    String? message,
    BuildContext? context,
  }) {
    return (value) {
      if (value == null || value.trim().isEmpty) {
        return message ??
            (context != null
                ? 'validation.required'.tr(context: context)
                : 'validation.required'.tr());
      }
      return null;
    };
  }

  /// Validates name or text minimum length.
  static FormFieldValidator<String> name({
    int minLength = 2,
    String? message,
    BuildContext? context,
  }) {
    return (value) {
      if (value == null || value.trim().isEmpty) {
        return message ??
            (context != null
                ? 'validation.required'.tr(context: context)
                : 'validation.required'.tr());
      }
      if (value.trim().length < minLength) {
        return message ??
            (context != null
                ? 'validation.nameTooShort'.tr(
                    context: context,
                    namedArgs: {'min': minLength.toString()},
                  )
                : 'validation.nameTooShort'.tr(
                    namedArgs: {'min': minLength.toString()},
                  ));
      }
      return null;
    };
  }

  /// Validates email address format.
  static FormFieldValidator<String> email({
    String? message,
    bool isRequired = true,
    BuildContext? context,
  }) {
    return (value) {
      final trimmed = value?.trim() ?? '';
      if (trimmed.isEmpty) {
        if (!isRequired) return null;
        return message ??
            (context != null
                ? 'validation.required'.tr(context: context)
                : 'validation.required'.tr());
      }
      if (!_emailRegExp.hasMatch(trimmed)) {
        return message ??
            (context != null
                ? 'validation.invalidEmail'.tr(context: context)
                : 'validation.invalidEmail'.tr());
      }
      return null;
    };
  }

  /// Validates phone number format.
  static FormFieldValidator<String> phone({
    String? message,
    bool isRequired = true,
    BuildContext? context,
  }) {
    return (value) {
      final trimmed = value?.trim().replaceAll(' ', '') ?? '';
      if (trimmed.isEmpty) {
        if (!isRequired) return null;
        return message ??
            (context != null
                ? 'validation.required'.tr(context: context)
                : 'validation.required'.tr());
      }
      if (!_phoneRegExp.hasMatch(trimmed)) {
        return message ??
            (context != null
                ? 'validation.invalidPhone'.tr(context: context)
                : 'validation.invalidPhone'.tr());
      }
      return null;
    };
  }

  /// Validates 14-digit Egyptian National ID.
  static FormFieldValidator<String> nationalId({
    String? message,
    bool isRequired = true,
    BuildContext? context,
  }) {
    return (value) {
      final trimmed = value?.trim() ?? '';
      if (trimmed.isEmpty) {
        if (!isRequired) return null;
        return message ??
            (context != null
                ? 'validation.required'.tr(context: context)
                : 'validation.required'.tr());
      }
      if (!_nationalIdRegExp.hasMatch(trimmed)) {
        return message ??
            (context != null
                ? 'validation.invalidNationalId'.tr(context: context)
                : 'validation.invalidNationalId'.tr());
      }
      return null;
    };
  }

  /// Validates password minimum length.
  static FormFieldValidator<String> password({
    int minLength = 6,
    String? message,
    BuildContext? context,
  }) {
    return (value) {
      if (value == null || value.isEmpty) {
        return message ??
            (context != null
                ? 'validation.required'.tr(context: context)
                : 'validation.required'.tr());
      }
      if (value.length < minLength) {
        return message ??
            (context != null
                ? 'validation.passwordTooShort'.tr(
                    context: context,
                    namedArgs: {'min': minLength.toString()},
                  )
                : 'validation.passwordTooShort'.tr(
                    namedArgs: {'min': minLength.toString()},
                  ));
      }
      return null;
    };
  }

  /// Validates password confirmation matches original password.
  static FormFieldValidator<String> confirmPassword({
    required String Function() passwordGetter,
    String? message,
    BuildContext? context,
  }) {
    return (value) {
      if (value == null || value.isEmpty) {
        return message ??
            (context != null
                ? 'validation.required'.tr(context: context)
                : 'validation.required'.tr());
      }
      if (value != passwordGetter()) {
        return message ??
            (context != null
                ? 'validation.passwordsDoNotMatch'.tr(context: context)
                : 'validation.passwordsDoNotMatch'.tr());
      }
      return null;
    };
  }

  /// Validates numeric values and optional range.
  static FormFieldValidator<String> number({
    double? min,
    double? max,
    String? message,
    bool isRequired = true,
    BuildContext? context,
  }) {
    return (value) {
      final trimmed = value?.trim() ?? '';
      if (trimmed.isEmpty) {
        if (!isRequired) return null;
        return message ??
            (context != null
                ? 'validation.required'.tr(context: context)
                : 'validation.required'.tr());
      }
      final parsed = double.tryParse(trimmed);
      if (parsed == null) {
        return message ??
            (context != null
                ? 'validation.invalidNumber'.tr(context: context)
                : 'validation.invalidNumber'.tr());
      }
      if (min != null && parsed < min) {
        return message ??
            (context != null
                ? 'validation.positiveNumber'.tr(context: context)
                : 'validation.positiveNumber'.tr());
      }
      if (max != null && parsed > max) {
        return message ??
            (context != null
                ? 'validation.invalidNumber'.tr(context: context)
                : 'validation.invalidNumber'.tr());
      }
      return null;
    };
  }

  /// Validates positive numbers (> 0).
  static FormFieldValidator<String> positiveNumber({
    String? message,
    bool isRequired = true,
    BuildContext? context,
  }) {
    return number(
      min: 0.0001,
      message: message,
      isRequired: isRequired,
      context: context,
    );
  }

  /// Validates geographic latitude (-90 to 90) or longitude (-180 to 180).
  static FormFieldValidator<String> coordinate({
    required bool isLatitude,
    String? message,
    BuildContext? context,
  }) {
    return (value) {
      final trimmed = value?.trim() ?? '';
      if (trimmed.isEmpty) {
        return message ??
            (context != null
                ? 'validation.required'.tr(context: context)
                : 'validation.required'.tr());
      }
      final parsed = double.tryParse(trimmed);
      if (parsed == null) {
        return message ??
            (context != null
                ? 'validation.invalidCoordinate'.tr(context: context)
                : 'validation.invalidCoordinate'.tr());
      }
      final min = isLatitude ? -90.0 : -180.0;
      final max = isLatitude ? 90.0 : 180.0;
      if (parsed < min || parsed > max) {
        return message ??
            (context != null
                ? 'validation.invalidCoordinate'.tr(context: context)
                : 'validation.invalidCoordinate'.tr());
      }
      return null;
    };
  }

  /// Combines multiple validators into one.
  static FormFieldValidator<String> combine(
    List<FormFieldValidator<String>> validators,
  ) {
    return (value) {
      for (final validator in validators) {
        final error = validator(value);
        if (error != null) return error;
      }
      return null;
    };
  }
}
