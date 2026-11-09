# Known issues and planned enhancements

Findings from a code review of every widget and utility in `lib/src/`. Items marked **verified** were
confirmed by reading the exact code path; the rest come from review notes and should be reproduced
before fixing. Nothing here has been fixed yet unless the [changelog](../CHANGELOG.md) says so.

Already fixed in 0.6.0: `AppVersion` ignoring `textAlign` and refetching `PackageInfo` on rebuild,
`FavoriteButton` not syncing with its parent, `ReadMoreText` splitting words and emoji.

## Bugs

### High

| Widget | Issue |
|---|---|
| `ImageViewer.network` | **Verified.** `loadingBuilder` always returns the placeholder (or an empty box), even when `event == null`, which means loading finished, so the loaded image is never shown. Return `child` when `event == null`. |
| `ImageViewer.icon`, `IconInfo.buildIconWidget` | **Verified.** The `.icon` constructor sets `_type = null`, but `build` switches on `_ImageType.icon`, so it falls into the default and renders an empty box. |
| `showConfirmDialog` | **Verified.** The confirm button calls `onConfirmed` but never closes the dialog, so the dialog stays open unless the callback pops it itself. Tapping outside returns `false`. It should `Navigator.pop(context, true)`. |
| `DateTimePicker.pickDate` / `pickDateTime` with `DatePickerPlatform.cupertino` | **Verified.** `onDateTimeChanged` is empty and the popup is never popped with a value, so the future always completes with `null`. |
| `DashedLine`, `VerticalDashedLine` | **Verified.** The painter mutates `startX` / `startY` while painting and never resets it. When Flutter repaints with the same painter (a repaint without a rebuild), nothing is drawn and the line vanishes. |
| `VerticalDashedLine` | In an unbounded-height parent (`Column`, `ListView`) without `height`, the painter gets an infinite height and the draw loop never ends, which freezes the UI. A zero `dashHeight + dashSpace` loops forever. |
| `AutoAnimatedList` | `updateCurrentList()` runs inside `build()` and calls `AnimatedListState.insertItem` / `removeItem`, which can trigger "setState called during build". Items are keyed by `hashCode`, so duplicate items collide. Reordering is not animated. |
| `OptimizedTextField` | `_debounceTimer` is never cancelled (no `dispose`), so after the field is removed the timer can still fire `onChanged` / `onValidationChanged`. |
| `AnimSearchBar` | The text controller and focus node are never disposed, and there is no `dispose` override. |

### Medium

| Widget | Issue |
|---|---|
| `AnimatedVisibility` | **Verified.** When `isVisible` flips to `true`, `_visible` stays `false` until the animation ends, so the placeholder shows during the fade-in and the child pops in at the end. Set `_visible = true` in `didUpdateWidget`. |
| `OptimizedTextField` | With `debounceDuration`, auto-validation and `debounceValidation` all set, the validation timer cancels the `onChanged` timer, so `onChanged` is never delivered while typing. Use two timers. |
| `OptimizedTextField` | `formKey` is computed once in `initState` and never re-synced; there is no `didUpdateWidget`. |
| `OptimizedTextField` | `focusedErrorBorder` reuses `errorBorder`. `eIcon` and `edit` are declared but never used. |
| `OptimizedTextField.cupertino` / `.adaptive` | The Cupertino path silently ignores `label`, `suffix`, `icon`, `fillColor`, label and border styling. A password-visibility `suffix` disappears on iOS. |
| `AnimSearchBar` | `closeSearchOnSuffixTap` never reverses the animation controller, so the rotation stays out of sync. `isOpened`, `width` and the duration are only read once (no `didUpdateWidget`). It forces LTR, hard-codes colors (white field, black text, so text is unreadable in dark mode), and has no tooltips or semantics. |
| `OptimizedCard` | In the non-custom-shadow path the `InkWell` wraps the `Card`, so the ripple is drawn behind the card color and is invisible. `clipBehavior` is hard-coded, and the splash and card radii (8 vs 10) differ. |
| `CustomInkWell` | It creates its own transparent `Material` above the child, so a child with a background color hides the ripple. There is no clipping, and the radius is not RTL-aware. |
| `Marquee` | When the content fits, it animates to `0` forever (wasted work). With zero durations it becomes a tight loop. The user can drag it, and changing durations later has no effect. |
| `BlurBox` | `addBlur` is only read in `initState`, so toggling it later does nothing, and the blur can never be removed. The 500 ms delay is hard-coded. `Positioned.fill` makes it size to its parent, so it fails in unbounded parents. |
| `StrokeText` | Single line only, with a fixed height of `fontSize * 1.5`. Width is infinite, so it throws in an unbounded `Row`. It ignores ambient text direction (RTL breaks) and the user's text scale, and has no semantics. |
| `FadeIndexedStack` | Fades only the incoming child (no cross-fade), runs a fade on first build, and ignores later `duration` changes. |
| `ImageViewer` (RTL) | Alignment is resolved with a fixed `TextDirection.ltr`. `flipX` for icons flips whenever the caller passes `rtl`, not based on the ambient direction. |
| `ImageViewer` (SVG) | SVG constructors force `errorBuilder = null`, so a bad SVG has no fallback. |
| `ImageViewer` (web) | It imports `dart:io` and takes a `File`; `Image.file` throws on web. |
| `IconViewer` | It forwards its own `key` to child widgets, which can trigger "Multiple widgets used the same GlobalKey". `iconColor` defaults to white (invisible on light backgrounds), and selected colors have no defaults. |
| `IconInfo` | `copyWith` drops `assetIcon`, so `IconInfo.asset(...).copyWith(color: x)` renders nothing. |
| `OptimizedListTile` | No `onTap`, and the title/subtitle column is centered (no `crossAxisAlignment.start`). Side spacers are added even when `leading` / `trailing` are null. |
| `SliverSizedBox` | The `h4` / `w4`-style statics are `static final`, so they are computed once with `.r` and go stale on rotation or after a later `ScreenUtil.init`. Width variants do nothing in a vertical `CustomScrollView`. |
| `CommonImageUtils` | `getImageFromSvgAsset` does not dispose the `PictureInfo` or the image. `getImageFromWidget` never unmounts its element tree and wraps content in a fixed LTR `Directionality` with no theme or `MediaQuery`. |
| `CommonImageUtils.isCupertino` | Uses `dart:io` `Platform`, ignoring `defaultTargetPlatform`, so tests and platform overrides do not work and web is always Material. `flutter_platform_widgets` uses its own check, so the two can disagree. |

