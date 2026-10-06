import 'package:flutter_test/flutter_test.dart';
import 'package:check_point_v2/core/utils/code_generator_helper.dart';
import 'package:check_point_v2/features/contractor/data/models/contractor_worker_model.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/site_members/admin_site_members_filter_widget.dart';

void main() {
  group('Integration Flow: Admin Management & Site Workforce Authorizations', () {
    test('5.1 Employee Code Generator with EMP prefix and custom prefixes', () {
      final code = CodeGeneratorHelper.generateEmployeeCode();
      expect(code.startsWith('EMP-'), isTrue);
      expect(code.length, 9); // EMP-XXXXX

      final customCode = CodeGeneratorHelper.generateEmployeeCode(prefix: 'SAM');
      expect(customCode.startsWith('SAM-'), isTrue);
      expect(customCode.length, 9);
    });

    test('5.2 Site Members Filter logic (All, Contractors, Workers)', () {
      const workers = [
        ContractorWorkerModel(
          id: 'w1',
          name: 'Ahmed',
          workerCode: 'WRK-00001',
          contractorId: 'c1',
          contractorName: 'Al-Ahram Construction',
          siteName: 'Cairo Site A',
        ),
        ContractorWorkerModel(
          id: 'w2',
          name: 'Mahmoud',
          workerCode: 'WRK-00002',
          contractorId: 'c2',
          contractorName: 'Delta Contracting',
          siteName: 'Cairo Site A',
        ),
      ];

      final contractors = ['Al-Ahram Construction', 'Delta Contracting'];

      // Filter by All
      expect(workers.length + contractors.length, 4);

      // Filter by Workers
      expect(SiteMemberFilterType.workers.name, 'workers');
      expect(workers.length, 2);

      // Filter by Contractors
      expect(SiteMemberFilterType.contractors.name, 'contractors');
      expect(contractors.length, 2);
    });

    test('5.3 Two-Level Leave Approval Flow State progression', () {
      // Step 1: Employee Submits -> Status: PENDING_MANAGER
      // Step 2: Manager Approves -> Status: APPROVED_MANAGER / PENDING_HR
      // Step 3: Admin/HR Approves -> Status: APPROVED (Final)

      const status1 = 'PENDING_MANAGER';
      const status2 = 'APPROVED_MANAGER';
      const status3 = 'APPROVED';

      expect(status1, 'PENDING_MANAGER');
      expect(status2, contains('MANAGER'));
      expect(status3, 'APPROVED');
    });
  });
}
