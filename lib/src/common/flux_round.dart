import 'package:flutter/material.dart';

enum VxRoundType { point, round, ellipse }
enum FxRoundType { point, round, ellipse }

class FxRound extends StatelessWidget {
  final FxRoundType type;
  final double? size;
  final Color? color;
  final dynamic child;
  final TextStyle? textStyle;
  const FxRound({
    Key? key,
    this.type = FxRoundType.point,
    this.size,
    this.color,
    this.child,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (type == VxRoundType.point) {
      final double tempSize = size ?? 8;
      return Container(
        width: tempSize,
        height: tempSize,
        decoration: BoxDecoration(
          color: color ?? Theme.of(context).primaryColorLight,
          shape: BoxShape.circle,
        ),
      );
    } else if (type == VxRoundType.round) {
      final double tempSize = size ?? 16;
      return Container(
        width: tempSize,
        height: tempSize,
        decoration: BoxDecoration(
          color: color ?? Theme.of(context).primaryColorLight,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: getContent(),
      );
    } else {
      final double tempSize = size ?? 16;
      final Radius radius = Radius.circular(tempSize / 2);
      return Container(
        constraints: BoxConstraints(
            maxHeight: tempSize, minHeight: tempSize, minWidth: tempSize),
        padding: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: color ?? Theme.of(context).primaryColorLight,
          borderRadius: BorderRadius.horizontal(left: radius, right: radius),
        ),
        child: Row(
          children: [getContent()!],
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      );
    }
  }

  /// Get the background color
  Color getBgColor(BuildContext context) {
    return color ?? Theme.of(context).primaryColor;
  }

  /// Get the text style
  TextStyle getTextStyle() {
    return textStyle ?? const TextStyle(fontSize: 8, color: Colors.white);
  }

  /// Get the content
  Widget? getContent() {
    if (child is String) {
      return Text(child, style: getTextStyle(), maxLines: 1);
    } else if (child is Widget) {
      return child;
    } else {
      return const Offstage();
    }
  }
}

