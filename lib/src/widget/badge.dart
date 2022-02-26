import 'package:flutter/material.dart';
import 'package:flux/src/common/flux_round.dart';

enum FxBadgeType { point, round, ellipse }

enum FxBadgePosition { left, right, leftTop, rightTop, leftBottom, rightBottom }

/// FxBadge widget for using common badges as number or dot.

class FxBadge extends StatelessWidget {
  final FxBadgeType type;
  final Color? color;
  final TextStyle? textStyle;
  final int? count;
  final bool limit;
  final Widget? child;
  final double? size;
  final FxBadgePosition position;

  /// To provide an optional widget like an Icon
  final Widget? optionalWidget;

  const FxBadge({
    required this.child,
    this.type = FxBadgeType.round,
    this.color,
    this.textStyle,
    this.count,
    this.limit = false,
    this.size,
    this.optionalWidget,
    this.position = FxBadgePosition.rightTop,
  });

  @override
  Widget build(BuildContext context) {
    if (child == null && optionalWidget == null) {
      return getFxRound();
    }
    return positionView();
  }

  /// Get the number to show in the badge
  String getNumber() {
    if (count == null) {
      return "";
    } else if (limit && count! > 99) {
      return '99+';
    }
    return '$count';
  }

  /// Get the style of the text
  TextStyle getTextStyle() {
    return textStyle ?? const TextStyle(fontSize: 8, color: Colors.white);
  }

  /// Get the Fx Round type whether [FxBadgeType.point] or [FxBadgeType.ellipse] or [FxBadgeType.round]
  Widget getFxRound() {
    if (type == FxBadgeType.point) {
      return FxRound(
        type: FxRoundType.point,
        size: size,
        color: color,
      );
    } else if (type == FxBadgeType.round) {
      return FxRound(
        type: FxRoundType.round,
        color: color,
        size: size,
        child: optionalWidget ??
            Text(
              getNumber(),
              style: getTextStyle(),
            ),
      );
    } else {
      return FxRound(
        type: FxRoundType.ellipse,
        color: color,
        size: size,
        child: optionalWidget ??
            Text(
              getNumber(),
              style: getTextStyle(),
            ),
      );
    }
  }

  /// Get the position view
  Widget positionView() {
    final List<Widget> children = [];
    children.add(child!);
    if (position == FxBadgePosition.left) {
      children.insert(0, getFxRound());
    } else if (position == FxBadgePosition.right) {
      children.add(getFxRound());
    } else if (position == FxBadgePosition.leftTop) {
      children.add(Positioned(
        top: 0,
        left: 0,
        child: getFxRound(),
      ));
    } else if (position == FxBadgePosition.rightTop) {
      children.add(Positioned(
        top: 0,
        right: 0,
        child: getFxRound(),
      ));
    } else if (position == FxBadgePosition.leftBottom) {
      children.add(Positioned(
        bottom: 0,
        left: 0,
        child: getFxRound(),
      ));
    } else if (position == FxBadgePosition.rightBottom) {
      children.add(Positioned(
        bottom: 0,
        right: 0,
        child: getFxRound(),
      ));
    }

    if (position == FxBadgePosition.left || position == FxBadgePosition.right) {
      return Row(
        children: children,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
      );
    } else {
      return Stack(
        children: children,
      );
    }
  }
}

extension BadgeExtension on Widget {
  ///
  /// Extension method to directly access [FxBadge] with any widget without wrapping or with dot operator.
  ///
  /// show [badge] extension

  Widget badge({
    FxBadgeType type = FxBadgeType.round,
    Color? color,
    TextStyle? textStyle,
    int? count,
    bool limit = false,
    double? size,
    Widget? optionalWidget,
    FxBadgePosition position = FxBadgePosition.rightTop,
  }) =>
      FxBadge(
        child: this,
        textStyle: textStyle,
        color: color,
        limit: limit,
        count: count,
        position: position,
        size: size,
        type: type,
        optionalWidget: optionalWidget,
      );
}
