import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/icon_info.dart';

/// Signature used by [Image.errorBuilder] to create a replacement widget to
/// render instead of the image.
typedef ErrorBuilder = Widget Function(
  BuildContext context,
  Object error,
);

/// Builder function to create a placeholder widget. The function is called
/// once while the ImageProvider is loading the image.
typedef PlaceholderBuilder = Widget Function(BuildContext context);

enum _ImageType {
  assetImage,
  networkImage,
  memoryImage,
  fileImage,
  cachedNetworkImage,
  svgAssetImage,
  svgNetworkImage,
  svgMemoryImage,
  icon,
}

/// Easily show an image from assets, network, cached network, or svg images.
// ignore: must_be_immutable
class ImageViewer extends StatefulWidget {
  final _ImageType? _type;
  final String? path;
  final Uint8List? bytes;
  final File? file;

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
  ///
  final double? width;

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
  final double? height;

  /// How to inscribe the image into the space allocated during layout.
  ///
  /// The default varies based on the other fields. See the discussion at
  /// [paintImage].
  final BoxFit? fit;

  /// If non-null, this color is blended with each image pixel using [colorBlendMode].
  final Color? color;

  /// Used to combine [color] with this image.
  ///
  /// The default is [BlendMode.srcIn]. In terms of the blend mode, [color] is
  /// the source and this image is the destination.
  ///
  /// See also:
  ///
  ///  * [BlendMode], which includes an illustration of the effect of each blend mode.
  final BlendMode? colorBlendMode;

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
  final AlignmentGeometry alignment;

  /// The content will be clipped (or not) according to this option.
  ///
  /// See the enum [Clip] for details of all possible options and their common
  /// use cases.
  ///
  /// Defaults to [Clip.hardEdge], and must not be null.
  final Clip? clipBehavior;

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
  final ErrorBuilder? errorBuilder;

  /// Widget displayed while the target is loading.
  final PlaceholderBuilder? placeholderBuilder;

  /// Icon info to be displayed.
  final IconInfo? iconInfo;

  final TextDirection? iconDirection;

  const ImageViewer.asset(
    String this.path, {
    super.key,
    this.errorBuilder,
    this.width,
    this.height,
    this.color,
    this.colorBlendMode,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
  })  : _type = _ImageType.assetImage,
        bytes = null,
        file = null,
        clipBehavior = null,
        iconInfo = null,
        iconDirection = null,
        placeholderBuilder = null;

  const ImageViewer.network(
    String src, {
    super.key,
    this.errorBuilder,
    this.placeholderBuilder,
    this.width,
    this.height,
    this.color,
    this.colorBlendMode,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
  })  : _type = _ImageType.networkImage,
        bytes = null,
        file = null,
        path = src,
        iconInfo = null,
        iconDirection = null,
        clipBehavior = null;

  const ImageViewer.file(
    File this.file, {
    super.key,
    this.errorBuilder,
    this.width,
    this.height,
    this.color,
    this.colorBlendMode,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
  })  : _type = _ImageType.fileImage,
        bytes = null,
        clipBehavior = null,
        path = null,
        iconInfo = null,
        iconDirection = null,
        placeholderBuilder = null;

  const ImageViewer.memory(
    Uint8List this.bytes, {
    super.key,
    this.errorBuilder,
    this.width,
    this.height,
    this.color,
    this.colorBlendMode,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
  })  : _type = _ImageType.memoryImage,
        file = null,
        clipBehavior = null,
        path = null,
        iconInfo = null,
        iconDirection = null,
        placeholderBuilder = null;

  const ImageViewer.cachedNetwork(
    String src, {
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
    this.color,
    this.colorBlendMode,
    this.errorBuilder,
    this.placeholderBuilder,
  })  : _type = _ImageType.cachedNetworkImage,
        bytes = null,
        file = null,
        clipBehavior = null,
        iconInfo = null,
        iconDirection = null,
        path = src;

  const ImageViewer.svgAsset(
    String this.path, {
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.placeholderBuilder,
    this.clipBehavior = Clip.hardEdge,
    this.color,
    this.colorBlendMode,
  })  : _type = _ImageType.svgAssetImage,
        bytes = null,
        file = null,
        iconInfo = null,
        iconDirection = null,
        errorBuilder = null;

  const ImageViewer.svgNetwork(
    String src, {
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.placeholderBuilder,
    this.clipBehavior = Clip.hardEdge,
    this.color,
    this.colorBlendMode,
  })  : _type = _ImageType.svgNetworkImage,
        bytes = null,
        file = null,
        path = src,
        iconInfo = null,
        iconDirection = null,
        errorBuilder = null;

  const ImageViewer.svgMemory(
    Uint8List this.bytes, {
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.placeholderBuilder,
    this.clipBehavior = Clip.hardEdge,
    this.color,
    this.colorBlendMode,
  })  : _type = _ImageType.svgMemoryImage,
        file = null,
        errorBuilder = null,
        iconInfo = null,
        iconDirection = null,
        path = null;

  const ImageViewer.icon(
    IconInfo this.iconInfo, {
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.color,
    this.iconDirection,
  })  : _type = null,
        bytes = null,
        file = null,
        path = null,
        colorBlendMode = null,
        placeholderBuilder = null,
        errorBuilder = null,
        clipBehavior = null;

