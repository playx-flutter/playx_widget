import 'package:flutter/material.dart';

///Creates a dashed line widget.
class DashedLine extends StatefulWidget {
  //Width of the line
  final double? width;

  //Height of the line
  final double? height;

  //Width of the each dash line.
  final double dashWidth;

  //Space between each dash line.
  final double dashSpace;

  //Color of dash line.
  final Color color;

  //Stroke width for each dash line.
  final double strokeWidth;

  const DashedLine({
    super.key,
    this.width,
    this.height,
    this.dashWidth = 9,
    this.dashSpace = 5,
    this.strokeWidth = 1,
    this.color = Colors.grey,
  });

  @override
  State<DashedLine> createState() => _DashedLineState();
}

class _DashedLineState extends State<DashedLine> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: CustomPaint(
        painter: DashedLinePainter(
          dashWidth: widget.dashWidth,
          dashSpace: widget.dashSpace,
          color: widget.color,
          strokeWidth: widget.strokeWidth,
        ),
      ),
    );
  }
}

class DashedLinePainter extends CustomPainter {
  final double dashWidth;
  final double dashSpace;
  final Color color;
  final double strokeWidth;
  double startX = 0;

  DashedLinePainter({
    this.dashWidth = 9,
    this.dashSpace = 5,
    this.strokeWidth = 1,
    this.color = Colors.grey,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(DashedLinePainter oldDelegate) {
    final bool shouldRepaint = oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.dashWidth != dashWidth ||
        oldDelegate.dashSpace != dashSpace;
    return shouldRepaint;
  }
}
