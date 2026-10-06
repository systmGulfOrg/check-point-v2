import 'package:flutter_test/flutter_test.dart';
import 'package:check_point_v2/core/utils/code_generator_helper.dart';
import 'package:check_point_v2/features/contractor/data/models/contractor_batch_models.dart';
import 'package:check_point_v2/features/contractor/data/models/contractor_worker_model.dart';
import 'package:check_point_v2/features/contractor/data/models/lat_lng_point_model.dart';
import 'package:check_point_v2/features/contractor/data/models/site_boundary_model.dart';

void main() {
  group('Integration Flow: Site Supervisor Daily Contractor & Workforce Attendance', () {
    test('2.1 Worker Model and Code Generator integration', () {
      final workerCode = CodeGeneratorHelper.generateWorkerCode();
      expect(workerCode.startsWith('WRK-'), isTrue);
      expect(workerCode.length, 9); // WRK-XXXXX

      final worker = ContractorWorkerModel(
        id: 'wrk-001',
        name: 'محمود أحمد',
        workerCode: workerCode,
        nationalId: '29501010101234',
        position: 'نجار مسلح',
        contractorId: 'cnt-001',
        contractorName: 'شركة النيل للمقاولات',
        siteName: 'كوبري تحيا مصر',
      );

      expect(worker.displayName, 'محمود أحمد');
      expect(worker.displayCode, workerCode);
      expect(worker.nationalId, '29501010101234');
    });

    test('2.2 Batch Attendance Request Payload serialization', () {
      final req = BatchWorkerAttendanceRequestBody(
        siteId: 'site-cairo-01',
        contractorId: 'cnt-001',
        date: '2026-10-05',
        workerIds: ['wrk-001', 'wrk-002', 'wrk-003'],
        latitude: 29.9693,
        longitude: 31.3197,
      );

      final json = req.toJson();
      expect(json['site_id'], 'site-cairo-01');
      expect(json['contractor_id'], 'cnt-001');
      expect(json['date'], '2026-10-05');
      expect(json['worker_ids'], ['wrk-001', 'wrk-002', 'wrk-003']);
      expect(json['latitude'], 29.9693);
      expect(json['longitude'], 31.3197);
    });

    test('2.3 Batch Attendance Response with ONE_SITE_PER_DAY_VIOLATION handling', () {
      final summary = BatchWorkerAttendanceSummaryModel(
        totalSubmitted: 3,
        successfulCount: 2,
        failedCount: 1,
        results: [
          const SingleWorkerBatchResultModel(
            workerId: 'wrk-001',
            workerName: 'محمود أحمد',
            status: 'RECORDED',
          ),
          const SingleWorkerBatchResultModel(
            workerId: 'wrk-002',
            workerName: 'علي كمال',
            status: 'RECORDED',
          ),
          const SingleWorkerBatchResultModel(
            workerId: 'wrk-003',
            workerName: 'حسين إبراهيم',
            status: 'REJECTED',
            errorCode: 'ONE_SITE_PER_DAY_VIOLATION',
            errorMessage: 'العامل مسجل بالفعل اليوم في موقع: مشروع المارينا',
          ),
        ],
      );

      expect(summary.totalSubmitted, 3);
      expect(summary.successfulCount, 2);
      expect(summary.failedCount, 1);

      final rejectedItem = summary.results.firstWhere((r) => r.status == 'REJECTED');
      expect(rejectedItem.workerName, 'حسين إبراهيم');
      expect(rejectedItem.errorCode, 'ONE_SITE_PER_DAY_VIOLATION');
      expect(rejectedItem.errorMessage, contains('مشروع المارينا'));
    });

    test('2.4 Site Boundary Model maps polygon coordinates', () {
      final site = SiteBoundaryModel(
        siteIdUnderscore: 'site-01',
        siteNameUnderscore: 'مشروع محور 26 يوليو',
        projectName: 'سامكو للطرق والكباري',
        centerLat: 30.0123,
        centerLng: 31.2045,
        radiusMeters: 500,
        workerCount: 45,
        boundaryCoordinates: [
          const LatLngPointModel(lat: 30.010, lng: 31.200),
          const LatLngPointModel(lat: 30.020, lng: 31.200),
          const LatLngPointModel(lat: 30.020, lng: 31.210),
          const LatLngPointModel(lat: 30.010, lng: 31.210),
        ],
      );

      expect(site.siteName, 'مشروع محور 26 يوليو');
      expect(site.boundaryCoordinates.length, 4);
      expect(site.workerCount, 45);
    });
  });
}
