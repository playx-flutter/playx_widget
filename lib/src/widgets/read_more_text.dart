import 'package:flutter/material.dart';

//Widget that allows Expanding and collapsing text based on it's characters count
class ReadMoreText extends StatefulWidget {
  final String text;
  final int trimCharsCount;
  final String readMoreExpandedText;
  final String readMoreCollapsedText;
  final TextStyle? style;
  final TextStyle? readMoreTextStyle;

  @override
  State<ReadMoreText> createState() => _ReadMoreTextState();

  const ReadMoreText(
    this.text, {
    super.key,
    this.trimCharsCount = 125,
    this.style,
    this.readMoreExpandedText = '',
    this.readMoreCollapsedText = '',
    this.readMoreTextStyle,
  });
}

class _ReadMoreTextState extends State<ReadMoreText> {
  bool _showLongDescription = false;

  void onTapClick() {
    setState(() {
      _showLongDescription = !_showLongDescription;
    });
  }

  @override
  Widget build(BuildContext context) {
    final shouldTrimText = widget.text.length > widget.trimCharsCount;

    final shortDescription = shouldTrimText
        ? widget.text.substring(0, widget.trimCharsCount)
        : widget.text;
    return AnimatedSize(
      duration: const Duration(milliseconds: 200),
      child: InkWell(
        onTap: onTapClick,
        child: RichText(
          text: TextSpan(
            text: _showLongDescription ? widget.text : shortDescription,
            style: widget.style,
            children: [
              if (shouldTrimText)
                TextSpan(
                  text: _showLongDescription
                      ? widget.readMoreExpandedText
                      : widget.readMoreCollapsedText,
                  style: widget.readMoreTextStyle ??
                      TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
