import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/subscription/admin_subscription_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/subscription/admin_subscription_state.dart';

void showRequestMoreSeatsSheet(BuildContext context, {required int currentLimit}) {
  final cubit = context.read<AdminSubscriptionCubit>();
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.cardBackground,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => BlocProvider.value(
      value: cubit,
      child: AdminRequestMoreSeatsSheetWidget(currentLimit: currentLimit),
    ),
  );
}

class AdminRequestMoreSeatsSheetWidget extends StatefulWidget {
  const AdminRequestMoreSeatsSheetWidget({required this.currentLimit, super.key});

  final int currentLimit;

  @override
  State<AdminRequestMoreSeatsSheetWidget> createState() =>
      _AdminRequestMoreSeatsSheetWidgetState();
}

class _AdminRequestMoreSeatsSheetWidgetState
    extends State<AdminRequestMoreSeatsSheetWidget> {
  late final TextEditingController limitController;
  late final TextEditingController reasonController;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    limitController = TextEditingController(
      text: (widget.currentLimit + 10).toString(),
    );
    reasonController = TextEditingController();
  }

  @override
  void dispose() {
    limitController.dispose();
    reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AdminSubscriptionCubit, AdminSubscriptionState>(
      listener: (context, state) {
        switch (state) {
          case AdminSubscriptionRequestSent():
            CustomSnackBar.showSuccess(
              context,
              message: 'admin.subscription.requestSent'.tr(context: context),
            );
            Navigator.pop(context);
          case AdminSubscriptionRequestFailed(:final messageKey):
            CustomSnackBar.showError(
              context,
              message: messageKey.tr(context: context),
            );
          default:
            break;
        }
      },
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            20.w,
            18.h,
            20.w,
            MediaQuery.viewInsetsOf(context).bottom + 16.h,
          ),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'admin.subscription.requestMoreSeatsTitle'.tr(
                      context: context,
                    ),
                    style: AppTextStyles.font18Bold,
                  ),
                  hSpace(6),
                  Text(
                    'admin.subscription.requestMoreSeatsSubtitle'.tr(
                      context: context,
                      args: ['${widget.currentLimit}'],
                    ),
                    style: AppTextStyles.font13Regular.copyWith(
                      color: AppColors.placeholder,
                    ),
                  ),
                  hSpace(16),
                  CustomTextFormField(
                    controller: limitController,
                    hintText: 'admin.subscription.newLimitHint'.tr(
                      context: context,
                    ),
                    keyboardType: TextInputType.number,
                    prefixIcon: Icon(Icons.people_outline_rounded, size: 19.r),
                    validator: (value) {
                      final parsed = int.tryParse(value?.trim() ?? '');
                      if (parsed == null || parsed <= widget.currentLimit) {
                        return 'admin.subscription.newLimitInvalid'.tr(
                          context: context,
                          args: ['${widget.currentLimit}'],
                        );
                      }
                      return null;
                    },
                  ),
                  hSpace(12),
                  CustomTextFormField(
                    controller: reasonController,
                    hintText: 'admin.subscription.reasonHint'.tr(
                      context: context,
                    ),
                    maxLines: 3,
                    prefixIcon: Icon(Icons.edit_note_rounded, size: 19.r),
                  ),
                  hSpace(20),
                  SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      text: 'admin.subscription.submitRequest'.tr(
                        context: context,
                      ),
                      onTap: () {
                        if (!(formKey.currentState?.validate() ?? false)) {
                          return;
                        }
                        context.read<AdminSubscriptionCubit>().requestMoreSeats(
                          requestedLimit: int.parse(limitController.text.trim()),
                          reason: reasonController.text.trim().isEmpty
                              ? null
                              : reasonController.text.trim(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
