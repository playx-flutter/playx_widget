import 'package:flutter/material.dart';

///Creates a dashed vertical line widget.
class VerticalDashedLine extends StatefulWidget {
  //Width of the line
  final double? width;

  //Height of the line
  final double? height;

  //Width of the each dash line.
  final double dashHeight;

  //Space between each dash line.
  final double dashSpace;

  //Color of dash line.
  final Color color;

  //Stroke width for each dash line.
  final double strokeWidth;

  const VerticalDashedLine({
    super.key,
    this.width,
    this.height,
    this.dashHeight = 9,
    this.dashSpace = 5,
    this.strokeWidth = 1,
    this.color = Colors.grey,
  });

  @override
  State<VerticalDashedLine> createState() => _VerticalDashedLineState();
}

class _VerticalDashedLineState extends State<VerticalDashedLine> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: RepaintBoundary(
        child: CustomPaint(
          size: Size(widget.width ?? 2, widget.height ?? double.infinity),
          painter: DashedVerticalLinePainter(
            dashHeight: widget.dashHeight,
            dashSpace: widget.dashSpace,
            color: widget.color,
            strokeWidth: widget.strokeWidth,
          ),
        ),
      ),
    );
  }
}

class DashedVerticalLinePainter extends CustomPainter {
  final double dashHeight;
  final double dashSpace;
  final Color color;
  final double strokeWidth;
  double startY = 0;
  final Paint painter;

  DashedVerticalLinePainter({
    this.dashHeight = 8,
    this.dashSpace = 4,
    this.strokeWidth = 1,
    this.color = Colors.grey,
  }) : painter = Paint()
         ..color = color
         ..strokeWidth = strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth;
    while (startY < size.height) {
      canvas.drawLine(
        Offset(size.width / 2, startY),
        Offset(size.width / 2, startY + dashHeight),
        paint,
      );
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(DashedVerticalLinePainter oldDelegate) {
    final bool shouldRepaint =
        oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.dashHeight != dashHeight ||
        oldDelegate.dashSpace != dashSpace;
    return shouldRepaint;
  }
}
