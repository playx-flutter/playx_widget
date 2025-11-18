import 'package:flutter/material.dart';

/// OrientationWidget : Widget that can be used to build different widgets for different orientations.
abstract class OrientationWidget extends StatelessWidget {
  const OrientationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape
        ? buildLandscape(context)
        : buildPortrait(context);
  }

  /// Builds the widget for portrait orientation.
  Widget buildPortrait(BuildContext context);

  /// Builds the widget for landscape orientation.
  Widget buildLandscape(BuildContext context);
}
