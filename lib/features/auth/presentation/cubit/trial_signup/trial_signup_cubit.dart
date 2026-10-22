import 'package:check_point_v2/core/bloc/safe_cubit.dart';
import 'package:check_point_v2/features/auth/data/models/trial_signup/trial_signup_request_body.dart';
import 'package:check_point_v2/features/auth/data/repos/auth_repo.dart';
import 'package:check_point_v2/features/auth/presentation/cubit/trial_signup/trial_signup_state.dart';

class TrialSignupCubit extends SafeCubit<TrialSignupState> {
  TrialSignupCubit({required this.authRepo})
    : super(const TrialSignupState.initial());

  final AuthRepo authRepo;

  Future<void> submit({
    required String companyName,
    required String slug,
    required String contactEmail,
    required String adminName,
    required String adminUserName,
    required String password,
    String? contactPhone,
    String? country,
  }) async {
    emit(const TrialSignupState.loading());
    final request = TrialSignupRequestBody(
      companyName: companyName.trim(),
      slug: slug.trim().toLowerCase(),
      contactEmail: contactEmail.trim().toLowerCase(),
      adminName: adminName.trim(),
      adminUserName: adminUserName.trim().toLowerCase(),
      password: password,
      acceptTerms: true,
      contactPhone: (contactPhone == null || contactPhone.trim().isEmpty)
          ? null
          : contactPhone.trim(),
      country: (country == null || country.trim().isEmpty)
          ? null
          : country.trim(),
    );
    final result = await authRepo.createTrialSignup(request);
    result.when(
      success: (signup) => safeEmit(TrialSignupState.success(signup)),
      failure: (failure) =>
          safeEmit(TrialSignupState.error(failure.messageKey)),
    );
  }
}