  @override
  State<ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  @override
  Widget build(BuildContext context) {
    switch (widget._type) {
      case _ImageType.assetImage:
        return Image.asset(
          widget.path!,
          width: widget.width,
          height: widget.height,
          errorBuilder: (ctx, err, _) {
            return widget.errorBuilder?.call(ctx, err) ??
                const SizedBox.shrink();
          },
          color: widget.color,
          colorBlendMode: widget.colorBlendMode,
          fit: widget.fit,
          alignment: widget.alignment,
        );
      case _ImageType.networkImage:
        return Image.network(
          widget.path!,
          width: widget.width,
          height: widget.height,
          errorBuilder: (ctx, err, _) {
            return widget.errorBuilder?.call(ctx, err) ??
                const SizedBox.shrink();
          },
          loadingBuilder: (ctx, child, event) {
            return widget.placeholderBuilder?.call(
                  ctx,
                ) ??
                const SizedBox.shrink();
          },
          color: widget.color,
          colorBlendMode: widget.colorBlendMode,
          fit: widget.fit,
          alignment: widget.alignment,
        );
      case _ImageType.memoryImage:
        return Image.memory(
          widget.bytes!,
          width: widget.width,
          height: widget.height,
          errorBuilder: (ctx, err, _) {
            return widget.errorBuilder?.call(ctx, err) ??
                const SizedBox.shrink();
          },
          color: widget.color,
          colorBlendMode: widget.colorBlendMode,
          fit: widget.fit,
          alignment: widget.alignment,
        );
      case _ImageType.fileImage:
        return Image.file(
          widget.file!,
          width: widget.width,
          height: widget.height,
          color: widget.color,
          errorBuilder: (ctx, err, _) {
            return widget.errorBuilder?.call(ctx, err) ??
                const SizedBox.shrink();
          },
          colorBlendMode: widget.colorBlendMode,
          fit: widget.fit,
          alignment: widget.alignment,
        );
      case _ImageType.cachedNetworkImage:
        return CachedNetworkImage(
          imageUrl: widget.path!,
          width: widget.width,
          height: widget.height,
          color: widget.color,
          colorBlendMode: widget.colorBlendMode,
          fit: widget.fit,
          placeholder: (ctx, url) {
            return widget.placeholderBuilder?.call(ctx) ??
                const SizedBox.shrink();
          },
          errorWidget: (ctx, err, _) {
            return widget.errorBuilder?.call(ctx, err) ??
                const SizedBox.shrink();
          },
          alignment: widget.alignment.resolve(TextDirection.ltr),
        );
      case _ImageType.svgAssetImage:
        return SvgPicture.asset(
          widget.path!,
          width: widget.width,
          height: widget.height,
          fit: widget.fit ?? BoxFit.contain,
          alignment: widget.alignment,
          placeholderBuilder: widget.placeholderBuilder,
          colorFilter: widget.color != null
              ? ColorFilter.mode(
                  widget.color!, widget.colorBlendMode ?? BlendMode.srcIn)
              : null,
          clipBehavior: widget.clipBehavior ?? Clip.hardEdge,
        );
      case _ImageType.svgNetworkImage:
        return SvgPicture.network(
          widget.path!,
          width: widget.width,
          height: widget.height,
          fit: widget.fit ?? BoxFit.contain,
          alignment: widget.alignment,
          placeholderBuilder: widget.placeholderBuilder,
          colorFilter: widget.color != null
              ? ColorFilter.mode(
                  widget.color!, widget.colorBlendMode ?? BlendMode.srcIn)
              : null,
          clipBehavior: widget.clipBehavior ?? Clip.hardEdge,
        );
      case _ImageType.svgMemoryImage:
        return SvgPicture.memory(
          widget.bytes!,
          width: widget.width,
          height: widget.height,
          fit: widget.fit ?? BoxFit.contain,
          alignment: widget.alignment,
          placeholderBuilder: widget.placeholderBuilder,
          colorFilter: widget.color != null
              ? ColorFilter.mode(
                  widget.color!, widget.colorBlendMode ?? BlendMode.srcIn)
              : null,
          clipBehavior: widget.clipBehavior ?? Clip.hardEdge,
        );
      case _ImageType.icon:
        final color = widget.color ?? widget.iconInfo!.color;

        if (widget.iconInfo!.icon != null) {
          return Icon(
            widget.iconInfo!.icon,
            color: color,
            size: widget.iconInfo!.size ?? widget.width,
            textDirection: widget.iconDirection,
          );
        } else if (widget.iconInfo!.svgIcon != null) {
          return Transform.flip(
            flipX: widget.iconDirection == TextDirection.rtl,
            child: SvgPicture.asset(
              widget.iconInfo!.svgIcon!,
              colorFilter: color != null
                  ? ColorFilter.mode(
                      color, widget.colorBlendMode ?? BlendMode.srcIn)
                  : null,
              width: widget.iconInfo!.size ?? widget.width,
              height: widget.iconInfo!.size ?? widget.height,
            ),
          );
        } else if (widget.iconInfo!.assetIcon != null) {
          return Transform.flip(
            flipX: widget.iconDirection == TextDirection.rtl,
            child: Image.asset(
              widget.iconInfo!.assetIcon!,
              color: color,
              width: widget.iconInfo!.size ?? widget.width,
              height: widget.iconInfo!.size ?? widget.height,
              fit: widget.fit ?? BoxFit.contain,
            ),
          );
        } else if (widget.iconInfo!.url != null) {
          return Transform.flip(
            flipX: widget.iconDirection == TextDirection.rtl,
            child: CachedNetworkImage(
              imageUrl: widget.iconInfo!.url!,
              color: color,
              width: widget.iconInfo!.size ?? widget.width,
              height: widget.iconInfo!.size ?? widget.height,
              fit: widget.fit ?? BoxFit.contain,
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      default:
        return const SizedBox.shrink();
    }
  }
}
