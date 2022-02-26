import 'package:flutter/material.dart';
import 'package:flux/src/common/builder.dart';

/// Center the widget
extension CenterExtension on Widget {
  ///
  /// Extension method to directly access [Center] with any widget without wrapping or with dot operator.
  ///
  Widget centered({Key? key}) => Center(key: key, child: this);

  // _MyPaddingCallable get padding => _MyPaddingCallable(build());
}

extension CenterBuilderExtension on FxWidgetBuilder<Widget> {
  ///
  /// Extension method to directly access [Center] with any Vx widget without wrapping or with dot operator.
  ///
  Widget makeCentered({Key? key}) => Center(key: key, child: make());
}