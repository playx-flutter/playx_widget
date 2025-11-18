# Changelog

### 0.4.0
- Add `MultiValueListenableBuilder` to rebuild a widget from multiple `ValueListenable`s.
- Add `BlurBox` widget for applying a blur effect to its child with animation.
- Add `CustomInkWell` widget for a standardized ink well effect.
- Add `StrokeText` widget to render text with an outline.
- Add `Box` and `SliverSizedBox` for creating spaced boxes with predefined sizes.
- Add `SpacingExtensions` on `num` for creating `SizedBox` and `SliverSizedBox` easily.
- Update `package_info_plus`, `flutter_svg`, `lottie`, and `font_awesome_flutter` dependencies.

### 0.3.0
- Update packages.
- (Flutter version support: v3.32.0)
  Adds all the flutter 3.32 additional properties for platform widgets

## 0.2.2

- Update packages.
- Update `ReadMoreText` to not be clickable when trimCharsCount is less than the text length.

## 0.2.1

- Update packages.

## 0.2.0

### New Features

#### OptimizedTextField

- **`enableSuggestions`**: Added to toggle text suggestions in the text field.
- **`autocorrect`**: Added to enable or disable autocorrection.
- **`autoValidateMode`**: Added to specify the auto-validation mode (e.g., on user input or form
  submission).
- **`debounceDuration`**: Added to support debouncing for text field input and validation.
- **`debounceValidation`**: Added to enable debouncing for validation, improving performance.

#### ImageViewer

- **`imageRenderMethodForWeb`**: Added to the `ImageViewer.cachedNetwork` method to specify
  rendering options for images on the web platform.

### Updates

- **Utility Methods**: Moved the following methods under the new `CommonImageUtils` class:
  - `getImageFromSvgAsset`
  - `getImageFromWidget`

- **WebAssembly (WASM) Support**: Added support for WebAssembly (WASM) in the package allowing the
  package to compile to `WASM` in web.

- **PlayxWidget**: Exported `OrientationWidget` for enhanced usability in responsive designs.

- **Dependency Replacement**: Replaced **flutter_keyboard_visibility** by *
  *flutter_keyboard_visibility_temp_fork** to address the following issues:
  - Use the Flutter default `compileSdkVersion` as a workaround for a bug in Flutter (#63533),
    allowing targeting of the latest `compileSdkVersion`.
  - Added support for Flutter/WASM. Previous implementations using `dart:html` or `package:js`
    prevented compilation for the WebAssembly (WASM) target.

- **Dependency Upgrade**: Upgraded `archive` dependency to version `^3.6.1`, which is used in the
  `lottie` package.

## 0.1.9

- Update packages.
- feat: Add date time picker utility class to show date/time picker based on platform.
- refactor: Update app version widget to allow showing version code.

## 0.1.8

- Update packages.
- export `cupertino_icons` and `font_awesome_flutter` icon packages.

## 0.1.7

- Update `ImageViewer.cachedNetwork` to accept `errorBuilder` parameter.

## 0.1.6

- Updated packages.
- Add new `IconInfo` class and new `ImageViewer.icon` method to create an image viewer with an icon.

## 0.1.5

- Updated packages.

#### 0.1.4

- Updated packages.
- fix breaking change with `getImageFromWidget` function.

## 0.1.3

- Update packages.
- Add new `flutter_keyboard_visibility`, `sliver_tools`, `dotted_border` and `wolt_modal_sheet`
  packages.
- Add new `SvgProvider` class to provide svg images.
- Rename `DashedVerticalLine` widget to `VerticalDashedLine`.
- Enhance `DashedLine` and `VerticalDashedLine` to work better in scrolling list.

## 0.1.2

- update packages

## 0.1.1

- update packages
- Update to flutter 3.16.0
- Bump minimum Dart version to 3.2.0
- Add `DashedVerticalLine` widget : Creates a dashed vertical line widget.
- Add `strokeWidth` to `CenterLoading` widget to customize the stroke width of the material loading
  indicator.

## 0.1.0-beta.5

- fix: bug causing `isCupertino` not working correctly on web.

## 0.1.0-beta.4

- Upgrade Packages.
- Add `AdaptiveLayout` : Widget which can be used to create adaptive layout for mobile and tablet
  devices.
- Add `OrientationWidget` : Widget that can be used to build different widgets for different
  orientations.
- Add onSubmitted callback to `OptimizedTextField` widget.

## 0.1.0-beta.3

### New Widgets

#### DashedLine

- Creates a dashed line widget.

#### FadeIndexedStack

- Creates an indexed Stack widget that paints a single child with fade animation.

#### FavoriteButton

- Creates a button that shows favorite state.

### Bug fixes and Enhancements

#### OptimizedCard

- Update OptimizedCard default shadowColor to not be transparent on Ios.
- Add the onPressed callback for the card to listen to any tapping events.
- Add borderRadius which can be used to set the border radius of the default card's rounded
  rectangular shape.

#### OptimizedTextField

- Add hintStyle to the text field to customize the hint text style.
- Enhancement to the text field in Ios when using `.adaptive` constructor.

## 0.1.0-beta.2

- Upgrade Packages.
- Add .adaptive constructor that creates a platform specific widget for centerLoading and
  optimizedTextField widgets.
- Enahncement to other widgets and remove OptimizedButton widget.

## 0.1.0-beta.1

- include `flutter_platform_widgets` into the package to include platform specific widgets.
- fix errorMaxLines on `OptimizedTextField` not working correctly.

## 0.0.8

- Upgrade Packages.
- Enhancements to `IconViewer` and `ImageViewer` widgets.

## 0.0.7

- Upgrade Packages.
- add `Marquee` widget :Marquee widget to make any widget scroll horizontally automatically.
- add `AnimSearchBar` widget :Widget that allows displaying a search bar with nice animation when
  expanded/ collapsed state.
- add `ReadMore` widget :Widget that allows Expanding and collapsing text based on it's characters
  count.
- add `scrollPadding` and `autoFillHints` to `OptimizedTextField` widget.

## 0.0.6

- Upgrade Packages.
- integrate `flutter_screenutil` package into the package to make widgets more responsive.
- Add new widget `OptimizedListTile` which is a widget that is enhanced version of list tile that
  can display a card with title, subtitle, leading and trailing widgets.
- update `OptimizedCard` to enhance card shadows.
- add `radius` to `CenterLoading` widget.

## 0.0.5

- Upgrade Packages.
- Add new widgets `AnimatedVisibility`, `OptimizedButton`, `OptimizedTextField`
  , `TimerRefreshWidget` .
- Add new Confirmation dialog that can be used to confirm any operation.
- update `OptimizedCard` to enhance card shadows.

## 0.0.4

- Upgrade Packages.

## 0.0.3

- Upgrade Packages.
- Update Exports to easy import widgets.
- Add common utilities like `getUnit8ListFromSvgAsset` which covert svg asset to Unit8List.

## 0.0.2

- Add support for Dart 3.0.0
- Upgrade Packages.
- Add `AutoAnimatedList` : Widget that automatically animates list of items when inserting or
  deleting any item.
- Add `OptimizedCard` : Widget which provides better shadow effect for the card to look more like
  native card.
- Add lottie package.

## 0.0.1
- initial release
