import 'package:flutter/material.dart';

enum FxDividerType {
  horizontal,
  vertical,
}

class FxDivider extends StatelessWidget {
  final FxDividerType type;
  final Color? color;
  final double width;
  final double? indent;
  final double? endIndent;

  const FxDivider({
    this.type = FxDividerType.horizontal,
    this.color,
    this.width = 1,
    this.indent,
    this.endIndent,
  });

  @override
  Widget build(BuildContext context) {
    final DividerThemeData dividerTheme = DividerTheme.of(context);
    final double indent = this.indent ?? dividerTheme.indent ?? 0.0;
    final double endIndent = this.endIndent ?? dividerTheme.endIndent ?? 0.0;

    final Color effectiveColor =
        color ?? dividerTheme.color ?? Theme.of(context).dividerColor;

    if (type == FxDividerType.horizontal) {
      return Container(
        height: width,
        margin: EdgeInsetsDirectional.only(
          start: indent,
          end: endIndent,
        ),
        color: effectiveColor,
      );
    } else {
      return Container(
        width: width,
        margin: EdgeInsetsDirectional.only(
          top: indent,
          bottom: endIndent,
        ),
        color: effectiveColor,
      );
    }
  }
}
