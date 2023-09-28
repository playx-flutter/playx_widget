import 'package:flutter/widgets.dart';

/// Widget that animates the visibility of child widget by updating widget opacity and hide the old widget.
class AnimatedVisibility extends StatefulWidget {
  final bool isVisible;
  final Widget child;
  final Widget placeholder;
  final Duration duration;
  final double opacityBeforeBeingInvisible;

  const AnimatedVisibility({
    required this.isVisible,
    required this.child,
    this.placeholder = const SizedBox.shrink(),
    this.duration = const Duration(milliseconds: 250),
    this.opacityBeforeBeingInvisible = 0.0,
    super.key,
  });

  @override
  State<AnimatedVisibility> createState() => _AnimatedVisibilityState();
}

class _AnimatedVisibilityState extends State<AnimatedVisibility> {
  bool _visible = true;

  @override
  void initState() {
    _visible = widget.isVisible;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: widget.isVisible ? 1 : widget.opacityBeforeBeingInvisible,
      duration: widget.duration,
      onEnd: () {
        setState(() {
          _visible = widget.isVisible;
        });
      },
      child: Visibility(
        visible: _visible,
        replacement: widget.placeholder,
        child: widget.child,
      ),
    );
  }
}
