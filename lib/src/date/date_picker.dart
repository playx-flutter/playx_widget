import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

enum DatePickerPlatform { material, cupertino, platform }

/// Utility class for picking date, time, or date and time.
class DateTimePicker {
  const DateTimePicker._();

  static Future<DateTime?> pickDate({
    required BuildContext context,
    DateTime? firstDate,
    DateTime? lastDate,
    DateTime? initialDate,
    bool use24hFormat = true,
    Color? cupertinoBackgroundColor,
    String? cancelLabel,
    String? confirmLabel,
    DatePickerPlatform platform = DatePickerPlatform.platform,
  }) async {
    switch (platform) {
      case DatePickerPlatform.material:
        return showDatePicker(
          context: context,
          initialDate: initialDate ?? DateTime.now(),
          firstDate: firstDate ?? DateTime(2010),
          lastDate: lastDate ?? DateTime.now(),
          cancelText: cancelLabel,
          confirmText: confirmLabel,
        );
      case DatePickerPlatform.cupertino:
        return showCupertinoModalPopup(
          context: context,
          builder: (context) {
            return Container(
              height: 300,
              color: cupertinoBackgroundColor,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: initialDate ?? DateTime.now(),
                minimumYear: initialDate?.year ?? 2010,
                maximumYear: (lastDate ?? DateTime.now()).year,
                onDateTimeChanged: (date) {},
              ),
            );
          },
        );
      case DatePickerPlatform.platform:
        return showPlatformDatePicker(
          context: context,
          initialDate: initialDate ?? DateTime.now(),
          firstDate: firstDate ?? DateTime(2010),
          lastDate: lastDate ?? DateTime.now(),
          material: (context, picker) {
            return MaterialDatePickerData(
              initialDatePickerMode: DatePickerMode.day,
              initialEntryMode: DatePickerEntryMode.calendar,
              confirmText: confirmLabel,
              cancelText: cancelLabel,
            );
          },
          cupertino: (context, picker) {
            return CupertinoDatePickerData(
              minimumYear: initialDate?.year,
              maximumYear: (lastDate ?? DateTime.now()).year,
              mode: CupertinoDatePickerMode.date,
              backgroundColor: cupertinoBackgroundColor,
              doneLabel: confirmLabel,
              cancelLabel: cancelLabel,
            );
          },
        );
    }
  }

  static Future<TimeOfDay?> pickTime({
    required BuildContext context,
    TimeOfDay? initialTime,
    bool use24hFormat = true,
    Color? cupertinoBackgroundColor,
    String? cancelLabel,
    String? confirmLabel,
    DatePickerPlatform platform = DatePickerPlatform.platform,
  }) async {
    if ((isCupertino(context) && platform == DatePickerPlatform.platform) ||
        platform == DatePickerPlatform.cupertino) {
      final time = await showPlatformDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2010),
        lastDate: DateTime.now(),
        material: (context, picker) {
          return MaterialDatePickerData(
            initialDatePickerMode: DatePickerMode.day,
            initialEntryMode: DatePickerEntryMode.calendar,
          );
        },
        cupertino: (context, picker) {
          return CupertinoDatePickerData(
            minimumYear: 2010,
            maximumYear: DateTime.now().year,
            mode: CupertinoDatePickerMode.time,
            use24hFormat: use24hFormat,
            backgroundColor: cupertinoBackgroundColor,
            doneLabel: confirmLabel,
            cancelLabel: cancelLabel,
          );
        },
      );
      return time != null ? TimeOfDay.fromDateTime(time) : null;
    } else {
      final time = await showTimePicker(
        context: context,
        initialTime: initialTime ?? TimeOfDay.now(),
        cancelText: cancelLabel,
        confirmText: confirmLabel,
      );
      return time;
    }
  }

  static Future<DateTime?> pickDateTime({
    required BuildContext context,
    DateTime? firstDate,
    DateTime? lastDate,
    DateTime? initialDate,
    bool use24hFormat = true,
    Color? cupertinoBackgroundColor,
    String? cancelLabel,
    String? confirmLabel,
    DatePickerPlatform platform = DatePickerPlatform.platform,
  }) async {
    DateTime? date;
    switch (platform) {
      case DatePickerPlatform.material:
        date = await showDatePicker(
          context: context,
          initialDate: initialDate ?? DateTime.now(),
          firstDate: firstDate ?? DateTime(2010),
          lastDate: lastDate ?? DateTime.now(),
          cancelText: cancelLabel,
          confirmText: confirmLabel,
        );
      case DatePickerPlatform.cupertino:
        return showCupertinoModalPopup(
          context: context,
          builder: (context) {
            return Container(
              height: 300,
              color: cupertinoBackgroundColor,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.dateAndTime,
                initialDateTime: initialDate ?? DateTime.now(),
                minimumYear: initialDate?.year ?? 2010,
                maximumYear: (lastDate ?? DateTime.now()).year,
                onDateTimeChanged: (date) {},
              ),
            );
          },
        );
      case DatePickerPlatform.platform:
        date = await showPlatformDatePicker(
          context: context,
          initialDate: initialDate ?? DateTime.now(),
          firstDate: firstDate ?? DateTime(2010),
          lastDate: lastDate ?? DateTime.now(),
          material: (context, picker) {
            return MaterialDatePickerData(
              initialDatePickerMode: DatePickerMode.day,
              initialEntryMode: DatePickerEntryMode.calendar,
              confirmText: confirmLabel,
              cancelText: cancelLabel,
            );
          },
          cupertino: (context, picker) {
            return CupertinoDatePickerData(
              minimumYear: initialDate?.year,
              maximumYear: (lastDate ?? DateTime.now()).year,
              mode: CupertinoDatePickerMode.dateAndTime,
              backgroundColor: cupertinoBackgroundColor,
              doneLabel: confirmLabel,
              cancelLabel: cancelLabel,
            );
          },
        );
    }

    if (context.mounted &&
        date != null &&
        (!isCupertino(context) || platform == DatePickerPlatform.material)) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(initialDate ?? DateTime.now()),
      );
      if (time != null) {
        date = date.copyWith(
          hour: time.hour,
          minute: time.minute,
        );
      }
    }

    return date;
  }
}
