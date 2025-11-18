import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

typedef MultiValueWidgetBuilder = Widget Function(
  BuildContext context,
  List<dynamic> values,
  Widget? child,
);

/// A widget that rebuilds whenever any of the provided [ValueListenable]s change.
class MultiValueListenableBuilder extends StatefulWidget {
  const MultiValueListenableBuilder({
    super.key,
    required this.valueListenables,
    required this.builder,
    this.child,
  });

  /// The [ValueListenables] whose values you depend on in order to build.
  final List<ValueListenable> valueListenables;

  /// A builder which provides the current values of the [valueListenables].
  final MultiValueWidgetBuilder builder;

  /// A child that does not depend on the values and is passed back unchanged.
  final Widget? child;

  @override
  State<MultiValueListenableBuilder> createState() =>
      _MultiValueListenableBuilderState();
}

class _MultiValueListenableBuilderState
    extends State<MultiValueListenableBuilder> {
  late List<dynamic> values;

  @override
  void initState() {
    super.initState();
    values = widget.valueListenables.map((v) => v.value).toList();
    for (final listenable in widget.valueListenables) {
      listenable.addListener(_onValueChanged);
    }
  }

  @override
  void didUpdateWidget(MultiValueListenableBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.valueListenables != widget.valueListenables) {
      for (final listenable in oldWidget.valueListenables) {
        listenable.removeListener(_onValueChanged);
      }
      values = widget.valueListenables.map((v) => v.value).toList();
      for (final listenable in widget.valueListenables) {
        listenable.addListener(_onValueChanged);
      }
    }
  }

  @override
  void dispose() {
    for (final listenable in widget.valueListenables) {
      listenable.removeListener(_onValueChanged);
    }
    super.dispose();
  }

  void _onValueChanged() {
    setState(() {
      values = widget.valueListenables.map((v) => v.value).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, values, widget.child);
  }
}
