import 'package:flutter/material.dart';
import 'package:check_point_v2/core/core.dart';
import '../widgets/disciplinary_violations_bloc_builder_widget.dart';

class EmployeeDeductionsScreen extends StatelessWidget {
  const EmployeeDeductionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(
        title: Text(
          'سجل الجزاءات والخصومات',
          style: AppTextStyles.font18Bold,
        ),
        centerTitle: true,
      ),
      body: const DisciplinaryViolationsBlocBuilderWidget(),
    );
  }
}
