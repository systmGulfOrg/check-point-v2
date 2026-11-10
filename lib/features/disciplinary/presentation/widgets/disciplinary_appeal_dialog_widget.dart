import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class DisciplinaryAppealDialogWidget extends StatefulWidget {
  const DisciplinaryAppealDialogWidget({
    super.key,
    required this.violationDescription,
    required this.onSubmit,
  });

  final String violationDescription;
  final ValueChanged<String> onSubmit;

  @override
  State<DisciplinaryAppealDialogWidget> createState() =>
      _DisciplinaryAppealDialogWidgetState();
}

class _DisciplinaryAppealDialogWidgetState
    extends State<DisciplinaryAppealDialogWidget> {
  late final TextEditingController _reasonController;

  @override
  void initState() {
    super.initState();
    _reasonController = TextEditingController();
  }

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('تقديم تظلم إداري', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.violationDescription,
            style: TextStyle(fontSize: 12.sp, color: Colors.grey[700]),
          ),
          SizedBox(height: 12.h),
          TextField(
            controller: _reasonController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'اكتب سبب التظلم والاعتراض بالتفصيل...',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('إلغاء'),
        ),
        FilledButton(
          onPressed: () {
            final text = _reasonController.text.trim();
            if (text.isNotEmpty) {
              widget.onSubmit(text);
              Navigator.of(context).pop();
            }
          },
          child: const Text('إرسال التظلم'),
        ),
      ],
    );
  }
}
