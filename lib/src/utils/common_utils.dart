import 'dart:io' show Platform;
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommonImageUtils {
  static Future<Uint8List> getImageFromSvgAsset(
    String assetName, {
    Size size = const Size(48, 48),
    BuildContext? context,
    ColorMapper? colorMapper,
  }) async {
    final pictureInfo = await vg.loadPicture(
      SvgAssetLoader(assetName, colorMapper: colorMapper),
      null,
    );

    // ignore: use_build_context_synchronously
    final view = _getFlutterView(context: context);
    if (view == null) throw Exception('Could not find flutter view');

    final devicePixelRatio = view.devicePixelRatio;
    final width = (size.width * devicePixelRatio).toInt();
    final height = (size.height * devicePixelRatio).toInt();

    final scaleFactor = min(
      width / pictureInfo.size.width,
      height / pictureInfo.size.height,
    );

    final recorder = ui.PictureRecorder();

    Canvas(recorder)
      ..scale(scaleFactor)
      ..drawPicture(pictureInfo.picture);

    final rasterPicture = recorder.endRecording();

    final image = rasterPicture.toImageSync(width, height);
    final bytes = (await image.toByteData(format: ui.ImageByteFormat.png))!;

    return bytes.buffer.asUint8List();
  }

  /// Creates an image from the given [widget] by
  /// 1. Spinning up an element and render tree;
  /// 2. Waiting for the given [delay];
  /// 3. Creating an image via a [RepaintBoundary].
  /// https://github.com/flutter/flutter/issues/40064
  static Future<Uint8List> getImageFromWidget(
    Widget widget, {
    Duration delay = const Duration(milliseconds: 100),
    BuildContext? context,
    Size logicalSize = const Size(800, 600),
  }) async {
    final view = _getFlutterView(context: context);
    if (view == null) throw Exception('Could not find flutter view');

    final devicePixelRatio = view.devicePixelRatio;
    final repaintBoundary = RenderRepaintBoundary();

    final renderView = RenderView(
      view: view,
      child: RenderPositionedBox(
        alignment: Alignment.center,
        child: repaintBoundary,
      ),
      configuration: ViewConfiguration(
        physicalConstraints:
            BoxConstraints.tight(logicalSize) * view.devicePixelRatio,
        logicalConstraints: BoxConstraints.tight(logicalSize),
        devicePixelRatio: view.devicePixelRatio,
      ),
    );

    final pipelineOwner = PipelineOwner()..rootNode = renderView;
    renderView.prepareInitialFrame();

    final buildOwner = BuildOwner(focusManager: FocusManager());

    final rootElement = RenderObjectToWidgetAdapter(
      container: repaintBoundary,
      child: Directionality(
        textDirection: ui.TextDirection.ltr,
        child: IntrinsicHeight(child: IntrinsicWidth(child: widget)),
      ),
    ).attachToRenderTree(buildOwner);

    buildOwner.buildScope(rootElement);

    if (delay > Duration.zero) await Future.delayed(delay);

    buildOwner
      ..buildScope(rootElement)
      ..finalizeTree();
    pipelineOwner
      ..flushLayout()
      ..flushCompositingBits()
      ..flushPaint();

    final image = await repaintBoundary.toImage(pixelRatio: devicePixelRatio);

    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

  static ui.FlutterView? _getFlutterView({BuildContext? context}) {
    if (context != null) {
      return View.of(context);
    }

    final views = WidgetsBinding.instance.platformDispatcher.views;
    if (views.isNotEmpty) {
      return WidgetsBinding.instance.platformDispatcher.views.first;
    }
    return null;
  }

  static bool get isCupertino {
    if (kIsWeb) return false;
    return Platform.isIOS || Platform.isMacOS;
  }
}
