import 'package:flutter/material.dart';

import '../../playx_widget.dart';

// Confirmation dialog that can be used to confirm any operation.
Future<bool> showConfirmDialog({
  required String title,
  required String message,
  required String lottie,
  required VoidCallback onConfirmed,
  required BuildContext context,
  String confirmText = "Confirm",
  String cancelText = "Cancel",
  double? lottieAnimationHeight,
  Color lottieAnimationBackgroundColor = const Color(0xFF33CDBB),
  EdgeInsetsGeometry? lottieAnimationPadding,
  TextStyle? titleTextStyle,
  TextStyle? messageTextStyle,
  TextStyle? confirmButtonTextStyle,
  TextStyle? cancelButtonTextStyle,
  ButtonStyle? confirmButtonStyle,
  ButtonStyle? cancelButtonStyle,
}) async {
  bool isConfirmed = false;
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return Center(
        child: Card(
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          clipBehavior: Clip.hardEdge,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                alignment: Alignment.center,
                color: lottieAnimationBackgroundColor,
                child: Container(
                  height: lottieAnimationHeight,
                  padding: lottieAnimationPadding,
                  child: lottie.isEmpty
                      ? Container()
                      : Lottie.asset(lottie, width: double.infinity),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 16,
                ),
                width: double.infinity,
                child: Text(
                  title,
                  style:
                      titleTextStyle ??
                      const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.start,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 16,
                ),
                width: double.infinity,
                child: Text(
                  message,
                  style: messageTextStyle ?? const TextStyle(fontSize: 18),
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            isConfirmed = true;
                            onConfirmed();
                          },
                          style:
                              confirmButtonStyle ??
                              ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 16,
                                ),
                              ),
                          child: Text(
                            confirmText,
                            style:
                                confirmButtonTextStyle ??
                                const TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton(
                          onPressed: () {
                            isConfirmed = false;
                            Navigator.pop(context);
                          },
                          style:
                              cancelButtonStyle ??
                              TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                          child: Text(
                            cancelText,
                            style:
                                cancelButtonTextStyle ??
                                const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );

  return isConfirmed;
}
