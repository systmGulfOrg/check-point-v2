import 'package:check_point_v2/core/network/api_failure.dart';
import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/core/tenant/tenant_storage.dart';
import 'package:check_point_v2/features/tenant/data/models/tenant_model.dart';
import 'package:check_point_v2/features/tenant/data/repos/tenant_repo.dart';
import 'package:check_point_v2/features/tenant/presentation/cubit/tenant_lookup_cubit.dart';
import 'package:check_point_v2/features/tenant/presentation/cubit/tenant_lookup_state.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeTenantRepo implements TenantRepo {
  _FakeTenantRepo({this.lookupResult});

  ApiResult<TenantModel>? lookupResult;
  TenantModel? savedTenant;

  @override
  Future<ApiResult<TenantModel>> lookupTenant(String companyCode) async {
    return lookupResult ??
        ApiResult.success(
          TenantModel(
            tenantId: companyCode,
            tenantCode: companyCode,
            companyName: 'Test Company',
          ),
        );
  }

  @override
  Future<TenantModel?> getSavedTenant() async => savedTenant;

  @override
  Future<void> saveTenant(TenantModel tenant) async {
    savedTenant = tenant;
  }

  @override
  Future<void> clearTenant() async {
    savedTenant = null;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  FlutterSecureStorage.setMockInitialValues({});

  group('TenantLookupCubit', () {
    test('emits loading and success when lookup succeeds', () async {
      final fakeTenant = const TenantModel(
        tenantId: 'demo-123',
        tenantCode: 'demo',
        companyName: 'Demo Company',
      );
      final repo = _FakeTenantRepo(
        lookupResult: ApiResult.success(fakeTenant),
      );
      final cubit = TenantLookupCubit(tenantRepo: repo);
      addTearDown(cubit.close);

      expectLater(
        cubit.stream,
        emitsInOrder([
          const TenantLookupState.loading(),
          TenantLookupState.success(fakeTenant),
        ]),
      );

      await cubit.lookupTenant('demo');
    });

    test('emits error when company code is empty', () async {
      final repo = _FakeTenantRepo();
      final cubit = TenantLookupCubit(tenantRepo: repo);
      addTearDown(cubit.close);

      expectLater(
        cubit.stream,
        emitsInOrder([
          const TenantLookupState.error('tenant.lookup.required'),
        ]),
      );

      await cubit.lookupTenant('   ');
    });

    test('emits error when repository returns failure', () async {
      final repo = _FakeTenantRepo(
        lookupResult: const ApiResult.failure(
          ApiFailure(messageKey: 'errors.notFound'),
        ),
      );
      final cubit = TenantLookupCubit(tenantRepo: repo);
      addTearDown(cubit.close);

      expectLater(
        cubit.stream,
        emitsInOrder([
          const TenantLookupState.loading(),
          const TenantLookupState.error('errors.notFound'),
        ]),
      );

      await cubit.lookupTenant('unknown-corp');
    });
  });

  group('TenantStorage', () {
    test('saves, reads and clears tenant', () async {
      final storage = TenantStorage(
        secureStorage: const FlutterSecureStorage(),
      );

      expect(await storage.hasTenant(), isFalse);

      final tenant = const TenantModel(
        tenantId: 't-001',
        tenantCode: 'systm-gulf',
        companyName: 'Systm Gulf',
      );

      await storage.saveTenant(tenant);
      expect(await storage.hasTenant(), isTrue);

      final loaded = await storage.readTenant();
      expect(loaded?.tenantId, 't-001');
      expect(loaded?.tenantCode, 'systm-gulf');
      expect(loaded?.companyName, 'Systm Gulf');

      await storage.clearTenant();
      expect(await storage.hasTenant(), isFalse);
    });
  });
}
