# Known issues and planned enhancements

Findings from a code review of every widget and utility in `lib/src/`. Items marked **verified** were
confirmed by reading the exact code path; the rest come from review notes and should be reproduced
before fixing. Nothing here has been fixed yet unless the [changelog](../CHANGELOG.md) says so.

## Fixed in 0.6.0

- `AppVersion` ignoring `textAlign` and refetching `PackageInfo` on rebuild; `FavoriteButton` not syncing with
  its parent; `ReadMoreText` splitting words and emoji.
- `ImageViewer.network` never showing the loaded image; `ImageViewer.icon` / `IconInfo.buildIconWidget`
  rendering nothing; `IconInfo` was not exported; `IconInfo.copyWith` dropping `assetIcon`.
- `ImageViewer` on web: `.file` now loads the picked path as a URL on web, new `ImageViewer.filePath`, network
  images fall back to an HTML element (CORS), SVG constructors accept `errorBuilder`, RTL alignment for
  `cachedNetwork`.
- `showConfirmDialog` now closes on confirm and returns `true` (a callback that pops itself is still safe);
  `onConfirmed` and `lottie` are optional; width is capped on large screens.
- `DateTimePicker`: Cupertino pickers now return the selected value (with Cancel/Done), `initialDate` is clamped
  into range, `initialTime` is respected on iOS, `use24hFormat` and `label` work everywhere, new `pickDateRange`
  and `endOfToday`.
- `DashedLine` / `VerticalDashedLine` vanishing on repaint and hanging in unbounded parents.
- `AnimatedVisibility` fade-in; `AutoAnimatedList` diffing during build and duplicate-item keys.
- `OptimizedTextField` timers (cancelled on dispose, separate change/validation timers, form key kept in sync).
- `AnimSearchBar` disposal, initial open state and close-on-suffix-tap animation.
- `OptimizedCard` ripple now visible; `Marquee` no longer spins when content fits and is not user-draggable.

## Remaining bugs

### High

| Widget | Issue |
|---|---|

### Medium

| Widget | Issue |
|---|---|
| `OptimizedTextField` | `focusedErrorBorder` reuses `errorBorder`. `eIcon` and `edit` are declared but never used. |
| `OptimizedTextField.cupertino` / `.adaptive` | The Cupertino path silently ignores `label`, `suffix`, `icon`, `fillColor`, label and border styling. A password-visibility `suffix` disappears on iOS. |
| `AnimSearchBar` | `closeSearchOnSuffixTap` never reverses the animation controller, so the rotation stays out of sync. `isOpened`, `width` and the duration are only read once (no `didUpdateWidget`). It forces LTR, hard-codes colors (white field, black text, so text is unreadable in dark mode), and has no tooltips or semantics. |
| `CustomInkWell` | It creates its own transparent `Material` above the child, so a child with a background color hides the ripple. There is no clipping, and the radius is not RTL-aware. |
| `BlurBox` | `addBlur` is only read in `initState`, so toggling it later does nothing, and the blur can never be removed. The 500 ms delay is hard-coded. `Positioned.fill` makes it size to its parent, so it fails in unbounded parents. |
| `StrokeText` | Single line only, with a fixed height of `fontSize * 1.5`. Width is infinite, so it throws in an unbounded `Row`. It ignores ambient text direction (RTL breaks) and the user's text scale, and has no semantics. |
| `FadeIndexedStack` | Fades only the incoming child (no cross-fade), runs a fade on first build, and ignores later `duration` changes. |
| `IconViewer` | It forwards its own `key` to child widgets, which can trigger "Multiple widgets used the same GlobalKey". `iconColor` defaults to white (invisible on light backgrounds), and selected colors have no defaults. |
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
