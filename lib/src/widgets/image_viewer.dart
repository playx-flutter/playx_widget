import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum _ImageType {
  assetImage,
  networkImage,
  memoryImage,
  fileImage,
  cachedNetworkImage,
  svgAssetImage,
  svgNetworkImage,
  svgMemoryImage,
}

/// Easily show an image from assets, network, cached network, or svg images.
// ignore: must_be_immutable
class ImageViewer extends StatefulWidget {
  _ImageType? _type;
  late String path;
  Uint8List? bytes;
  File? file;

  /// A builder function responsible for creating the widget that represents
  /// this image.
  ///
  /// If this is null, this widget will display an image that is painted as
  /// soon as the first image frame is available (and will appear to "pop" in
  /// if it becomes available asynchronously). Callers might use this builder to
  /// add effects to the image (such as fading the image in when it becomes
  /// available) or to display a placeholder widget while the image is loading.
  ///
  /// To have finer-grained control over the way that an image's loading
  /// progress is communicated to the user, see [loadingBuilder].
  ///
  /// ## Chaining with [loadingBuilder]
  ///
  /// If a [loadingBuilder] has _also_ been specified for an image, the two
  /// builders will be chained together: the _result_ of this builder will
  /// be passed as the `child` argument to the [loadingBuilder]. For example,
  /// consider the following builders used in conjunction:
  ///
  /// {@template flutter.widgets.Image.frameBuilder.chainedBuildersExample}
  /// ```dart
  /// Image(
  ///   image: _image,
  ///   frameBuilder: (BuildContext context, Widget child, int? frame, bool? wasSynchronouslyLoaded) {
  ///     return Padding(
  ///       padding: const EdgeInsets.all(8.0),
  ///       child: child,
  ///     );
  ///   },
  ///   loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
  ///     return Center(child: child);
  ///   },
  /// )
  /// ```
  ///
  /// In this example, the widget hierarchy will contain the following:
  ///
  /// ```dart
  /// Center(
  ///   child: Padding(
  ///     padding: const EdgeInsets.all(8.0),
  ///     child: image,
  ///   ),
  /// ),
  /// ```
  /// {@endtemplate}
  ///
  /// {@tool dartpad}
  /// The following sample demonstrates how to use this builder to implement an
  /// image that fades in once it's been loaded.
  ///
  /// This sample contains a limited subset of the functionality that the
  /// [FadeInImage] widget provides out of the box.
  ///
  /// ** See code in examples/api/lib/widgets/image/image.frame_builder.0.dart **
  /// {@end-tool}
  ImageFrameBuilder? frameBuilder;

  /// A builder that specifies the widget to display to the user while an image
  /// is still loading.
  ///
  /// If this is null, and the image is loaded incrementally (e.g. over a
  /// network), the user will receive no indication of the progress as the
  /// bytes of the image are loaded.
  ///
  /// For more information on how to interpret the arguments that are passed to
  /// this builder, see the documentation on [ImageLoadingBuilder].
  ///
  /// ## Performance implications
  ///
  /// If a [loadingBuilder] is specified for an image, the [Image] widget is
  /// likely to be rebuilt on every
  /// [rendering pipeline frame](rendering/RendererBinding/drawFrame.html) until
  /// the image has loaded. This is useful for cases such as displaying a loading
  /// progress indicator, but for simpler cases such as displaying a placeholder
  /// widget that doesn't depend on the loading progress (e.g. static "loading"
  /// text), [frameBuilder] will likely work and not incur as much cost.
  ///
  /// ## Chaining with [frameBuilder]
  ///
  /// If a [frameBuilder] has _also_ been specified for an image, the two
  /// builders will be chained together: the `child` argument to this
  /// builder will contain the _result_ of the [frameBuilder]. For example,
  /// consider the following builders used in conjunction:
  ///
  /// {@macro flutter.widgets.Image.frameBuilder.chainedBuildersExample}
  ///
  /// {@tool dartpad}
  /// The following sample uses [loadingBuilder] to show a
  /// [CircularProgressIndicator] while an image loads over the network.
  ///
  /// ** See code in examples/api/lib/widgets/image/image.loading_builder.0.dart **
  /// {@end-tool}
  ///
  /// Run against a real-world image on a slow network, the previous example
  /// renders the following loading progress indicator while the image loads
  /// before rendering the completed image.
  ///
  /// {@animation 400 400 https://flutter.github.io/assets-for-api-docs/assets/widgets/loading_progress_image.mp4}
  ImageLoadingBuilder? loadingBuilder;

