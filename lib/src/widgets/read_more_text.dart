import 'package:flutter/material.dart';

/// Widget that allows expanding and collapsing text based on its characters count.
class ReadMoreText extends StatefulWidget {
  final String text;
  final int trimCharsCount;
  final String readMoreExpandedText;
  final String readMoreCollapsedText;
  final TextStyle? style;
  final TextStyle? readMoreTextStyle;

  /// Appended to the trimmed text while collapsed.
  final String ellipsis;

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
    this.ellipsis = '... ',
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
        ? _trim(widget.text, widget.trimCharsCount)
        : widget.text;
    return AnimatedSize(
      duration: const Duration(milliseconds: 200),
      child: InkWell(
        onTap: shouldTrimText ? onTapClick : null,
        child: Text.rich(
          TextSpan(
            text: _showLongDescription
                ? widget.text
                : '$shortDescription${shouldTrimText ? widget.ellipsis : ''}',
            style: widget.style,
            children: [
              if (shouldTrimText)
                TextSpan(
                  text: _showLongDescription
                      ? widget.readMoreExpandedText
                      : widget.readMoreCollapsedText,
                  style:
                      widget.readMoreTextStyle ??
                      TextStyle(color: Theme.of(context).primaryColor),
                ),
            ],
          ),
        ),
      ),
    );
  }

  /// Trims [text] to at most [count] characters, preferring a word boundary and
  /// never splitting a surrogate pair (e.g. an emoji).
  static String _trim(String text, int count) {
    var end = count.clamp(0, text.length);
    if (end > 0 && end < text.length) {
      final unit = text.codeUnitAt(end - 1);
      if (unit >= 0xD800 && unit <= 0xDBFF) end--; // high surrogate
    }
    final cut = text.substring(0, end);
    final space = cut.lastIndexOf(RegExp(r'\s'));
    // Only snap to a word boundary if it doesn't discard too much text.
    if (space > end * 0.6 &&
        end < text.length &&
        !text[end].contains(RegExp(r'\s'))) {
      return cut.substring(0, space).trimRight();
    }
    return cut.trimRight();
  }
}
