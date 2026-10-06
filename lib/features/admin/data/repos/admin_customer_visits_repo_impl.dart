import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/features/admin/data/models/locations/customer_visit_model.dart';
import 'admin_customer_visits_repo.dart';

class AdminCustomerVisitsRepoImpl implements AdminCustomerVisitsRepo {
  AdminCustomerVisitsRepoImpl();

  final List<CustomerVisitModel> _visits = [
    CustomerVisitModel(
      id: 'visit-1',
      customerId: '1',
      customerName: 'مجموعة الفطيم',
      title: 'اجتماع مناقشة تجديد عقد الصيانة السنوي',
      visitDate: '2026-09-28',
      visitTime: '10:30 ص',
      attendees: ['أحمد محمود (مدير الحساب)', 'سارة خالد (مهندس استشاري)'],
      documentName: 'proposal_sla_2026.pdf',
      documentUrl: 'https://example.com/docs/proposal.pdf',
      notes:
          'تمت مراجعة نطاق العمل والموافقة المبدئية على بنود الصيانة الدورية.',
      outcome:
          'تم الاتفاق على توقيع العقد الجديد مع زيادة 10% في القيمة التشغيلية.',
      status: 'completed',
      createdAt: '2026-09-25',
    ),
    CustomerVisitModel(
      id: 'visit-2',
      customerId: '1',
      customerName: 'مجموعة الفطيم',
      title: 'زيارة متابعة تركيب أجهزة البصمة وتدريب الفريق',
      visitDate: '2026-10-08',
      visitTime: '02:00 م',
      attendees: ['محمود علي (مسؤول تقني)', 'كريم عادل (دعم فني)'],
      documentName: 'user_guide_v2.pdf',
      documentUrl: 'https://example.com/docs/guide.pdf',
      notes: 'تسليم الأجهزة وشرح نظام الحضور والانصراف والربط بالخوادم.',
      outcome: null,
      status: 'scheduled',
      createdAt: '2026-10-01',
    ),
    CustomerVisitModel(
      id: 'visit-3',
      customerId: '2',
      customerName: 'شركة إعمار مصر',
      title: 'عرض نظام إدارة المشاريع والمهام الجديد',
      visitDate: '2026-09-20',
      visitTime: '11:00 ص',
      attendees: ['طارق نبيل (مدير مبيعات)'],
      documentName: 'presentation_pm.pdf',
      documentUrl: 'https://example.com/docs/pres.pdf',
      notes: 'اجتماع تعريفي مع إدارة العمليات لتقديم الخطة التجريبية.',
      outcome: 'طلبوا تجربة تجريبية لمدة أسبوعين لعدد 50 موظف.',
      status: 'completed',
      createdAt: '2026-09-18',
    ),
  ];

  @override
  Future<ApiResult<List<CustomerVisitModel>>> getCustomerVisits(
    String customerId,
  ) async {
    final list = _visits
        .where((v) => v.customerId == customerId || customerId.isEmpty)
        .toList();
    list.sort((a, b) => (b.visitDate ?? '').compareTo(a.visitDate ?? ''));
    return ApiResult.success(list);
  }

  @override
  Future<ApiResult<List<CustomerVisitModel>>> getAllVisits() async {
    final list = List<CustomerVisitModel>.from(_visits);
    list.sort((a, b) => (b.visitDate ?? '').compareTo(a.visitDate ?? ''));
    return ApiResult.success(list);
  }

  @override
  Future<ApiResult<void>> addVisitPlan(CustomerVisitModel visit) async {
    final newVisit = visit.copyWith(
      id: 'visit-${DateTime.now().millisecondsSinceEpoch}',
      createdAt: DateTime.now().toIso8601String().split('T').first,
    );
    _visits.insert(0, newVisit);
    return const ApiResult.success(null);
  }

  @override
  Future<ApiResult<void>> updateVisitOutcome({
    required String visitId,
    required String outcome,
    required String status,
    String? notes,
  }) async {
    final index = _visits.indexWhere((v) => v.id == visitId);
    if (index != -1) {
      _visits[index] = _visits[index].copyWith(
        outcome: outcome,
        status: status,
        notes: notes ?? _visits[index].notes,
      );
    }
    return const ApiResult.success(null);
  }
}
