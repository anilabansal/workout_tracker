import 'dart:math';
import 'package:flutter/material.dart';
import '../../../model/work_out_model.dart';
import '../../../utils/common_colors.dart';

class BarChartPainter extends CustomPainter {
  final List<Workout> workouts;
  final double animationValue;

  BarChartPainter(this.workouts, this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    double barWidth = 40;
    double maxHeight = size.height - 50;
    double chartHeight = maxHeight - 20;
    double maxValue = 100.0;
    double barSpacing = 20;
    double axisOffset = 40;


    Paint axisPaint = Paint()..color = Colors.black..strokeWidth = 2;


    canvas.drawLine(Offset(axisOffset, 0), Offset(axisOffset, maxHeight), axisPaint);

    canvas.drawLine(Offset(axisOffset, maxHeight), Offset(size.width, maxHeight), axisPaint);

    ///Draw Y-axis labels and animate them
    for (int i = 0; i <= 10; i++) {
      double y = maxHeight - (i / 10) * chartHeight;
      TextPainter textPainter = TextPainter(
        text: TextSpan(
          text: (i * 10).toString(),
          style: TextStyle(color: Colors.black.withOpacity(animationValue), fontSize: 12 * animationValue),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(axisOffset - 30, y - 6));

      canvas.drawLine(Offset(axisOffset - 5, y), Offset(axisOffset, y), axisPaint);
    }


    for (int i = 0; i < workouts.length; i++) {

      double barHeight = (workouts[i].value / maxValue) * chartHeight * animationValue;
      double xOffset = axisOffset + i * (barWidth + barSpacing);
      double yOffset = maxHeight - barHeight;


      RRect barRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(xOffset, yOffset, barWidth, barHeight),
        const Radius.circular(10),
      );


      Paint gradientPaint = Paint()
        ..shader =  const LinearGradient(
          colors: [kPinkColor, kPinkAccentColor],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ).createShader(barRect.outerRect);


      Paint shadowPaint = Paint()
        ..color = Colors.black.withOpacity(0.3)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4.0);


      canvas.drawRRect(
        barRect.deflate(2),
        shadowPaint,
      );

      ///Draw the bar with gradient
      canvas.drawRRect(barRect, gradientPaint);

      ///Prepare the workout name text
      String workoutName = workouts[i].name;
      ///Limit the text length to avoid oWorkverflow
      if (workoutName.length > 10) {
        workoutName = '${workoutName.substring(0, 10)}...';
      }

      TextPainter textPainter = TextPainter(
        text: TextSpan(
          text: workoutName,
          style: TextStyle(color: Colors.black, fontSize: 10 * animationValue),
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );

      ///Layout the text with a maximum width to avoid wrapping
      textPainter.layout(maxWidth: barWidth);

      ///Adjust the Y position to place the text below the bar
      double textYPosition = maxHeight + 5;

      ///TODO:Center the text horizontally below the bar
      canvas.save();
      canvas.translate(xOffset + (barWidth - textPainter.width) / 2, textYPosition);
      textPainter.paint(canvas, const Offset(0, 0));
      canvas.restore();
    }


    TextPainter xAxisLabelPainter = TextPainter(
      text:  const TextSpan(
        text: '--------Workouts --------',
        style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    xAxisLabelPainter.layout();
    xAxisLabelPainter.paint(canvas, Offset(size.width / 10 - xAxisLabelPainter.width / 10, maxHeight +30));

    ///Draw Y-axis label
    canvas.save();
    canvas.translate(15, maxHeight / 2);
    canvas.rotate(-pi / 2);
    TextPainter yAxisLabelPainter = TextPainter(
      text:  TextSpan(
        text: '-------Workout Value (0-100)---------',
        style: TextStyle(color: Colors.black, fontSize: 20 * animationValue, fontWeight: FontWeight.bold),
      ),
      textDirection: TextDirection.ltr,
    );
    yAxisLabelPainter.layout();
    yAxisLabelPainter.paint(canvas, Offset(-yAxisLabelPainter.width / 2, -30 * animationValue));
    canvas.restore();
  }

  @override
  ///Repaint whenever the animation value changes
  bool shouldRepaint(covariant BarChartPainter oldDelegate) {

    return animationValue != oldDelegate.animationValue;
  }
}