  /// A builder function that is called if an error occurs during image loading.
  ///
  /// If this builder is not provided, any exceptions will be reported to
  /// [FlutterError.onError]. If it is provided, the caller should either handle
  /// the exception by providing a replacement widget, or rethrow the exception.
  ///
  /// {@tool dartpad}
  /// The following sample uses [errorBuilder] to show a '😢' in place of the
  /// image that fails to load, and prints the error to the console.
  ///
  /// ** See code in examples/api/lib/widgets/image/image.error_builder.0.dart **
  /// {@end-tool}
  ImageErrorWidgetBuilder? errorBuilder;

  /// If non-null, require the image to have this width.
  ///
  /// If null, the image will pick a size that best preserves its intrinsic
  /// aspect ratio.
  ///
  /// It is strongly recommended that either both the [width] and the [height]
  /// be specified, or that the widget be placed in a context that sets tight
  /// layout constraints, so that the image does not change size as it loads.
  /// Consider using [fit] to adapt the image's rendering to fit the given width
  /// and height if the exact image dimensions are not known in advance.
  double? width;

  /// If non-null, require the image to have this height.
  ///
  /// If null, the image will pick a size that best preserves its intrinsic
  /// aspect ratio.
  ///
  /// It is strongly recommended that either both the [width] and the [height]
  /// be specified, or that the widget be placed in a context that sets tight
  /// layout constraints, so that the image does not change size as it loads.
  /// Consider using [fit] to adapt the image's rendering to fit the given width
  /// and height if the exact image dimensions are not known in advance.
  double? height;

  /// If non-null, this color is blended with each image pixel using [colorBlendMode].
  Color? color;

  /// If non-null, the value from the [Animation] is multiplied with the opacity
  /// of each image pixel before painting onto the canvas.
  ///
  /// This is more efficient than using [FadeTransition] to change the opacity
  /// of an image, since this avoids creating a new composited layer. Composited
  /// layers may double memory usage as the image is painted onto an offscreen
  /// render target.
  ///
  /// See also:
  ///
  ///  * [AlwaysStoppedAnimation], which allows you to create an [Animation]
  ///    from a single opacity value.
  Animation<double>? opacity;

  /// The rendering quality of the image.
  ///
  /// {@template flutter.widgets.image.filterQuality}
  /// If the image is of a high quality and its pixels are perfectly aligned
  /// with the physical screen pixels, extra quality enhancement may not be
  /// necessary. If so, then [FilterQuality.none] would be the most efficient.
  ///
  /// If the pixels are not perfectly aligned with the screen pixels, or if the
  /// image itself is of a low quality, [FilterQuality.none] may produce
  /// undesirable artifacts. Consider using other [FilterQuality] values to
  /// improve the rendered image quality in this case. Pixels may be misaligned
  /// with the screen pixels as a result of transforms or scaling.
  ///
  /// See also:
  ///
  ///  * [FilterQuality], the enum containing all possible filter quality
  ///    options.
  /// {@endtemplate}
  FilterQuality filterQuality = FilterQuality.low;

  /// Used to combine [color] with this image.
  ///
  /// The default is [BlendMode.srcIn]. In terms of the blend mode, [color] is
  /// the source and this image is the destination.
  ///
  /// See also:
  ///
  ///  * [BlendMode], which includes an illustration of the effect of each blend mode.
  BlendMode? colorBlendMode;

  /// How to inscribe the image into the space allocated during layout.
  ///
  /// The default varies based on the other fields. See the discussion at
  /// [paintImage].
  BoxFit? fit;

