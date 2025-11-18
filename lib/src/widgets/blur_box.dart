import 'dart:ui';

import 'package:flutter/material.dart';

class BlurBox extends StatefulWidget {
  final Widget child;
  final bool addBlur;
  final double sigmaX;
  final double sigmaY;
  final Color? backgroundColor;

  const BlurBox({
    required this.child,
    this.addBlur = false,
    this.sigmaX = 7.0,
    this.sigmaY = 7.0,
    this.backgroundColor,
    super.key,
  });

  @override
  State<BlurBox> createState() => _BlurBoxState();
}

class _BlurBoxState extends State<BlurBox> {
  bool _showBlur = false;

  @override
  void initState() {
    super.initState();
    if (widget.addBlur) {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          setState(() {
            _showBlur = true;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color background =
        widget.backgroundColor ??
        Theme.of(
          context,
        ).colorScheme.surfaceContainerHigh.withValues(alpha: 0.5);

    return Stack(
      children: [
        Positioned.fill(child: widget.child),
        if (_showBlur)
          Positioned.fill(
            child: ClipRect(
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
                builder: (context, value, child) {
                  final sigmaX = value * widget.sigmaX;
                  final sigmaY = value * widget.sigmaY;
                  final opacity = value;

                  return BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 300),
                      opacity: opacity,
                      child: DecoratedBox(
                        decoration: BoxDecoration(color: background),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
      ],
    );
  }
}
