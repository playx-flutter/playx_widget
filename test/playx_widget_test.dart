import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:playx_widget/playx_widget.dart';

void main() {
  setUp(() {
    PackageInfo.setMockInitialValues(
      appName: 'app',
      packageName: 'io.test',
      version: '1.2.3',
      buildNumber: '42',
      buildSignature: '',
    );
  });

  group('AppVersionNotifier', () {
    test('loads once, caches and notifies', () async {
      final notifier = AppVersionNotifier();
      var calls = 0;
      notifier.addListener(() => calls++);

      expect(notifier.isLoaded, isFalse);
      final info = await notifier.load();
      await notifier.load();

      expect(info.version, '1.2.3');
      expect(info.buildNumber, '42');
      expect(calls, 1);
      expect(info.format(showVersionCode: true), 'V1.2.3+42');
    });
  });

  testWidgets('AppVersion shows version and respects textAlign', (
    tester,
  ) async {
    final notifier = AppVersionNotifier();
    await tester.pumpWidget(
      MaterialApp(
        home: AppVersion(
          notifier: notifier,
          showVersionCode: true,
          textAlign: TextAlign.start,
          // Avoids requiring ScreenUtil.init in the test.
          textStyle: const TextStyle(),
        ),
      ),
    );
    await tester.pumpAndSettle();
    final text = tester.widget<Text>(find.byType(Text));
    expect(text.data, 'V1.2.3+42');
    expect(text.textAlign, TextAlign.start);
  });

  testWidgets('FavoriteButton syncs with parent value', (tester) async {
    Widget build(bool fav) =>
        MaterialApp(home: FavoriteButton(isInFavorite: fav));
    await tester.pumpWidget(build(false));
    expect(find.byIcon(Icons.favorite_border), findsOneWidget);
    await tester.pumpWidget(build(true));
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.favorite), findsOneWidget);
  });

  testWidgets('ReadMoreText trims at word boundary and expands', (
    tester,
  ) async {
    const text = 'The quick brown fox jumps over the lazy dog again and again';
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ReadMoreText(
            text,
            trimCharsCount: 24,
            readMoreCollapsedText: 'more',
          ),
        ),
      ),
    );
    expect(find.textContaining('The quick brown fox... '), findsOneWidget);
    expect(find.textContaining('jumps'), findsNothing);
    await tester.tap(find.byType(ReadMoreText));
    await tester.pumpAndSettle();
    expect(find.textContaining('lazy dog'), findsOneWidget);
  });
}