  /// How to align the image within its bounds.
  ///
  /// The alignment aligns the given position in the image to the given position
  /// in the layout bounds. For example, an [Alignment] alignment of (-1.0,
  /// -1.0) aligns the image to the top-left corner of its layout bounds, while an
  /// [Alignment] alignment of (1.0, 1.0) aligns the bottom right of the
  /// image with the bottom right corner of its layout bounds. Similarly, an
  /// alignment of (0.0, 1.0) aligns the bottom middle of the image with the
  /// middle of the bottom edge of its layout bounds.
  ///
  /// To display a subpart of an image, consider using a [CustomPainter] and
  /// [Canvas.drawImageRect].
  ///
  /// If the [alignment] is [TextDirection]-dependent (i.e. if it is a
  /// [AlignmentDirectional]), then an ambient [Directionality] widget
  /// must be in scope.
  ///
  /// Defaults to [Alignment.center].
  ///
  /// See also:
  ///
  ///  * [Alignment], a class with convenient constants typically used to
  ///    specify an [AlignmentGeometry].
  ///  * [AlignmentDirectional], like [Alignment] for specifying alignments
  ///    relative to text direction.
  AlignmentGeometry alignment;

  /// How to paint any portions of the layout bounds not covered by the image.
  ImageRepeat repeat = ImageRepeat.noRepeat;

  /// The center slice for a nine-patch image.
  ///
  /// The region of the image inside the center slice will be stretched both
  /// horizontally and vertically to fit the image into its destination. The
  /// region of the image above and below the center slice will be stretched
  /// only horizontally and the region of the image to the left and right of
  /// the center slice will be stretched only vertically.
  Rect? centerSlice;

  /// Whether to paint the image in the direction of the [TextDirection].
  ///
  /// If this is true, then in [TextDirection.ltr] contexts, the image will be
  /// drawn with its origin in the top left (the "normal" painting direction for
  /// images); and in [TextDirection.rtl] contexts, the image will be drawn with
  /// a scaling factor of -1 in the horizontal direction so that the origin is
  /// in the top right.
  ///
  /// This is occasionally used with images in right-to-left environments, for
  /// images that were designed for left-to-right locales. Be careful, when
  /// using this, to not flip images with integral shadows, text, or other
  /// effects that will look incorrect when flipped.
  ///
  /// If this is true, there must be an ambient [Directionality] widget in
  /// scope.
  bool matchTextDirection = false;

  /// Whether to continue showing the old image (true), or briefly show nothing
  /// (false), when the image provider changes. The default value is false.
  ///
  /// ## Design discussion
  ///
  /// ### Why is the default value of [gaplessPlayback] false?
  ///
  /// Having the default value of [gaplessPlayback] be false helps prevent
  /// situations where stale or misleading information might be presented.
  /// Consider the following case:
  ///
  /// We have constructed a 'Person' widget that displays an avatar [Image] of
  /// the currently loaded person along with their name. We could request for a
  /// new person to be loaded into the widget at any time. Suppose we have a
  /// person currently loaded and the widget loads a new person. What happens
  /// if the [Image] fails to load?
  ///
  /// * Option A ([gaplessPlayback] = false): The new person's name is coupled
  /// with a blank image.
  ///
  /// * Option B ([gaplessPlayback] = true): The widget displays the avatar of
  /// the previous person and the name of the newly loaded person.
  ///
  /// This is why the default value is false. Most of the time, when you change
  /// the image provider you're not just changing the image, you're removing the
  /// old widget and adding a new one and not expecting them to have any
  /// relationship. With [gaplessPlayback] on you might accidentally break this
  /// expectation and re-use the old widget.
  bool gaplessPlayback = false;

  /// A Semantic description of the image.
  ///
  /// Used to provide a description of the image to TalkBack on Android, and
  /// VoiceOver on iOS.
  String? semanticLabel;

  /// Whether to exclude this image from semantics.
  ///
  /// Useful for images which do not contribute meaningful information to an
  /// application.
  bool excludeFromSemantics = false;

