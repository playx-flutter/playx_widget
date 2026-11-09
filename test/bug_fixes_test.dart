import 'package:flutter/cupertino.dart' show CupertinoDatePicker;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:playx_widget/playx_widget.dart';

Widget _app(Widget child) => MaterialApp(
  home: Scaffold(body: Center(child: child)),
);

void main() {
  group('ImageViewer / IconInfo', () {
    testWidgets('ImageViewer.icon renders the icon', (tester) async {
      await tester.pumpWidget(
        _app(ImageViewer.icon(IconInfo.icon(Icons.star, size: 24))),
      );
      expect(find.byIcon(Icons.star), findsOneWidget);
    });

    test('IconInfo.copyWith keeps assetIcon', () {
      final info = IconInfo.asset('a.png').copyWith(size: 10);
      expect(info.assetIcon, 'a.png');
      expect(info.size, 10);
    });

    testWidgets('ImageViewer.filePath builds on VM without throwing', (
      tester,
    ) async {
      await tester.pumpWidget(
        _app(
          ImageViewer.filePath(
            '/does/not/exist.png',
            errorBuilder: (_, _) => const Text('error'),
          ),
        ),
      );
      await tester.pump();
      expect(tester.takeException(), isNull);
    });
  });

  group('Dashed lines', () {
    testWidgets('still paint after a repaint without rebuild', (tester) async {
      await tester.pumpWidget(_app(const DashedLine(width: 100, height: 4)));
      expect(find.byType(DashedLine), paints..line());

      final render = tester.renderObject(
        find.descendant(
          of: find.byType(DashedLine),
          matching: find.byType(CustomPaint),
        ),
      );
      render.markNeedsPaint();
      await tester.pump();
      expect(find.byType(DashedLine), paints..line());
    });

    testWidgets('VerticalDashedLine in unbounded height does not hang', (
      tester,
    ) async {
      await tester.pumpWidget(
        _app(
          const SingleChildScrollView(child: VerticalDashedLine(height: 50)),
        ),
      );
      expect(tester.takeException(), isNull);
    });
  });

  testWidgets('AnimatedVisibility shows child while fading in', (tester) async {
    Widget build(bool visible) => _app(
      AnimatedVisibility(
        isVisible: visible,
        duration: const Duration(milliseconds: 200),
        child: const Text('child'),
      ),
    );
    await tester.pumpWidget(build(false));
    await tester.pumpAndSettle();
    expect(find.text('child'), findsNothing);

    await tester.pumpWidget(build(true));
    await tester.pump(const Duration(milliseconds: 50));
    expect(find.text('child'), findsOneWidget); // visible mid-animation
  });

  testWidgets('AutoAnimatedList handles duplicates and updates', (
    tester,
  ) async {
    Widget build(List<int> items) => _app(
      SizedBox(
        height: 400,
        child: AutoAnimatedList<int>(
          items: items,
          itemBuilder: (c, item, i) =>
              SizedBox(height: 20, child: Text('$item')),
        ),
      ),
    );
    await tester.pumpWidget(build([1, 1, 2]));
    expect(find.text('1'), findsNWidgets(2));
    await tester.pumpWidget(build([1, 1, 2, 3]));
    await tester.pumpAndSettle();
    expect(find.text('3'), findsOneWidget);
    await tester.pumpWidget(build([2]));
    await tester.pumpAndSettle();
    expect(find.text('1'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  group('showConfirmDialog', () {
    Future<void> open(
      WidgetTester tester,
      void Function(bool) onResult, {
      VoidCallback? onConfirmed,
      bool popInCallback = false,
    }) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => Scaffold(
              body: TextButton(
                onPressed: () async {
                  final r = await showConfirmDialog(
                    context: context,
                    title: 'T',
                    message: 'M',
                    onConfirmed: popInCallback
                        ? () => Navigator.of(context).pop()
                        : onConfirmed,
                  );
                  onResult(r);
                },
                child: const Text('open'),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.text('open'));
      await tester.pumpAndSettle();
    }

    testWidgets('confirm closes the dialog and returns true', (tester) async {
      bool? result;
      await open(tester, (r) => result = r);
      await tester.tap(find.text('Confirm'));
      await tester.pumpAndSettle();
      expect(result, isTrue);
      expect(find.text('Confirm'), findsNothing);
    });

    testWidgets('callback that pops itself does not double pop', (
      tester,
    ) async {
      bool? result;
      await open(tester, (r) => result = r, popInCallback: true);
      await tester.tap(find.text('Confirm'));
      await tester.pumpAndSettle();
      expect(result, isTrue);
      expect(find.text('open'), findsOneWidget); // home route still there
    });

    testWidgets('cancel returns false', (tester) async {
      bool? result;
      await open(tester, (r) => result = r);
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
      expect(result, isFalse);
    });
  });

  group('DateTimePicker', () {
    Future<void> open(
      WidgetTester tester,
      Future<Object?> Function(BuildContext) run,
      void Function(Object?) onResult,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => Scaffold(
              body: TextButton(
                onPressed: () async => onResult(await run(context)),
                child: const Text('open'),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.text('open'));
      await tester.pumpAndSettle();
    }

    testWidgets('cupertino pickDate returns the selected value', (
      tester,
    ) async {
      Object? result = 'unset';
      await open(
        tester,
        (c) => DateTimePicker.pickDate(
          context: c,
          initialDate: DateTime(2024, 5, 10),
          firstDate: DateTime(2020),
          lastDate: DateTime(2030),
          platform: DatePickerPlatform.cupertino,
        ),
        (r) => result = r,
      );
      expect(find.byType(CupertinoDatePicker), findsOneWidget);
      await tester.tap(find.text('Done'));
      await tester.pumpAndSettle();
      expect(result, isA<DateTime>());
      expect((result as DateTime).year, 2024);
    });

    testWidgets('cupertino cancel returns null', (tester) async {
      Object? result = 'unset';
      await open(
        tester,
        (c) => DateTimePicker.pickDate(
          context: c,
          platform: DatePickerPlatform.cupertino,
        ),
        (r) => result = r,
      );
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
      expect(result, isNull);
    });

    testWidgets('out-of-range initialDate is clamped, not asserted', (
      tester,
    ) async {
      await open(
        tester,
        (c) => DateTimePicker.pickDate(
          context: c,
          initialDate: DateTime(2100),
          platform: DatePickerPlatform.material,
        ),
        (_) {},
      );
      expect(tester.takeException(), isNull);
      expect(find.text('OK'), findsOneWidget);
    });

    testWidgets('pickDateRange returns start and end', (tester) async {
      Object? result;
      await open(
        tester,
        (c) => DateTimePicker.pickDateRange(
          context: c,
          firstDate: DateTime(2024, 1, 1),
          lastDate: DateTime(2024, 12, 31),
          platform: DatePickerPlatform.cupertino,
        ),
        (r) => result = r,
      );
      await tester.tap(find.text('Done'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Done'));
      await tester.pumpAndSettle();
      expect(result, isA<DateTimeRange>());
    });
  });
}
