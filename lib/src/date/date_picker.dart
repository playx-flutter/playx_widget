import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

enum DatePickerPlatform { material, cupertino, platform }

/// Utility class for picking date, time, date and time, or a date range.
///
/// All methods follow [platform]: [DatePickerPlatform.platform] (default)
/// uses Cupertino pickers on iOS/macOS and Material pickers elsewhere.
///
/// Defaults: [firstDate] is 2010 and [lastDate] is the end of today, so future
/// dates can't be picked unless you pass a later [lastDate]. [initialDate] is
/// clamped into `[firstDate, lastDate]` so an out-of-range value never throws.
class DateTimePicker {
  const DateTimePicker._();

  /// End of today, so a picked end date (23:59:59) stays inside the range.
  static DateTime get endOfToday {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, 23, 59, 59, 999);
  }

  static bool _useCupertino(BuildContext context, DatePickerPlatform platform) {
    switch (platform) {
      case DatePickerPlatform.cupertino:
        return true;
      case DatePickerPlatform.material:
        return false;
      case DatePickerPlatform.platform:
        return isCupertino(context);
    }
  }

  static DateTime _clamp(DateTime value, DateTime min, DateTime max) {
    if (value.isBefore(min)) return min;
    if (value.isAfter(max)) return max;
    return value;
  }

  /// Picks a date. Returns `null` if dismissed.
  ///
  /// [label] is shown as the help text (Material) or title (Cupertino).
  static Future<DateTime?> pickDate({
    required BuildContext context,
    DateTime? firstDate,
    DateTime? lastDate,
    DateTime? initialDate,
    bool use24hFormat = true,
    Color? cupertinoBackgroundColor,
    String? cancelLabel,
    String? confirmLabel,
    String? label,
    DatePickerPlatform platform = DatePickerPlatform.platform,
  }) async {
    final first = firstDate ?? DateTime(2010);
    final last = lastDate ?? endOfToday;
    final initial = _clamp(initialDate ?? DateTime.now(), first, last);

    if (_useCupertino(context, platform)) {
      return _showCupertinoPicker(
        context: context,
        mode: CupertinoDatePickerMode.date,
        initial: initial,
        first: first,
        last: last,
        use24hFormat: use24hFormat,
        backgroundColor: cupertinoBackgroundColor,
        cancelLabel: cancelLabel,
        confirmLabel: confirmLabel,
        label: label,
      );
    }
    return showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: first,
      lastDate: last,
      helpText: label,
      cancelText: cancelLabel,
      confirmText: confirmLabel,
    );
  }

  /// Picks a time of day. Returns `null` if dismissed.
  ///
  /// [initialTime] is respected on every platform. If [firstDate]/[lastDate]
  /// are given with [initialDate], the picked time is clamped into that range.
  static Future<TimeOfDay?> pickTime({
    required BuildContext context,
    TimeOfDay? initialTime,
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
    bool use24hFormat = true,
    Color? cupertinoBackgroundColor,
    String? cancelLabel,
    String? confirmLabel,
    String? label,
    DatePickerPlatform platform = DatePickerPlatform.platform,
  }) async {
    final baseDate = initialDate ?? DateTime.now();
    final time0 = initialTime ?? TimeOfDay.fromDateTime(baseDate);
    final initial = DateTime(
      baseDate.year,
      baseDate.month,
      baseDate.day,
      time0.hour,
      time0.minute,
    );

    TimeOfDay? picked;
    if (_useCupertino(context, platform)) {
      final value = await _showCupertinoPicker(
        context: context,
        mode: CupertinoDatePickerMode.time,
        initial: initial,
        use24hFormat: use24hFormat,
        backgroundColor: cupertinoBackgroundColor,
        cancelLabel: cancelLabel,
        confirmLabel: confirmLabel,
        label: label,
      );
      picked = value == null ? null : TimeOfDay.fromDateTime(value);
    } else {
      picked = await showTimePicker(
        context: context,
        initialTime: time0,
        helpText: label,
        cancelText: cancelLabel,
        confirmText: confirmLabel,
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(alwaysUse24HourFormat: use24hFormat),
          child: child!,
        ),
      );
    }
    if (picked == null) return null;

    if (firstDate == null && lastDate == null) return picked;
    final candidate = DateTime(
      baseDate.year,
      baseDate.month,
      baseDate.day,
      picked.hour,
      picked.minute,
    );
    final clamped = _clamp(
      candidate,
      firstDate ?? DateTime(1900),
      lastDate ?? DateTime(2200),
    );
    return TimeOfDay.fromDateTime(clamped);
  }

  /// Picks a date and a time. Returns `null` if either step is dismissed.
  ///
  /// Cupertino shows a single date-and-time wheel; Material shows the date
  /// picker followed by the time picker.
  static Future<DateTime?> pickDateTime({
    required BuildContext context,
    DateTime? firstDate,
    DateTime? lastDate,
    DateTime? initialDate,
    bool use24hFormat = true,
    Color? cupertinoBackgroundColor,
    String? cancelLabel,
    String? confirmLabel,
    String? label,
    DatePickerPlatform platform = DatePickerPlatform.platform,
  }) async {
    final first = firstDate ?? DateTime(2010);
    final last = lastDate ?? endOfToday;
    final initial = _clamp(initialDate ?? DateTime.now(), first, last);

    if (_useCupertino(context, platform)) {
      return _showCupertinoPicker(
        context: context,
        mode: CupertinoDatePickerMode.dateAndTime,
        initial: initial,
        first: first,
        last: last,
        use24hFormat: use24hFormat,
        backgroundColor: cupertinoBackgroundColor,
        cancelLabel: cancelLabel,
        confirmLabel: confirmLabel,
        label: label,
      );
    }

    final date = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: first,
      lastDate: last,
      helpText: label,
      cancelText: cancelLabel,
      confirmText: confirmLabel,
    );
    if (date == null || !context.mounted) return null;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initial),
      helpText: label,
      cancelText: cancelLabel,
      confirmText: confirmLabel,
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(
          context,
        ).copyWith(alwaysUse24HourFormat: use24hFormat),
        child: child!,
      ),
    );
    if (time == null) return null;

    return _clamp(
      DateTime(date.year, date.month, date.day, time.hour, time.minute),
      first,
      last,
    );
  }

  /// Picks a date range from two sequential [pickDate] prompts so it matches
  /// the rest of [DateTimePicker] (platform-aware modals) instead of the
  /// Material-only full-screen `showDateRangePicker`.
  ///
  /// The end picker is clamped to `[start, lastDate]`, so the end can't be
  /// before the start. Returns `null` if either step is dismissed.
  static Future<DateTimeRange?> pickDateRange({
    required BuildContext context,
    required DateTime firstDate,
    required DateTime lastDate,
    DateTimeRange? initialDateRange,
    String? startLabel,
    String? endLabel,
    String? cancelLabel,
    String? confirmLabel,
    Color? cupertinoBackgroundColor,
    DatePickerPlatform platform = DatePickerPlatform.platform,
  }) async {
    final start = await pickDate(
      context: context,
      firstDate: firstDate,
      lastDate: lastDate,
      initialDate: initialDateRange?.start ?? firstDate,
      label: startLabel,
      cancelLabel: cancelLabel,
      confirmLabel: confirmLabel,
      cupertinoBackgroundColor: cupertinoBackgroundColor,
      platform: platform,
    );
    if (start == null || !context.mounted) return null;

    final previousEnd = initialDateRange?.end;
    final end = await pickDate(
      context: context,
      firstDate: start,
      lastDate: lastDate,
      initialDate: (previousEnd == null || previousEnd.isBefore(start))
          ? start
          : previousEnd,
      label: endLabel,
      cancelLabel: cancelLabel,
      confirmLabel: confirmLabel,
      cupertinoBackgroundColor: cupertinoBackgroundColor,
      platform: platform,
    );
    if (end == null) return null;

    return DateTimeRange(start: start, end: end);
  }

  /// Shows a Cupertino picker in a modal popup with Cancel / Done buttons and
  /// returns the selected value, or `null` if cancelled.
  static Future<DateTime?> _showCupertinoPicker({
    required BuildContext context,
    required CupertinoDatePickerMode mode,
    required DateTime initial,
    DateTime? first,
    DateTime? last,
    bool use24hFormat = true,
    Color? backgroundColor,
    String? cancelLabel,
    String? confirmLabel,
    String? label,
  }) {
    var selected = initial;
    final isTimeOnly = mode == CupertinoDatePickerMode.time;

    return showCupertinoModalPopup<DateTime>(
      context: context,
      builder: (popupContext) {
        final background =
            backgroundColor ??
            CupertinoColors.systemBackground.resolveFrom(popupContext);
        return Container(
          height: 320,
          color: background,
          child: SafeArea(
            top: false,
            child: Column(
              children: [
                SizedBox(
                  height: 44,
                  child: Row(
                    children: [
                      CupertinoButton(
                        onPressed: () => Navigator.of(popupContext).pop(),
                        child: Text(cancelLabel ?? 'Cancel'),
                      ),
                      Expanded(
                        child: Text(
                          label ?? '',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: DefaultTextStyle.of(
                            popupContext,
                          ).style.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                      CupertinoButton(
                        onPressed: () =>
                            Navigator.of(popupContext).pop(selected),
                        child: Text(confirmLabel ?? 'Done'),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: CupertinoDatePicker(
                    mode: mode,
                    initialDateTime: initial,
                    minimumDate: isTimeOnly ? null : first,
                    maximumDate: isTimeOnly ? null : last,
                    minimumYear: first?.year ?? 1,
                    maximumYear: last?.year,
                    use24hFormat: use24hFormat,
                    backgroundColor: background,
                    onDateTimeChanged: (value) => selected = value,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