  /// ## Assets in packages
  ///
  /// To create the widget with an asset from a package, the [package] argument
  /// must be provided. For instance, suppose a package called `my_icons` has
  /// `icons/heart.png` .
  ///
  /// {@tool snippet}
  /// Then to display the image, use:
  ///
  /// ```dart
  /// Image.asset('icons/heart.png', package: 'my_icons')
  /// ```
  /// {@end-tool}
  ///
  /// Assets used by the package itself should also be displayed using the
  /// [package] argument as above.
  ///
  /// If the desired asset is specified in the `pubspec.yaml` of the package, it
  /// is bundled automatically with the app. In particular, assets used by the
  /// package itself must be specified in its `pubspec.yaml`.
  ///
  /// A package can also choose to have assets in its 'lib/' folder that are not
  /// specified in its `pubspec.yaml`. In this case for those images to be
  /// bundled, the app has to specify which ones to include. For instance a
  /// package named `fancy_backgrounds` could have:
  ///
  ///     lib/backgrounds/background1.png
  ///     lib/backgrounds/background2.png
  ///     lib/backgrounds/background3.png
  String? package;

  double scale = 1.0;

  /// If the `bundle` argument is omitted or null, then the
  /// [DefaultAssetBundle] will be used.
  AssetBundle? bundle;

  Map<String, String>? headers;

  /// If true, will allow the SVG to be drawn outside of the clip boundary of its
  /// viewBox.
  bool allowDrawingOutsideViewBox = false;

  /// The [Semantics.label] for this picture.
  ///
  /// The value indicates the purpose of the picture, and will be
  /// read out by screen readers.
  String? semanticsLabel;

  /// The content will be clipped (or not) according to this option.
  ///
  /// See the enum [Clip] for details of all possible options and their common
  /// use cases.
  ///
  /// Defaults to [Clip.hardEdge], and must not be null.
  Clip? clipBehavior;



  /// The placeholder to use while fetching, decoding, and parsing the SVG data.
  WidgetBuilder? placeholderBuilder;

  /// Whether to paint the image with anti-aliasing.
  ///
  /// Anti-aliasing alleviates the sawtooth artifact when the image is rotated.
  bool isAntiAlias = false;

  /// The target image's cache key.
  String? cacheKey;

  /// Optional builder to further customize the display of the image.
  ImageWidgetBuilder? imageBuilder;

  /// Widget displayed while the target [imageUrl] is loading.
  PlaceholderWidgetBuilder? placeholder;

  /// Widget displayed while the target [imageUrl] is loading.
  ProgressIndicatorBuilder? progressIndicatorBuilder;

  /// Widget displayed while the target [imageUrl] failed loading.
  LoadingErrorWidgetBuilder? errorWidget;

  /// The duration of the fade-in animation for the [placeholder].
  Duration? placeholderFadeInDuration;

  /// The duration of the fade-out animation for the [placeholder].
  Duration? fadeOutDuration;

  /// The curve of the fade-out animation for the [placeholder].
  Curve? fadeOutCurve;

  /// The duration of the fade-in animation for the [imageUrl].
  Duration? fadeInDuration;

  /// The curve of the fade-in animation for the [imageUrl].
  Curve? fadeInCurve;

  /// How to align the image within its bounds.
  ///
  /// The alignment aligns the given position in the image to the given position
  /// in the layout bounds. For example, a [Alignment] alignment of (-1.0,
  /// -1.0) aligns the image to the top-left corner of its layout bounds, while a
  /// [Alignment] alignment of (1.0, 1.0) aligns the bottom right of the
  /// image with the bottom right corner of its layout bounds. Similarly, an
  /// alignment of (0.0, 1.0) aligns the bottom middle of the image with the
  /// middle of the bottom edge of its layout bounds.
  ///
  /// If the [alignment] is [TextDirection]-dependent (i.e. if it is a
  /// [AlignmentDirectional]), then an ambient [Directionality] widget
  /// must be in scope.
  ///
  /// Defaults to [Alignment.center].
  ///
  /// See also:
  ///
  ///  * [Alignment], a class with convenient constants typically used to
  ///    specify an [AlignmentGeometry].
  ///  * [AlignmentDirectional], like [Alignment] for specifying alignments
  ///    relative to text direction.
  Alignment cachedAlignment = Alignment.center;

  /// When set to true it will animate from the old image to the new image
  /// if the url changes.
  bool useOldImageOnUrlChange = false;

  /// Will resize the image in memory to have a certain width using [ResizeImage]
  int? memCacheWidth;

  /// Will resize the image in memory to have a certain height using [ResizeImage]
  int? memCacheHeight;

  /// Will resize the image and store the resized image in the disk cache.
  int? maxWidthDiskCache;

