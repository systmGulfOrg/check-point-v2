import 'package:check_point_v2/core/network/api_failure_mapper.dart';
import 'package:check_point_v2/core/network/api_result.dart';
import '../apis/contractor_api_service.dart';
import '../models/contractor_company_model.dart';
import '../models/contractor_worker_model.dart';
import '../models/site_boundary_model.dart';
import '../models/worker_site_assignment_model.dart';
import '../models/contractor_attendance_model.dart';
import '../models/contractor_correction_model.dart';
import '../models/offline_attendance_log_model.dart';
import '../models/samco_customization_model.dart';
import 'contractor_repo.dart';

class ContractorRepoImpl implements ContractorRepo {
  ContractorRepoImpl({required this.api});

  final ContractorApiService api;

  Map<String, dynamic> _envelope(dynamic response) =>
      response is Map<String, dynamic>
      ? response
      : Map<String, dynamic>.from(response as Map);

  dynamic _value(dynamic response) => _envelope(response)['value'];

  List<Map<String, dynamic>> _listValue(dynamic response) {
    final value = _value(response);
    final listValue = value is Map ? value['items'] : value;
    if (listValue is! List) return const [];
    return listValue
        .whereType<Map>()
        .map((item) => Map<String, dynamic>.from(item))
        .toList();
  }

  Map<String, dynamic> _mapValue(dynamic response) {
    final value = _value(response);
    return value is Map
        ? Map<String, dynamic>.from(value)
        : <String, dynamic>{};
  }

  ContractorCompanyModel _contractorFromJson(Map<String, dynamic> json) {
    final count = json['_count'];
    return ContractorCompanyModel.fromJson({
      ...json,
      'workerCount': count is Map ? count['workers'] ?? 0 : 0,
      'presentCount': json['presentCount'] ?? 0,
    });
  }

  ContractorWorkerModel _workerFromJson(Map<String, dynamic> json) {
    final branch = json['branch'];
    final assignments = json['siteAssignments'];
    final assignment = assignments is List && assignments.isNotEmpty
        ? assignments.first
        : null;
    final site = assignment is Map ? assignment['site'] : branch;
    return ContractorWorkerModel.fromJson({
      ...json,
      'fullName': json['fullName'] ?? json['name'] ?? '',
      'workerCode': json['workerCode'] ?? json['employeeCode'] ?? json['id'],
      'nationalId': json['nationalId'] ?? '',
      'phone': json['phone'] ?? '',
      'jobTitle': json['jobTitle'] ?? '',
      'projectName': json['projectName'] ?? '',
      'siteName': site is Map ? site['name'] ?? '' : '',
      'startDate': json['startDate'] ?? '',
      'contractorId': json['contractorId'],
      'contractorName': json['contractor'] is Map
          ? json['contractor']['name']
          : null,
    });
  }

  SiteBoundaryModel _siteFromJson(Map<String, dynamic> json) {
    final project = json['project'];
    final count = json['_count'];
    return SiteBoundaryModel.fromJson({
      ...json,
      'siteId': json['siteId'] ?? json['id'],
      'siteName': json['siteName'] ?? json['name'] ?? '',
      'boundaryType': json['boundaryType'] ?? json['boundary_type'] ?? 'circle',
      'centerLat': json['centerLat'] ?? json['latitude'],
      'centerLng': json['centerLng'] ?? json['longitude'],
      'radiusMeters': json['radiusMeters'] ?? json['geofenceRadiusM'] ?? 150,
      'boundaryCoordinates':
          json['boundaryCoordinates'] ??
          json['boundary_coordinates'] ??
          json['coordinates'] ??
          const [],
      'projectId': json['projectId'] ?? project?['id'],
      'projectName': json['projectName'] ?? project?['name'],
      'status':
          json['status'] ?? (json['isActive'] == false ? 'archived' : 'active'),
      'workerCount': count is Map ? count['employees'] ?? 0 : 0,
      'assignmentCount': count is Map ? count['siteAssignments'] ?? 0 : 0,
    });
  }

