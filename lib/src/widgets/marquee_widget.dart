import 'package:flutter/cupertino.dart';

// Marquee widget to make any widget scroll horizontally automatically.
class Marquee extends StatefulWidget {
  final Widget child;
  final Axis direction;
  final Duration animationDuration;
  final Duration backDuration;
  final Duration pauseDuration;

  const Marquee({
    super.key,
    required this.child,
    this.direction = Axis.horizontal,
    this.animationDuration = const Duration(milliseconds: 3000),
    this.backDuration = const Duration(milliseconds: 3000),
    this.pauseDuration = const Duration(milliseconds: 1200),
  });

  @override
  State<Marquee> createState() => _MarqueeState();
}

class _MarqueeState extends State<Marquee> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback(scroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: widget.direction,
      physics: const NeverScrollableScrollPhysics(),
      controller: _scrollController,
      child: widget.child,
    );
  }

  /// Minimum wait between cycles so zero durations can't spin the event loop.
  static const _minDelay = Duration(milliseconds: 16);

  Future<void> scroll(_) async {
    while (mounted && _scrollController.hasClients) {
      await Future.delayed(
        widget.pauseDuration < _minDelay ? _minDelay : widget.pauseDuration,
      );
      if (!mounted || !_scrollController.hasClients) return;

      final max = _scrollController.position.maxScrollExtent;
      // Content fits: nothing to scroll, just wait and re-check later.
      if (max <= 0) continue;

      await _scrollController.animateTo(
        max,
        duration: widget.animationDuration,
        curve: Curves.linear,
      );
      if (!mounted || !_scrollController.hasClients) return;

      await Future.delayed(
        widget.pauseDuration < _minDelay ? _minDelay : widget.pauseDuration,
      );
      if (!mounted || !_scrollController.hasClients) return;

      await _scrollController.animateTo(
        0.0,
        duration: widget.backDuration,
        curve: Curves.linear,
      );
    }
  }
}