### Low

- `DateTimePicker`:
  - Defaults `firstDate` to 2010 and `lastDate` to *now*, so future dates cannot be picked unless you pass `lastDate`. If `initialDate` is later than `lastDate`, Flutter asserts.
  - `use24hFormat` is ignored by the Material paths.
  - The Cupertino `minimumYear` is the initial date's year, so earlier years cannot be selected. `initialTime` is ignored on iOS.
- `showConfirmDialog`:
  - `lottie` is a required argument (pass `''` for none).
  - The default color is a hard-coded teal.
  - It is not actually adaptive.
  - The card stretches on tablets and web.
  - It uses the deprecated `primaryColor`.
- `MultiValueListenableBuilder`:
  - Listeners are re-subscribed whenever the parent passes a new list instance (common with list literals).
  - `values` is `List<dynamic>`.
  - A listenable that notifies during build causes a `setState` during build error.
- `AdaptiveWidget`, `OrientationWidget`: use `MediaQuery.of` (rebuilds on keyboard and padding changes) instead of `sizeOf` / `orientationOf`, and decide by screen size, not available width.
- `KeepAliveWrapper`: always keeps alive (no flag), and only works under a lazy list, `PageView` or `TabBarView`.
- `OptimizedScrollView`: no `physics`, `controller` or `padding`.
- Circular imports: `app_version.dart`, `confirmation_dialog.dart` and `icon_info.dart` import the package barrel `playx_widget.dart` instead of the specific file.
- Hard-coded colors and text styles in many widgets (`FavoriteButton` red, `IconViewer` white, `OptimizedTextField` red errors) do not follow the theme.

## Enhancements

1. **Tests.** Only four widget tests exist. Add tests for `AutoAnimatedList`, `OptimizedTextField` (debounce and dispose), `ImageViewer` (every type), `DateTimePicker` and the dashed lines. A CI workflow already runs them.
2. **Theming.** Replace hard-coded colors with `Theme.of(context).colorScheme` defaults, and add a `ThemeExtension` for shared styling.
3. **Accessibility.** Add `Semantics`, tooltips and `semanticLabel` (`AnimSearchBar`, `IconViewer`, `ImageViewer`, `FavoriteButton`, `ReadMoreText`), and respect `MediaQuery.disableAnimations`.
4. **RTL.** Remove the forced LTR in `AnimSearchBar`, `StrokeText`, `ImageViewer` and `CommonImageUtils`.
5. **API consistency.** Use `ValueChanged<T>` instead of raw `Function`, make `ImageViewer` and `OptimizedCard` stateless (their states hold nothing), and add `const` constructors where possible.
6. **`OptimizedTextField`.** Extract the duplicated change/validation/debounce logic, add `focusedErrorBorder`, `inputFormatters`, `textCapitalization`, `maxLength` and `onEditingComplete`.
7. **Web support.** Remove `dart:io` from `ImageViewer` and `CommonImageUtils`.
8. **Docs.** Add dartdoc comments (many use `//`), add screenshots, and add an example page per widget.
9. **Dependencies.** `wolt_modal_sheet` is held at 0.11.x and `cupertino_icons` is blocked by `flutter_platform_widgets`. `flutter_keyboard_visibility_temp_fork` is a temporary fork. Re-exporting fewer packages would make future major updates less breaking for consumers.

## Suggested fix order

1. `ImageViewer` network and icon bugs, `showConfirmDialog` closing, Cupertino date picker result.
2. Dashed-line painters, `AnimatedVisibility`, `AutoAnimatedList`.
3. Disposal and timer fixes in `OptimizedTextField` and `AnimSearchBar`.
4. Ripple issues (`OptimizedCard`, `CustomInkWell`), RTL, theming and accessibility.
