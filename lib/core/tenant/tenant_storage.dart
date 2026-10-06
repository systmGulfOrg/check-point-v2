import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:check_point_v2/features/tenant/data/models/tenant_model.dart';

class TenantStorage {
  TenantStorage({required this.secureStorage});

  static const String tenantIdKey = 'tenant_id';
  static const String tenantCodeKey = 'tenant_code';
  static const String tenantSlugKey = 'tenant_slug';
  static const String tenantCompanyNameKey = 'tenant_company_name';
  static const String tenantLogoUrlKey = 'tenant_logo_url';
  static const String tenantBaseUrlKey = 'tenant_base_url';
  static const String tenantRawJsonKey = 'tenant_raw_json';

  final FlutterSecureStorage secureStorage;

  Future<void> saveTenant(TenantModel tenant) async {
    if (tenant.tenantId != null && tenant.tenantId!.isNotEmpty) {
      await secureStorage.write(key: tenantIdKey, value: tenant.tenantId);
    }
    final effectiveSlug = tenant.slug ?? tenant.tenantCode;
    if (effectiveSlug != null && effectiveSlug.isNotEmpty) {
      await secureStorage.write(key: tenantSlugKey, value: effectiveSlug);
      await secureStorage.write(key: tenantCodeKey, value: effectiveSlug);
    }
    final name = tenant.name ?? tenant.companyName;
    if (name != null && name.isNotEmpty) {
      await secureStorage.write(
        key: tenantCompanyNameKey,
        value: name,
      );
    }
    if (tenant.logoUrl != null && tenant.logoUrl!.isNotEmpty) {
      await secureStorage.write(key: tenantLogoUrlKey, value: tenant.logoUrl);
    }
    if (tenant.baseUrl != null && tenant.baseUrl!.isNotEmpty) {
      await secureStorage.write(key: tenantBaseUrlKey, value: tenant.baseUrl);
    }
    await secureStorage.write(
      key: tenantRawJsonKey,
      value: jsonEncode(tenant.toJson()),
    );
  }

  Future<TenantModel?> readTenant() async {
    final rawJson = await secureStorage.read(key: tenantRawJsonKey);
    if (rawJson != null && rawJson.isNotEmpty) {
      try {
        final map = jsonDecode(rawJson) as Map<String, dynamic>;
        return TenantModel.fromJson(map);
      } catch (_) {
        // Fallback to individual keys
      }
    }

    final tenantId = await secureStorage.read(key: tenantIdKey);
    final tenantCode = await secureStorage.read(key: tenantCodeKey);
    final tenantSlug = await secureStorage.read(key: tenantSlugKey);
    final companyName = await secureStorage.read(key: tenantCompanyNameKey);
    final logoUrl = await secureStorage.read(key: tenantLogoUrlKey);
    final baseUrl = await secureStorage.read(key: tenantBaseUrlKey);

    if (tenantId == null && tenantCode == null && tenantSlug == null && companyName == null) {
      return null;
    }

    final effectiveCode = tenantSlug ?? tenantCode ?? tenantId ?? '';
    return TenantModel(
      tenantId: tenantId,
      tenantCode: effectiveCode,
      slug: tenantSlug ?? effectiveCode,
      name: companyName ?? effectiveCode,
      companyName: companyName ?? effectiveCode,
      logoUrl: logoUrl,
      baseUrl: baseUrl,
    );
  }

  Future<String?> readTenantId() => secureStorage.read(key: tenantIdKey);

  Future<String?> readTenantCode() => secureStorage.read(key: tenantCodeKey);

  Future<String?> readTenantSlug() async {
    final slug = await secureStorage.read(key: tenantSlugKey);
    if (slug != null && slug.isNotEmpty) return slug;
    return secureStorage.read(key: tenantCodeKey);
  }

  Future<bool> hasTenant() async {
    final tenantId = await secureStorage.read(key: tenantIdKey);
    final tenantCode = await secureStorage.read(key: tenantCodeKey);
    final tenantSlug = await secureStorage.read(key: tenantSlugKey);
    return (tenantId != null && tenantId.isNotEmpty) ||
        (tenantCode != null && tenantCode.isNotEmpty) ||
        (tenantSlug != null && tenantSlug.isNotEmpty);
  }

  Future<void> clearTenant() async {
    await secureStorage.delete(key: tenantIdKey);
    await secureStorage.delete(key: tenantCodeKey);
    await secureStorage.delete(key: tenantSlugKey);
    await secureStorage.delete(key: tenantCompanyNameKey);
    await secureStorage.delete(key: tenantLogoUrlKey);
    await secureStorage.delete(key: tenantBaseUrlKey);
    await secureStorage.delete(key: tenantRawJsonKey);
  }
}
