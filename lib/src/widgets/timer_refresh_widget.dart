import 'dart:async';

import 'package:flutter/material.dart';

///Widget that refreshes it's child on periodic time.
class TimerRefreshWidget extends StatefulWidget {
  final Widget Function(int time) builder;
  final Duration duration;

  const TimerRefreshWidget(
      {super.key,
      required this.builder,
      this.duration = const Duration(minutes: 1)});

  @override
  State<TimerRefreshWidget> createState() => _TimerRefreshWidgetState();
}

class _TimerRefreshWidgetState extends State<TimerRefreshWidget> {
  Timer? _timer;
  int _tick = 0;

  @override
  void initState() {
    super.initState();
    subscribeToTimer(widget.duration);
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(_tick);
  }

  @override
  void didUpdateWidget(TimerRefreshWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.duration != widget.duration) {
      subscribeToTimer(widget.duration);
    }
  }

  void refreshWidget(int tick) {
    setState(() {
      _tick = tick;
    });
  }

  void subscribeToTimer(Duration refreshRate) {
    _timer?.cancel();
    _timer = Timer.periodic(refreshRate, (Timer t) {
      refreshWidget(t.tick);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timer = null;
    super.dispose();
  }
}
