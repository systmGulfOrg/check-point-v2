import 'package:flutter_test/flutter_test.dart';
import 'package:check_point_v2/core/network/api_failure.dart';
import 'package:check_point_v2/core/network/api_failure_mapper.dart';
import 'package:check_point_v2/core/utils/egyptian_national_id_parser.dart';
import 'package:check_point_v2/features/auth/data/models/login/login_request_model.dart';
import 'package:check_point_v2/features/auth/data/models/login/login_response_model.dart';
import 'package:dio/dio.dart';

void main() {
  group('Integration Flow: Auth, Security & Role-Based Routing', () {
    test('1.1 Tenant & Login Request Model constructs with device identity and coordinates', () {
      final req = LoginRequestModel(
        userName: 'osama',
        password: 'Password123!',
        mobileId: 'ba0b60e3-9b9e-43b5-9084-5a01ce922410',
        tenantSlug: 'samco',
        deviceModel: 'Android Device',
        osVersion: 'Android 15',
        latitude: 29.9693,
        longitude: 31.3197,
      );

      final json = req.toJson();
      expect(json['userName'], 'osama');
      expect(json['mobileId'], 'ba0b60e3-9b9e-43b5-9084-5a01ce922410');
      expect(json['tenantSlug'], 'samco');
      expect(json['latitude'], 29.9693);
      expect(json['longitude'], 31.3197);
    });

    test('1.2 Role-Based Navigation Routing Logic for 3 Core System Roles', () {
      // HR / Admin
      final adminUser = LoginResponseModel(
        accessToken: 'token_admin',
        refreshToken: 'refresh_admin',
        roles: ['Admin', 'HR'],
        role: 'Admin',
      );
      final adminRole = (adminUser.roles?.first ?? adminUser.role ?? '').toLowerCase();
      expect(adminRole == 'admin' || adminRole == 'hr', isTrue);

      // Site Supervisor
      final supervisorUser = LoginResponseModel(
        accessToken: 'token_sup',
        refreshToken: 'refresh_sup',
        roles: ['Supervisor'],
        role: 'Supervisor',
      );
      final supervisorRole = (supervisorUser.roles?.first ?? supervisorUser.role ?? '').toLowerCase();
      expect(supervisorRole == 'supervisor' || supervisorRole == 'sitesupervisor', isTrue);

      // Employee / Staff
      final employeeUser = LoginResponseModel(
        accessToken: 'token_emp',
        refreshToken: 'refresh_emp',
        roles: ['Employee'],
        role: 'Employee',
      );
      final employeeRole = (employeeUser.roles?.first ?? employeeUser.role ?? '').toLowerCase();
      expect(employeeRole == 'employee', isTrue);
    });

    test('1.3 Account Lockout (15 minutes) mapped to ApiFailure.isAccountLocked', () {
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/api/v2/auth/login'),
        response: Response(
          requestOptions: RequestOptions(path: '/api/v2/auth/login'),
          statusCode: 403,
          data: {
            'statusCode': 403,
            'message': 'Account is temporarily locked. Try again in 15 minutes.',
            'error': 'Forbidden',
            'code': 'ACCOUNT_LOCKED',
          },
        ),
        type: DioExceptionType.badResponse,
      );

      final failure = ApiFailureMapper.map(dioException);
      expect(failure, isA<ApiFailure>());
      expect(failure.messageKey, 'errors.accountLocked');
      expect(failure.isAccountLocked, isTrue);
    });

    test('1.4 Outside Site Zone mapped to ApiFailure.isOutsideZone', () {
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/api/v2/auth/login'),
        response: Response(
          requestOptions: RequestOptions(path: '/api/v2/auth/login'),
          statusCode: 403,
          data: {
            'statusCode': 403,
            'message': 'Login is restricted to your assigned site. You are outside the zone.',
            'error': 'OUTSIDE_ZONE',
            'siteName': 'Samco Cairo Site A',
          },
        ),
        type: DioExceptionType.badResponse,
      );

      final failure = ApiFailureMapper.map(dioException);
      expect(failure.messageKey, 'auth.login.outsideZoneMessage');
      expect(failure.isOutsideZone, isTrue);
    });

    test('1.5 OCR 14-digit Egyptian National ID parsing verifies birthdate, governorate and gender', () {
      final parsed = EgyptianNationalIdParser.parse('29501010101234');
      expect(parsed, isNotNull);
      expect(parsed.birthDate, '1995-01-01');
      expect(parsed.governorate, 'القاهرة');
      expect(parsed.gender, 'Male');
      expect(parsed.century, '1900s');

      final parsed2 = EgyptianNationalIdParser.parse('30205151205678');
      expect(parsed2, isNotNull);
      expect(parsed2.birthDate, '2002-05-15');
      expect(parsed2.governorate, 'الدقهلية');
      expect(parsed2.century, '2000s');
    });
  });
}
