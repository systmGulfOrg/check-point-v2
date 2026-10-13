import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import '../cubit/exchange_cubit.dart';
import '../cubit/exchange_state.dart';
import '../cubit/points_cubit.dart';

class PointExchangeScreen extends StatefulWidget {
  const PointExchangeScreen({super.key});

  @override
  State<PointExchangeScreen> createState() => _PointExchangeScreenState();
}

class _PointExchangeScreenState extends State<PointExchangeScreen> {
  String _selectedTarget = 'RED'; // 'RED' or 'BLACK'
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    final pointsCubit = context.watch<PointsCubit>();
    final balances = pointsCubit.currentSummary?.balances;
    final confirmedGreen = balances?.greenConfirmed ?? 0;
    final redBalance = balances?.red ?? 0;
    final blackBalance = balances?.black ?? 0;

    final maxPossible = _selectedTarget == 'RED' ? redBalance : blackBalance;
    final unitCost = _selectedTarget == 'RED' ? 1 : 30;
    final totalGreenCost = _quantity * unitCost;
    final canExchange = confirmedGreen >= totalGreenCost && maxPossible > 0 && _quantity > 0;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          'points.exchangeTitle'.tr(context: context),
          style: AppTextStyles.font18Bold,
        ),
        centerTitle: true,
        backgroundColor: AppColors.white,
        elevation: 0,
      ),
      body: BlocConsumer<ExchangeCubit, ExchangeState>(
        listener: (context, state) {
          switch (state) {
            case ExchangeSuccess():
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'points.exchangeSuccess'.tr(context: context),
                  ),
                  backgroundColor: AppColors.success,
                ),
              );
              context.read<PointsCubit>().loadAllPointsData();
              Navigator.of(context).pop();
            case ExchangeError(:final message):
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message),
                  backgroundColor: AppColors.error,
                ),
              );
            default:
              break;
          }
        },
        builder: (context, state) {
          final isLoading = state is ExchangeLoading;

          return SingleChildScrollView(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Info Banner
                Container(
                  padding: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    color: AppColors.brandPrimary.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: AppColors.brandPrimary.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.swap_horiz_rounded,
                        color: AppColors.brandPrimary,
                        size: 28.r,
                      ),
                      wSpace(12),
                      Expanded(
                        child: Text(
                          'points.exchangeDesc'.tr(context: context),
                          style: AppTextStyles.font14Regular.copyWith(
                            color: AppColors.brandPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                hSpace(20),

                // Balance summary chips
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(12.r),
                        decoration: BoxDecoration(
                          color: AppColors.cardBackground,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'points.greenConfirmed'.tr(context: context),
                              style: AppTextStyles.font12Regular.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                            hSpace(4),
                            Text(
                              '$confirmedGreen',
                              style: AppTextStyles.font18Bold.copyWith(
                                color: AppColors.success,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    wSpace(12),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(12.r),
                        decoration: BoxDecoration(
                          color: AppColors.cardBackground,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _selectedTarget == 'RED'
                                  ? 'points.red'.tr(context: context)
                                  : 'points.black'.tr(context: context),
                              style: AppTextStyles.font12Regular.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                            hSpace(4),
                            Text(
                              '${_selectedTarget == 'RED' ? redBalance : blackBalance}',
                              style: AppTextStyles.font18Bold.copyWith(
                                color: _selectedTarget == 'RED'
                                    ? AppColors.error
                                    : AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                hSpace(24),

                // Target penalty selector
                Text(
                  'points.exchangeTarget'.tr(context: context),
                  style: AppTextStyles.font14Bold,
                ),
                hSpace(10),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _selectedTarget = 'RED';
                            _quantity = redBalance > 0 ? 1 : 0;
                          });
                        },
                        borderRadius: BorderRadius.circular(10.r),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 10.w),
                          decoration: BoxDecoration(
                            color: _selectedTarget == 'RED'
                                ? AppColors.error.withValues(alpha: 0.1)
                                : AppColors.cardBackground,
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(
                              color: _selectedTarget == 'RED'
                                  ? AppColors.error
                                  : AppColors.border,
                              width: _selectedTarget == 'RED' ? 1.5 : 1,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.warning_rounded,
                                size: 18.r,
                                color: _selectedTarget == 'RED'
                                    ? AppColors.error
                                    : AppColors.textSecondary,
                              ),
                              wSpace(8),
                              Flexible(
                                child: Text(
                                  'points.targetRed'.tr(context: context),
                                  style: AppTextStyles.font12Bold.copyWith(
                                    color: _selectedTarget == 'RED'
                                        ? AppColors.error
                                        : AppColors.textPrimary,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    wSpace(12),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _selectedTarget = 'BLACK';
                            _quantity = blackBalance > 0 ? 1 : 0;
                          });
                        },
                        borderRadius: BorderRadius.circular(10.r),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 10.w),
                          decoration: BoxDecoration(
                            color: _selectedTarget == 'BLACK'
                                ? AppColors.textPrimary.withValues(alpha: 0.1)
                                : AppColors.cardBackground,
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(
                              color: _selectedTarget == 'BLACK'
                                  ? AppColors.textPrimary
                                  : AppColors.border,
                              width: _selectedTarget == 'BLACK' ? 1.5 : 1,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.block_rounded,
                                size: 18.r,
                                color: _selectedTarget == 'BLACK'
                                    ? AppColors.textPrimary
                                    : AppColors.textSecondary,
                              ),
                              wSpace(8),
                              Flexible(
                                child: Text(
                                  'points.targetBlack'.tr(context: context),
                                  style: AppTextStyles.font12Bold.copyWith(
                                    color: AppColors.textPrimary,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                hSpace(24),

                // Quantity Stepper
                Text(
                  'points.exchangeQuantity'.tr(context: context),
                  style: AppTextStyles.font14Bold,
                ),
                hSpace(10),
                Container(
                  padding: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    color: AppColors.cardBackground,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: _quantity > 1 && !isLoading
                            ? () {
                                setState(() {
                                  _quantity--;
                                });
                              }
                            : null,
                        icon: const Icon(Icons.remove_circle_outline_rounded),
                        iconSize: 32.r,
                        color: AppColors.brandPrimary,
                      ),
                      Text(
                        '$_quantity',
                        style: AppTextStyles.font24Bold,
                      ),
                      IconButton(
                        onPressed: _quantity < maxPossible && !isLoading
                            ? () {
                                setState(() {
                                  _quantity++;
                                });
                              }
                            : null,
                        icon: const Icon(Icons.add_circle_outline_rounded),
                        iconSize: 32.r,
                        color: AppColors.brandPrimary,
                      ),
                    ],
                  ),
                ),
                hSpace(24),

                // Cost Summary Card
                Container(
                  padding: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    color: AppColors.cardBackground,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'points.costInGreen'.tr(context: context),
                            style: AppTextStyles.font14Regular,
                          ),
                          Text(
                            '$totalGreenCost',
                            style: AppTextStyles.font18Bold.copyWith(
                              color: AppColors.success,
                            ),
                          ),
                        ],
                      ),
                      if (maxPossible == 0) ...[
                        hSpace(8),
                        Text(
                          'points.noPenaltiesToClear'.tr(context: context),
                          style: AppTextStyles.font12Regular.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ] else if (confirmedGreen < totalGreenCost) ...[
                        hSpace(8),
                        Text(
                          'points.insufficientGreen'.tr(context: context),
                          style: AppTextStyles.font12Regular.copyWith(
                            color: AppColors.error,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                hSpace(32),

                // Submit button
                SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: ElevatedButton(
                    onPressed: canExchange && !isLoading
                        ? () => _submitExchange(context)
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.brandPrimary,
                      foregroundColor: AppColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(color: AppColors.white)
                        : Text(
                            'points.confirmExchange'.tr(context: context),
                            style: AppTextStyles.font16Bold.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _submitExchange(BuildContext context) {
    final idempotencyKey = 'exch_${DateTime.now().millisecondsSinceEpoch}_${_selectedTarget}_$_quantity';
    context.read<ExchangeCubit>().exchange(
      target: _selectedTarget,
      quantity: _quantity,
      idempotencyKey: idempotencyKey,
    );
  }
}
