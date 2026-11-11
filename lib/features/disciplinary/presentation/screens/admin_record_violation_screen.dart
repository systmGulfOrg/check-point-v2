import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import '../../data/models/disciplinary_models.dart';
import '../cubit/disciplinary_cubit.dart';

class AdminRecordViolationScreen extends StatefulWidget {
  const AdminRecordViolationScreen({super.key});

  @override
  State<AdminRecordViolationScreen> createState() =>
      _AdminRecordViolationScreenState();
}

class _AdminRecordViolationScreenState
    extends State<AdminRecordViolationScreen> {
  late final TextEditingController _employeeIdController;
  late final TextEditingController _notesController;

  List<DisciplinaryRuleModel> _rules = [];
  DisciplinaryRuleModel? _selectedRule;
  DisciplinaryPreviewModel? _preview;
  bool _isLoadingRules = true;
  bool _isCalculating = false;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _employeeIdController = TextEditingController();
    _notesController = TextEditingController();
    _loadRules();
  }

  @override
  void dispose() {
    _employeeIdController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _loadRules() async {
    final rules = await context.read<DisciplinaryCubit>().getRulesMatrix();
    if (mounted) {
      setState(() {
        _rules = rules;
        _isLoadingRules = false;
      });
    }
  }

  Future<void> _triggerPreview() async {
    final empId = _employeeIdController.text.trim();
    if (empId.isEmpty || _selectedRule == null) return;

    setState(() => _isCalculating = true);
    final preview = await context.read<DisciplinaryCubit>().previewViolation(
          employeeId: empId,
          ruleId: _selectedRule!.id,
        );
    if (mounted) {
      setState(() {
        _preview = preview;
        _isCalculating = false;
      });
    }
  }

  Future<void> _submitViolation() async {
    final empId = _employeeIdController.text.trim();
    if (empId.isEmpty || _selectedRule == null) return;

    setState(() => _isSubmitting = true);
    final success = await context.read<DisciplinaryCubit>().recordViolation(
          employeeId: empId,
          ruleId: _selectedRule!.id,
          notes: _notesController.text.trim().isEmpty
              ? null
              : _notesController.text.trim(),
        );

    if (mounted) {
      setState(() => _isSubmitting = false);
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تم تسجيل واعتماد المخالفة بنجاح')),
        );
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تسجيل مخالفة إدارية'),
        centerTitle: true,
      ),
      body: _isLoadingRules
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'معرف الموظف (Employee ID / UUID)',
                    style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 6.h),
                  TextField(
                    controller: _employeeIdController,
                    decoration: InputDecoration(
                      hintText: 'أدخل معرف الموظف...',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
                    ),
                    onSubmitted: (_) => _triggerPreview(),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'بند المخالفة (لائحة SYSTM)',
                    style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 6.h),
                  DropdownButtonFormField<DisciplinaryRuleModel>(
                    initialValue: _selectedRule,
                    isExpanded: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
                    ),
                    items: _rules.map((rule) {
                      return DropdownMenuItem(
                        value: rule,
                        child: Text(
                          '${rule.code}: ${rule.descriptionAr}',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 12.sp),
                        ),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() => _selectedRule = val);
                      _triggerPreview();
                    },
                  ),
                  SizedBox(height: 16.h),
                  if (_isCalculating)
                    const Center(child: CircularProgressIndicator())
                  else if (_preview != null) ...[
                    Container(
                      padding: EdgeInsets.all(14.w),
                      decoration: BoxDecoration(
                        color: Colors.amber.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: Colors.amber.withValues(alpha: 0.3)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'تدرج العقوبة لشهر الدوام الحالي:',
                                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'المرة ${_preview!.occurrenceIndex}',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.amber[900],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            'الجزاء المستحق: ${_preview!.labelAr} (${_preview!.calculatedAmount} ر.س)',
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.red[800],
                            ),
                          ),
                          if (_preview!.requiresAdminReview) ...[
                            SizedBox(height: 6.h),
                            Text(
                              '⚠️ يستلزم هذا البند مراجعة إدارية وتحقيقاً رسمياً.',
                              style: TextStyle(fontSize: 11.sp, color: Colors.red[900]),
                            ),
                          ],
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),
                  ],
                  Text(
                    'ملاحظات إضافية',
                    style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 6.h),
                  TextField(
                    controller: _notesController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: 'أدخل أي تفاصيل أو أسباب...',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  SizedBox(
                    width: double.infinity,
                    height: 48.h,
                    child: FilledButton(
                      onPressed: _isSubmitting ? null : _submitViolation,
                      child: _isSubmitting
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text('تسجيل واعتماد الجزاء'),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
