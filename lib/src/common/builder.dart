import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

abstract class FxWidgetBuilder<T extends Widget> {
  T make({Key? key});
}
