import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A wrapper around [SizedBox] to provide static getters for standard spacing.
/// Use this in Rows, Columns, or standard layouts.
class Box extends SizedBox {
  const Box({super.key, super.height, super.width, super.child});

  // --- Static Getters for Vertical Spacing (Height) ---
  static Box h4 = Box(height: 4.r);
  static Box h8 = Box(height: 8.r);
  static Box h12 = Box(height: 12.r);
  static Box h16 = Box(height: 16.r);
  static Box h32 = Box(height: 32.r);
  static Box h64 = Box(height: 64.r);

  // --- Static Getters for Horizontal Spacing (Width) ---
  static Box w4 = Box(width: 4.r);
  static Box w8 = Box(width: 8.r);
  static Box w12 = Box(width: 12.r);
  static Box w16 = Box(width: 16.r);
  static Box w32 = Box(width: 32.r);
  static Box w64 = Box(width: 64.r);
}
