import 'package:flutter/material.dart';
import '../widgets/disciplinary_violations_bloc_builder_widget.dart';

class EmployeeDeductionsScreen extends StatelessWidget {
  const EmployeeDeductionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('سجل الجزاءات والخصومات'),
        centerTitle: true,
      ),
      body: const DisciplinaryViolationsBlocBuilderWidget(),
    );
  }
}
