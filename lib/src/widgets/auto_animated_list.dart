import 'dart:math';

import 'package:flutter/material.dart';

typedef ItemBuilder<S> =
    Widget Function(BuildContext context, S item, int index);

/// Widget that automatically animates list of items when inserting or deleting any item.
class AutoAnimatedList<T> extends StatefulWidget {
  /// List of the items that will be displayed.
  final List<T> items;

  /// builder to build each item of the list and return it's widget.
  final ItemBuilder<T> itemBuilder;

  /// Determines whether the list should be animated or not.
  final bool shouldAnimate;

  /// Header widget that is displayed on the top of the list.
  final Widget? header;

  /// Footer widget that is displayed on the bottom of the list.
  final Widget? footer;

  const AutoAnimatedList({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.header,
    this.footer,
    this.shouldAnimate = true,
  });

  @override
  State<AutoAnimatedList<T>> createState() => _AutoAnimatedListState<T>();
}

class _AutoAnimatedListState<T> extends State<AutoAnimatedList<T>> {
  GlobalKey<AnimatedListState> key = GlobalKey<AnimatedListState>();
  late List<T> currentItemsList;
  late int initialCount;

  @override
  void initState() {
    super.initState();
    currentItemsList = List.from(widget.items);
    initialCount = currentItemsList.length;
  }

  @override
  Widget build(BuildContext context) {
    updateCurrentList();
    return AnimatedList(
      key: key,
      initialItemCount: currentItemsList.length + 2,
      itemBuilder: (context, index, animation) {
        if (index == 0) {
          return widget.header ?? Container();
        }
        if (index == currentItemsList.length + 1) {
          return widget.footer ?? Container();
        }
        return buildListItem(
          context,
          currentItemsList[index - 1],
          animation,
          index - 1,
        );
      },
    );
  }

  Widget buildListItem(
    BuildContext context,
    T item,
    Animation<double> animation,
    int index,
  ) {
    return SizeTransition(
      key: Key(item.hashCode.toString()),
      sizeFactor: CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOutCubic,
      ),
      child: FadeTransition(
        opacity: animation,
        child: widget.itemBuilder(context, item, index),
      ),
    );
  }

  void updateCurrentList() {
    final newItems = widget.items;
    var i = 0;
    while (i < max(currentItemsList.length, newItems.length)) {
      if (i >= currentItemsList.length) {
        addItem(currentItemsList, i, newItems[i]);
        i++;
      } else if (i >= newItems.length) {
        removeItem(currentItemsList, i);
      } else {
        final item = currentItemsList[i];
        final newItem = newItems[i];
        if (newItem != item) {
          if (newItems.contains(item)) {
            addItem(currentItemsList, i, newItem);
            i++;
          } else {
            removeItem(currentItemsList, i);
          }
        } else {
          i++;
        }
      }
    }
  }

  void removeItem(List<T> list, int index) {
    final state = key.currentState;
    final item = list[index];
    state?.removeItem(index + 1, (context, animation) {
      return widget.shouldAnimate
          ? buildListItem(context, item, animation, index)
          : Container();
    });

    list.removeAt(index);
  }

  void addItem(List list, int index, T item) {
    final state = key.currentState;
    list.insert(index, item);
    state?.insertItem(index + 1);
  }
}
