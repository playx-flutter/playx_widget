
# PlayX Widget
PlayX widget package for playx eco system that provide custom utility widgets to make development faster.

## Features
-  Common widgets that are needed in each project.
-  Exports :  packages like [`package_info_plus`](https://pub.dev/packages/package_info_plus) , 
[`flutter_svg`](https://pub.dev/packages/flutter_svg) , [`Lottie`](https://pub.dev/packages/lottie) 
and [`cached_network_image`](https://pub.dev/packages/cached_network_image).

## Widgets
- `AppVersion` : Widget to display current App Version.
- `CenterLoading` : Widget that displays a simple circle loading indicator like in ios.
- `OptimizedScrollView` : This is an optimized scroll view widget that make it's child scrollable.  
         It will automatically size itself to fill the space between the bottom of the last widget and the bottom of the viewport.
- `ImageViewer` : Easily show an image from assets, network, cached network, or svg images.
- `KeepAliveWrapper`: Wrapper for widgets to keep them alive and not destroy them.
- `IconViewer`: Widget that shows an icon from icon data, svg, image or text.
-  `AutoAnimatedList` : Widget that automatically animates list of items when inserting or deleting any item.
-  `OptimizedCard` : Widget which provides better shadow effect for the card to look more like native card.

## Playx:
Consider using our [Playx Package](https://pub.dev/packages/playx):
Which comes prepackaged with this package and more features and is easy to use.


## Installation

in `pubspec.yaml` add these lines to `dependencies`

```yaml  
playx_widget: ^0.0.2
```  

## See Also:
[Playx](https://pub.dev/packages/playx) : Playx eco system helps with redundant features , less code , more productivity , better organizing.

[Playx_theme](https://pub.dev/packages/playx_theme) :Multi theme features for flutter apps from playx eco system.

[Playx_core](https://pub.dev/packages/playx_core) :Core package for playx eco system contains shared classes and utilities.
