import 'package:flutter/material.dart';

import 'package:check_point_v2/core/core.dart';

class AdminWeeklyAttendanceChartPainter extends CustomPainter {
  const AdminWeeklyAttendanceChartPainter({
    required this.weeklyData,
    required this.maxValue,
  });

  final List<({int present, int late, int absent})> weeklyData;
  final int maxValue;

  @override
  void paint(Canvas canvas, Size size) {
    final chartLeft = 38.0;
    final chartTop = 4.0;
    final chartRight = size.width - 4.0;
    final chartBottom = size.height - 26.0;
    final chartWidth = chartRight - chartLeft;
    final chartHeight = chartBottom - chartTop;

    final gridPaint = Paint()
      ..color = AppColors.border.withValues(alpha: 0.55)
      ..strokeWidth = 1;
    final linePaint = Paint()
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    for (var index = 0; index < 5; index++) {
      final y = chartTop + (chartHeight / 4) * index;
      canvas.drawLine(Offset(chartLeft, y), Offset(chartRight, y), gridPaint);
    }

    _drawSeries(
      canvas,
      values: [for (final day in weeklyData) day.present],
      color: AppColors.success,
      chartLeft: chartLeft,
      chartBottom: chartBottom,
      chartWidth: chartWidth,
      chartHeight: chartHeight,
      linePaint: linePaint,
    );
    _drawSeries(
      canvas,
      values: [for (final day in weeklyData) day.late],
      color: AppColors.warningOrange,
      chartLeft: chartLeft,
      chartBottom: chartBottom,
      chartWidth: chartWidth,
      chartHeight: chartHeight,
      linePaint: linePaint,
    );
    _drawSeries(
      canvas,
      values: [for (final day in weeklyData) day.absent],
      color: AppColors.error,
      chartLeft: chartLeft,
      chartBottom: chartBottom,
      chartWidth: chartWidth,
      chartHeight: chartHeight,
      linePaint: linePaint,
    );
  }

  void _drawSeries(
    Canvas canvas, {
    required List<int> values,
    required Color color,
    required double chartLeft,
    required double chartBottom,
    required double chartWidth,
    required double chartHeight,
    required Paint linePaint,
  }) {
    if (values.isEmpty) return;

    final points = <Offset>[
      for (var index = 0; index < values.length; index++)
        Offset(
          chartLeft + (chartWidth / (values.length - 1)) * index,
          chartBottom - chartHeight * (values[index] / maxValue),
        ),
    ];
    final path = Path()..moveTo(points.first.dx, points.first.dy);
    for (var index = 0; index < points.length - 1; index++) {
      final p0 = points[index == 0 ? index : index - 1];
      final p1 = points[index];
      final p2 = points[index + 1];
      final p3 = points[index + 2 < points.length ? index + 2 : index + 1];

      final control1 = Offset(
        p1.dx + (p2.dx - p0.dx) / 6,
        p1.dy + (p2.dy - p0.dy) / 6,
      );
      final control2 = Offset(
        p2.dx - (p3.dx - p1.dx) / 6,
        p2.dy - (p3.dy - p1.dy) / 6,
      );
      path.cubicTo(
        control1.dx,
        control1.dy,
        control2.dx,
        control2.dy,
        p2.dx,
        p2.dy,
      );
    }
    linePaint.color = color;
    canvas.drawPath(path, linePaint);
    final dotPaint = Paint()..color = color;
    for (final point in points) {
      canvas.drawCircle(point, 3.5, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant AdminWeeklyAttendanceChartPainter oldDelegate) =>
      oldDelegate.weeklyData != weeklyData || oldDelegate.maxValue != maxValue;
}
