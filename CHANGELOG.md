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
