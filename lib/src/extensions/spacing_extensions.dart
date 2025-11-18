import 'package:flutter/material.dart';
import 'package:playx_widget/src/widgets/sliver_sized_box.dart';

/// Extension on [num] to easily generate spacing widgets.
///
/// Usage:
/// - `20.sliverH` -> SliverSizedBox(height: 20)
/// - `10.sliverW` -> SliverSizedBox(width: 10)
/// - `20.sliverR` -> SliverSizedBox(height: 20, width: 20)
/// - `20.boxH`    -> SizedBox(height: 20)
/// - `10.boxW`    -> SizedBox(width: 10)
/// - `20.boxR`    -> SizedBox(height: 20, width: 20)
extension SpacingExtensions on num {
  // Sliver Spacing
  SliverSizedBox get sliverH => SliverSizedBox(height: toDouble());
  SliverSizedBox get sliverW => SliverSizedBox(width: toDouble());

  SliverSizedBox get sliverR =>
      SliverSizedBox(height: toDouble(), width: toDouble());

  // Normal Box Spacing
  SizedBox get boxH => SizedBox(height: toDouble());
  SizedBox get boxW => SizedBox(width: toDouble());
  SizedBox get boxR => SizedBox(height: toDouble(), width: toDouble());
}
