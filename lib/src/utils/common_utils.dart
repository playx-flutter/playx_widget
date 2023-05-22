import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Future<Uint8List> getUnit8ListFromSvgAsset(
  String assetName, {
  Size size = const Size(48, 48),
}) async {
  final pictureInfo = await vg.loadPicture(SvgAssetLoader(assetName), null);

  final devicePixelRatio = WidgetsBinding.instance.platformDispatcher.views
      .map((e) => e.devicePixelRatio)
      .reduce((value, element) => max(value, element));
  final width = (size.width * devicePixelRatio).toInt();
  final height = (size.height * devicePixelRatio).toInt();

  final scaleFactor = min(
    width / pictureInfo.size.width,
    height / pictureInfo.size.height,
  );

  final recorder = PictureRecorder();

  Canvas(recorder)
    ..scale(scaleFactor)
    ..drawPicture(pictureInfo.picture);

  final rasterPicture = recorder.endRecording();

  final image = rasterPicture.toImageSync(width, height);
  final bytes = (await image.toByteData(format: ImageByteFormat.png))!;

  return bytes.buffer.asUint8List();
}
