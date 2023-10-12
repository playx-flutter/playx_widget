import 'package:flutter/material.dart';

///Creates a button that shows favorite state.
///
/// It displays favorite icon for in favorite and favorite_border for else.
class FavoriteButton extends StatefulWidget {
  /// Whether the item is in favorites.
  final bool isInFavorite;

  /// Color of icon when the item is not in favorites.
  final Color iconColor;

  /// Color of icon when the item in favorites.
  final Color favoriteIconColor;

  /// Duration for switching between favorite's states animation.
  final Duration duration;

  /// Callback for changes in favorite state.
  final Function(bool)? onFavoriteChanged;

  ///Size for the icon.
  final double? iconSize;

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();

  const FavoriteButton({
    super.key,
    this.isInFavorite = false,
    this.onFavoriteChanged,
    this.iconColor = Colors.red,
    this.favoriteIconColor = Colors.red,
    this.duration = const Duration(milliseconds: 350),
    this.iconSize,
  });
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isInFavorite = false;

  @override
  void initState() {
    super.initState();
    isInFavorite = widget.isInFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        setState(() {
          isInFavorite = !isInFavorite;
          widget.onFavoriteChanged?.call(isInFavorite);
        });
      },
      icon: AnimatedSwitcher(
        duration: widget.duration,
        transitionBuilder: (child, anim) =>
            ScaleTransition(scale: anim, child: child),
        child: isInFavorite
            ? Icon(
                Icons.favorite,
                color: widget.favoriteIconColor,
                key: const ValueKey("icon1"),
                size: widget.iconSize,
              )
            : Icon(
                Icons.favorite_border,
                color: widget.iconColor,
                key: const ValueKey("icon2"),
                size: widget.iconSize,
              ),
      ),
    );
  }
}