  /// Will resize the image and store the resized image in the disk cache.
  int? maxHeightDiskCache;

  ImageViewer.asset(
    this.path, {
    super.key,
    this.bundle,
    this.frameBuilder,
    this.errorBuilder,
    this.semanticLabel,
    this.excludeFromSemantics = false,
    this.scale = 1.0,
    this.width,
    this.height,
    this.color,
    this.opacity,
    this.colorBlendMode,
    this.fit,
    this.alignment = Alignment.center,
    this.repeat = ImageRepeat.noRepeat,
    this.centerSlice,
    this.matchTextDirection = false,
    this.gaplessPlayback = false,
    this.isAntiAlias = false,
    this.package,
    this.filterQuality = FilterQuality.low,
    this.loadingBuilder,
  }) {
    _type = _ImageType.assetImage;
  }

  ImageViewer.network(
    String src, {
    super.key,
    this.scale = 1.0,
    this.frameBuilder,
    this.loadingBuilder,
    this.errorBuilder,
    this.semanticLabel,
    this.excludeFromSemantics = false,
    this.width,
    this.height,
    this.color,
    this.opacity,
    this.colorBlendMode,
    this.fit,
    this.alignment = Alignment.center,
    this.repeat = ImageRepeat.noRepeat,
    this.centerSlice,
    this.matchTextDirection = false,
    this.gaplessPlayback = false,
    this.filterQuality = FilterQuality.low,
    this.isAntiAlias = false,
    this.headers,
  }) {
    path = src;
    _type = _ImageType.networkImage;
  }

  ImageViewer.file(
    File this.file, {
    super.key,
    this.scale = 1.0,
    this.frameBuilder,
    this.errorBuilder,
    this.semanticLabel,
    this.excludeFromSemantics = false,
    this.width,
    this.height,
    this.color,
    this.opacity,
    this.colorBlendMode,
    this.fit,
    this.alignment = Alignment.center,
    this.repeat = ImageRepeat.noRepeat,
    this.centerSlice,
    this.matchTextDirection = false,
    this.gaplessPlayback = false,
    this.isAntiAlias = false,
    this.filterQuality = FilterQuality.low,
  }) {
    _type = _ImageType.fileImage;
  }

  ImageViewer.memory(
    Uint8List this.bytes, {
    super.key,
    this.scale = 1.0,
    this.frameBuilder,
    this.errorBuilder,
    this.semanticLabel,
    this.excludeFromSemantics = false,
    this.width,
    this.height,
    this.color,
    this.opacity,
    this.colorBlendMode,
    this.fit,
    this.alignment = Alignment.center,
    this.repeat = ImageRepeat.noRepeat,
    this.centerSlice,
    this.matchTextDirection = false,
    this.gaplessPlayback = false,
    this.isAntiAlias = false,
    this.filterQuality = FilterQuality.low,
  }) {
    _type = _ImageType.memoryImage;
  }

  ImageViewer.cachedNetwork(
    String src, {
    super.key,
    this.headers,
    this.imageBuilder,
    this.placeholder,
    this.progressIndicatorBuilder,
    this.errorWidget,
    this.fadeOutDuration = const Duration(milliseconds: 1000),
    this.fadeOutCurve = Curves.easeOut,
    this.fadeInDuration = const Duration(milliseconds: 500),
    this.fadeInCurve = Curves.easeIn,
    this.width,
    this.height,
    this.fit,
    this.alignment = Alignment.center,
    this.repeat = ImageRepeat.noRepeat,
    this.matchTextDirection = false,
    this.useOldImageOnUrlChange = false,
    this.color,
    this.filterQuality = FilterQuality.low,
    this.colorBlendMode,
    this.placeholderFadeInDuration,
    this.memCacheWidth,
    this.memCacheHeight,
    this.cacheKey,
    this.maxWidthDiskCache,
    this.maxHeightDiskCache,
  }) {
    path = src;
    _type = _ImageType.cachedNetworkImage;
  }

  ImageViewer.svgAsset(
    this.path, {
    super.key,
    this.width,
    this.height,
    this.matchTextDirection = false,
    this.bundle,
    this.package,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.excludeFromSemantics = false,
    this.allowDrawingOutsideViewBox = false,
    this.placeholderBuilder,
    this.semanticsLabel,
    this.clipBehavior = Clip.hardEdge,
  }) {
    _type = _ImageType.svgAssetImage;
  }

