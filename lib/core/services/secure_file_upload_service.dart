import 'dart:io';
import 'package:dio/dio.dart';
import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/core/network/api_failure_mapper.dart';

class PresignedUploadUrlModel {
  const PresignedUploadUrlModel({
    required this.uploadUrl,
    required this.fileUrl,
    required this.expiresIn,
  });

  final String uploadUrl;
  final String fileUrl;
  final int expiresIn;

  factory PresignedUploadUrlModel.fromJson(Map<String, dynamic> json) =>
      PresignedUploadUrlModel(
        uploadUrl: json['uploadUrl'] as String? ?? '',
        fileUrl: json['fileUrl'] as String? ?? '',
        expiresIn: (json['expiresIn'] as num?)?.toInt() ?? 3600,
      );
}

class SecureFileUploadService {
  SecureFileUploadService({required this.dio});

  final Dio dio;

  Future<ApiResult<PresignedUploadUrlModel>> getPresignedUrl({
    required String fileName,
    required String fileType,
    required String purpose, // LEAVE_ATTACHMENT, EMPLOYEE_PHOTO, NATIONAL_ID, CORRECTION_ATTACHMENT
  }) async {
    try {
      final response = await dio.post<Map<String, dynamic>>(
        '/api/v2/storage/presigned-url',
        data: {
          'fileName': fileName,
          'fileType': fileType,
          'purpose': purpose,
        },
      );
      final data = response.data?['value'] ?? response.data;
      return ApiResult.success(
        PresignedUploadUrlModel.fromJson(Map<String, dynamic>.from(data as Map)),
      );
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  Future<ApiResult<String>> uploadFile({
    required File file,
    required String purpose,
    String? customFileName,
    String? mimeType,
  }) async {
    try {
      final fileName = customFileName ?? file.path.split('/').last;
      final fileType = mimeType ?? 'application/octet-stream';

      final presignedRes = await getPresignedUrl(
        fileName: fileName,
        fileType: fileType,
        purpose: purpose,
      );

      return await presignedRes.when(
        success: (presigned) async {
          final fileBytes = await file.readAsBytes();
          final uploadDio = Dio();
          await uploadDio.put<void>(
            presigned.uploadUrl,
            data: fileBytes,
            options: Options(
              headers: {
                'Content-Type': fileType,
              },
            ),
          );
          return ApiResult.success(presigned.fileUrl);
        },
        failure: (f) => ApiResult.failure(f),
      );
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }
}
