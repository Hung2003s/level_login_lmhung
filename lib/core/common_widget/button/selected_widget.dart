import 'package:flutter/material.dart';

import '../../constants/app_color.dart';

class SelectedWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final GestureTapDownCallback? onTapDown;
  final GestureTapUpCallback? onTapUp;
  final GestureTapCallback? onTapCancel;
  final GestureTapCallback? onDoubleTap;
  final GestureLongPressCallback? onLongPress;
  final GestureLongPressUpCallback? onLongPressUp;
  final GestureTapCallback? onSecondaryTap;
  final GestureTapUpCallback? onSecondaryTapUp;
  final GestureTapDownCallback? onSecondaryTapDown;
  final GestureTapCallback? onSecondaryTapCancel;
  final ValueChanged<bool>? onHighlightChanged;
  final ValueChanged<bool>? onHover;
  final ValueChanged<bool>? onFocusChange;
  final Widget child;
  final Color? backgroundColor;
  final Color? rippleColor;
  final Color? highlightColor;
  final BorderRadius? borderRadius;

  const SelectedWidget({
    super.key,
    required this.onTap,
    required this.child,
    this.backgroundColor,
    this.rippleColor,
    this.highlightColor,
    this.borderRadius,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.onDoubleTap,
    this.onLongPress,
    this.onLongPressUp,
    this.onSecondaryTap,
    this.onSecondaryTapUp,
    this.onSecondaryTapDown,
    this.onSecondaryTapCancel,
    this.onHighlightChanged,
    this.onHover, this.onFocusChange,
  });

  /// xay dung giao dien nut bam co ban
  @override
  Widget build(BuildContext context) {
    final themeColor = backgroundColor ?? AppColor.orange;

    return Material(
      color: themeColor,
      borderRadius: borderRadius ?? BorderRadius.circular(8),
      child: InkWell(
        borderRadius: borderRadius ?? BorderRadius.circular(8),
        highlightColor: highlightColor ?? AppColor.gray.withValues(alpha: 0.2),
        splashColor: rippleColor ?? AppColor.gray.withValues(alpha: 0.2),
        onTap: onTap,
        onTapDown: onTapDown,
        onDoubleTap: onDoubleTap,
        onLongPress: onLongPress,
        onFocusChange: onFocusChange,
        onLongPressUp: onLongPressUp,
        onHover: onHover,
        onSecondaryTap: onSecondaryTap,
        onTapUp: onTapUp,
        onHighlightChanged: onHighlightChanged,
        onTapCancel: onTapCancel,
        onSecondaryTapCancel: onSecondaryTapCancel,
        onSecondaryTapDown: onSecondaryTapDown,
        onSecondaryTapUp: onSecondaryTapUp,
        child: child,
      ),
    );
  }
}