  WorkerSiteAssignmentModel _assignmentFromJson(Map<String, dynamic> json) {
    final worker = json['worker'];
    final site = json['site'];
    final project = json['project'];
    final contractor = worker is Map ? worker['contractor'] : null;
    return WorkerSiteAssignmentModel.fromJson({
      ...json,
      'workerId': json['workerId'] ?? worker?['id'] ?? '',
      'workerName': json['workerName'] ?? worker?['name'] ?? '',
      'branchId': json['branchId'] ?? json['siteId'] ?? site?['id'] ?? '',
      'siteName': json['siteName'] ?? site?['name'] ?? '',
      'validFrom': json['validFrom'] ?? json['startDate'],
      'validUntil': json['validUntil'] ?? json['endDate'],
      'contractorId': json['contractorId'] ?? contractor?['id'],
      'contractorName': json['contractorName'] ?? contractor?['name'],
      'projectId': json['projectId'] ?? project?['id'],
      'projectName': json['projectName'] ?? project?['name'],
    });
  }

  ContractorAttendanceModel _attendanceFromJson(Map<String, dynamic> json) {
    final employee = json['employee'] is Map
        ? Map<String, dynamic>.from(json['employee'] as Map)
        : const <String, dynamic>{};
    final workedMinutes = json['workedMinutes'];
    return ContractorAttendanceModel.fromJson({
      ...json,
      'id': json['id'] ?? '',
      'workerId':
          json['workerId'] ?? json['employeeId'] ?? employee['id'] ?? '',
      'workerName':
          json['workerName'] ?? json['employeeName'] ?? employee['name'] ?? '',
      'workerCode': json['workerCode'] ?? employee['employeeCode'] ?? '',
      'jobTitle': json['jobTitle'] ?? employee['position'] ?? '',
      'siteName': json['siteName'] ?? '',
      'projectName': json['projectName'] ?? '',
      'date': json['date'] ?? json['attendanceDate']?.toString() ?? '',
      'status':
          json['status'] ??
          (json['isLate'] == true
              ? 'Late'
              : (json['clockOutTime'] == null ? 'Present' : 'Checked Out')),
      'checkInTime': json['checkInTime'] ?? json['clockInTime']?.toString(),
      'checkOutTime': json['checkOutTime'] ?? json['clockOutTime']?.toString(),
      'workedHours':
          json['workedHours'] ??
          (workedMinutes is num
              ? '${workedMinutes ~/ 60}h ${workedMinutes.toInt() % 60}m'
              : null),
      'isInsideGeofence': json['isInsideGeofence'] ?? true,
      'isOfflineSynced': json['isOfflineSynced'] ?? false,
      'contractorId': json['contractorId'],
      'deviceUuid': json['deviceUuid'],
      'siteId': json['siteId'],
      'projectId': json['projectId'],
    });
  }