  ImageViewer.svgNetwork(
    this.path, {
    super.key,
    this.width,
    this.height,
    this.matchTextDirection = false,
    this.headers,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.excludeFromSemantics = false,
    this.allowDrawingOutsideViewBox = false,
    this.placeholderBuilder,
    this.semanticsLabel,
    this.clipBehavior = Clip.hardEdge,
  }) {
    _type = _ImageType.svgNetworkImage;
  }

  ImageViewer.svgMemory(
    Uint8List this.bytes, {
    super.key,
    this.width,
    this.height,
    this.matchTextDirection = false,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.excludeFromSemantics = false,
    this.allowDrawingOutsideViewBox = false,
    this.placeholderBuilder,
    this.semanticsLabel,
    this.clipBehavior = Clip.hardEdge,
  }) {
    _type = _ImageType.svgMemoryImage;
  }

  @override
  State<ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  @override
  Widget build(BuildContext context) {
    switch (widget._type) {
      case _ImageType.assetImage:
        return Image.asset(
          widget.path,
          bundle: widget.bundle,
          width: widget.width,
          height: widget.height,
          frameBuilder: widget.frameBuilder,
          errorBuilder: widget.errorBuilder,
          semanticLabel: widget.semanticLabel,
          excludeFromSemantics: widget.excludeFromSemantics,
          scale: widget.scale = 1.0,
          color: widget.color,
          opacity: widget.opacity,
          colorBlendMode: widget.colorBlendMode,
          fit: widget.fit,
          alignment: widget.alignment,
          repeat: widget.repeat,
          centerSlice: widget.centerSlice,
          matchTextDirection: widget.matchTextDirection,
          gaplessPlayback: widget.gaplessPlayback,
          isAntiAlias: widget.isAntiAlias,
          package: widget.package,
          filterQuality: widget.filterQuality,
        );
      case _ImageType.networkImage:
        return Image.network(
          widget.path,
          width: widget.width,
          height: widget.height,
          frameBuilder: widget.frameBuilder,
          errorBuilder: widget.errorBuilder,
          semanticLabel: widget.semanticLabel,
          excludeFromSemantics: widget.excludeFromSemantics,
          scale: widget.scale = 1.0,
          color: widget.color,
          opacity: widget.opacity,
          colorBlendMode: widget.colorBlendMode,
          fit: widget.fit,
          alignment: widget.alignment,
          repeat: widget.repeat,
          centerSlice: widget.centerSlice,
          matchTextDirection: widget.matchTextDirection,
          gaplessPlayback: widget.gaplessPlayback,
          isAntiAlias: widget.isAntiAlias,
          filterQuality: widget.filterQuality,
          headers: widget.headers,
        );
      case _ImageType.memoryImage:
        return Image.memory(
          widget.bytes!,
          width: widget.width,
          height: widget.height,
          frameBuilder: widget.frameBuilder,
          errorBuilder: widget.errorBuilder,
          semanticLabel: widget.semanticLabel,
          excludeFromSemantics: widget.excludeFromSemantics,
          scale: widget.scale = 1.0,
          color: widget.color,
          opacity: widget.opacity,
          colorBlendMode: widget.colorBlendMode,
          fit: widget.fit,
          alignment: widget.alignment,
          repeat: widget.repeat,
          centerSlice: widget.centerSlice,
          matchTextDirection: widget.matchTextDirection,
          gaplessPlayback: widget.gaplessPlayback,
          isAntiAlias: widget.isAntiAlias,
          filterQuality: widget.filterQuality,
        );
      case _ImageType.fileImage:
        return Image.file(
          widget.file!,
          width: widget.width,
          height: widget.height,
          frameBuilder: widget.frameBuilder,
          errorBuilder: widget.errorBuilder,
          semanticLabel: widget.semanticLabel,
          excludeFromSemantics: widget.excludeFromSemantics,
          scale: widget.scale = 1.0,
          color: widget.color,
          opacity: widget.opacity,
          colorBlendMode: widget.colorBlendMode,
          fit: widget.fit,
          alignment: widget.alignment,
          repeat: widget.repeat,
          centerSlice: widget.centerSlice,
          matchTextDirection: widget.matchTextDirection,
          gaplessPlayback: widget.gaplessPlayback,
          isAntiAlias: widget.isAntiAlias,
          filterQuality: widget.filterQuality,
        );
      case _ImageType.cachedNetworkImage:
        return CachedNetworkImage(
          imageUrl: widget.path,
          width: widget.width,
          height: widget.height,
          color: widget.color,
          colorBlendMode: widget.colorBlendMode,
          fit: widget.fit,
          repeat: widget.repeat,
          matchTextDirection: widget.matchTextDirection,
          filterQuality: widget.filterQuality = FilterQuality.low,
          httpHeaders: widget.headers,
          imageBuilder: widget.imageBuilder,
          placeholder: widget.placeholder,
          progressIndicatorBuilder: widget.progressIndicatorBuilder,
          errorWidget: widget.errorWidget,
          fadeOutDuration: widget.fadeOutDuration =
              const Duration(milliseconds: 1000),
          fadeOutCurve: widget.fadeOutCurve = Curves.easeOut,
          fadeInDuration: widget.fadeInDuration =
              const Duration(milliseconds: 500),
          fadeInCurve: widget.fadeInCurve = Curves.easeIn,
          alignment: widget.alignment = Alignment.center,
          useOldImageOnUrlChange: widget.useOldImageOnUrlChange = false,
          placeholderFadeInDuration: widget.placeholderFadeInDuration,
          memCacheWidth: widget.memCacheWidth,
          memCacheHeight: widget.memCacheHeight,
          cacheKey: widget.cacheKey,
          maxWidthDiskCache: widget.maxWidthDiskCache,
          maxHeightDiskCache: widget.maxHeightDiskCache,
        );
      case _ImageType.svgAssetImage:
        return SvgPicture.asset(
          widget.path,
          bundle: widget.bundle,
          width: widget.width,
          height: widget.height,
          excludeFromSemantics: widget.excludeFromSemantics,
          fit: widget.fit ?? BoxFit.contain,
          alignment: widget.alignment,
          matchTextDirection: widget.matchTextDirection,
          placeholderBuilder: widget.placeholderBuilder,
          colorFilter: widget.color != null
              ? ColorFilter.mode(widget.color!, BlendMode.srcIn)
              : null,
          allowDrawingOutsideViewBox: widget.allowDrawingOutsideViewBox,
          semanticsLabel: widget.semanticsLabel,
          clipBehavior: widget.clipBehavior ?? Clip.hardEdge,
        );
      case _ImageType.svgNetworkImage:
        return SvgPicture.network(
          widget.path,
          headers: widget.headers,
          width: widget.width,
          height: widget.height,
          excludeFromSemantics: widget.excludeFromSemantics,
          fit: widget.fit ?? BoxFit.contain,
          alignment: widget.alignment,
          matchTextDirection: widget.matchTextDirection,
          placeholderBuilder: widget.placeholderBuilder,
          colorFilter: widget.color != null
              ? ColorFilter.mode(widget.color!, BlendMode.srcIn)
              : null,
          allowDrawingOutsideViewBox: widget.allowDrawingOutsideViewBox,
          semanticsLabel: widget.semanticsLabel,
          clipBehavior: widget.clipBehavior ?? Clip.hardEdge,
        );
      case _ImageType.svgMemoryImage:
        return SvgPicture.memory(
          widget.bytes!,
          width: widget.width,
          height: widget.height,
          excludeFromSemantics: widget.excludeFromSemantics,
          fit: widget.fit ?? BoxFit.contain,
          alignment: widget.alignment,
          matchTextDirection: widget.matchTextDirection,
          placeholderBuilder: widget.placeholderBuilder,
          colorFilter: widget.color != null
              ? ColorFilter.mode(widget.color!, BlendMode.srcIn)
              : null,
          allowDrawingOutsideViewBox: widget.allowDrawingOutsideViewBox,
          semanticsLabel: widget.semanticsLabel,
          clipBehavior: widget.clipBehavior ?? Clip.hardEdge,
        );
      default:
        return Container();
    }
  }
}