  @override
  Future<ApiResult<List<ContractorCompanyModel>>> getContractors() async {
    try {
      final response = await api.getContractors();
      return ApiResult.success(
        _listValue(response).map(_contractorFromJson).toList(),
      );
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<ContractorCompanyModel>> createContractor(
    Map<String, dynamic> body,
  ) async {
    try {
      final response = await api.createContractor(body);
      return ApiResult.success(_contractorFromJson(_mapValue(response)));
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<List<ContractorWorkerModel>>> getContractorWorkers(
    String contractorId,
  ) async {
    try {
      final response = await api.getContractorWorkers(contractorId);
      return ApiResult.success(
        _listValue(response).map(_workerFromJson).toList(),
      );
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<ContractorWorkerModel>> createContractorWorker(
    String contractorId,
    Map<String, dynamic> body,
  ) async {
    try {
      final response = await api.createContractorWorker(contractorId, body);
      return ApiResult.success(_workerFromJson(_mapValue(response)));
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<SiteBoundaryModel>> getSiteBoundary(String siteId) async {
    try {
      final response = await api.getSiteBoundary(siteId);
      return ApiResult.success(_siteFromJson(_mapValue(response)));
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<List<WorkerSiteAssignmentModel>>> assignWorkerToSite(
    Map<String, dynamic> body,
  ) async {
    try {
      final response = await api.assignWorkerToSite(body);
      return ApiResult.success(
        _listValue(response).map(_assignmentFromJson).toList(),
      );
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<ContractorAttendanceModel>> checkIn(
    Map<String, dynamic> body,
  ) async {
    try {
      final response = await api.checkIn(body);
      return ApiResult.success(_attendanceFromJson(_mapValue(response)));
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<ContractorAttendanceModel>> checkOut(
    Map<String, dynamic> body,
  ) async {
    try {
      final response = await api.checkOut(body);
      return ApiResult.success(_attendanceFromJson(_mapValue(response)));
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<Map<String, dynamic>>> syncAttendanceBatch(
    List<OfflineAttendanceLogModel> logs,
  ) async {
    try {
      final response = await api.syncAttendanceBatch({
        'records': logs
            .map(
              (log) => {
                'client_uuid': log.localId,
                'worker_id': log.workerId,
                'type': log.punchType,
                'timestamp': log.timestamp,
                'lat': log.latitude,
                'lng': log.longitude,
                'site_id': log.siteId,
                'project_id': log.projectId,
                'contractor_id': log.contractorId,
                'device_uuid': log.deviceUuid,
              },
            )
            .toList(),
      });
      return ApiResult.success(_mapValue(response));
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<ContractorCorrectionModel>> submitCorrection(
    Map<String, dynamic> body,
  ) async {
    try {
      final response = await api.submitCorrection(body);
      return ApiResult.success(
        ContractorCorrectionModel.fromJson(_mapValue(response)),
      );
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<List<ContractorCorrectionModel>>> getCorrections({
    String? status,
  }) async {
    try {
      final response = await api.getCorrections(status: status);
      return ApiResult.success(
        _listValue(response).map((json) {
          final employee = json['employee'] is Map ? json['employee'] : null;
          final attendance = json['attendance'] is Map
              ? json['attendance']
              : null;
          return ContractorCorrectionModel.fromJson({
            ...json,
            'workerId':
                json['workerId'] ?? json['employeeId'] ?? employee?['id'] ?? '',
            'workerName': json['workerName'] ?? employee?['name'] ?? '',
            'workerCode': json['workerCode'] ?? employee?['employeeCode'] ?? '',
            'date':
                json['date'] ?? attendance?['attendanceDate']?.toString() ?? '',
            'requestedCheckIn':
                json['requestedCheckIn'] ??
                json['proposedClockIn']?.toString() ??
                '',
            'requestedCheckOut':
                json['requestedCheckOut'] ??
                json['proposedClockOut']?.toString() ??
                '',
            'reason': json['reason'] ?? '',
            'status': json['status'] ?? 'Pending',
            'createdAt': json['createdAt']?.toString() ?? '',
            'supervisorNotes': json['supervisorNotes'] ?? json['reviewNote'],
          });
        }).toList(),
      );
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<ContractorCorrectionModel>> updateCorrectionStatus({
    required String correctionId,
    required Map<String, dynamic> body,
  }) async {
    try {
      final response = await api.updateCorrectionStatus(correctionId, body);
      return ApiResult.success(
        ContractorCorrectionModel.fromJson(_mapValue(response)),
      );
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<SamcoCustomizationModel>> getCustomization() async {
    try {
      final value = _mapValue(await api.getCustomization());
      final labels = value['labelOverrides'];
      return ApiResult.success(
        SamcoCustomizationModel.fromJson({
          ...value,
          'workerLabel': labels is Map ? labels['employee'] : null,
          'workersLabel': labels is Map ? labels['employees'] : null,
          'siteLabel': labels is Map ? labels['branch'] : null,
          'sitesLabel': labels is Map ? labels['branches'] : null,
          'contractorLabel': labels is Map ? labels['manager'] : null,
          'contractorsLabel': labels is Map ? labels['managers'] : null,
        }),
      );
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<List<SiteBoundaryModel>>> getSites({
    String? projectId,
    String? search,
  }) async {
    try {
      final response = await api.getSites(projectId: projectId, search: search);
      return ApiResult.success(
        _listValue(response).map(_siteFromJson).toList(),
      );
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<SiteBoundaryModel>> createSite(
    Map<String, dynamic> body,
  ) async {
    try {
      final response = await api.createSite(body);
      return ApiResult.success(_siteFromJson(_mapValue(response)));
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<List<WorkerSiteAssignmentModel>>> getWorkerAssignments({
    String? siteId,
    String? projectId,
    String? workerId,
    bool? isActive,
  }) async {
    try {
      final response = await api.getWorkerAssignments(
        siteId: siteId,
        projectId: projectId,
        workerId: workerId,
        isActive: isActive,
      );
      return ApiResult.success(
        _listValue(response).map(_assignmentFromJson).toList(),
      );
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<List<ContractorAttendanceModel>>> getAttendance({
    int index = 0,
    int itemCount = 50,
    String? from,
    String? to,
  }) async {
    try {
      final response = await api.getAttendance(
        index: index,
        itemCount: itemCount,
        from: from,
        to: to,
      );
      return ApiResult.success(
        _listValue(response).map(_attendanceFromJson).toList(),
      );
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }
}
