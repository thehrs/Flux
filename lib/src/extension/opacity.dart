import 'package:flutter/material.dart';

extension OpacityExtension on Widget {
  Widget opacity({Key? key, required double value}) =>
      Opacity(key: key, opacity: value, child: this);

  Widget opacity0({Key? key}) => Opacity(opacity: 0.0, child: this);
  Widget opacity10({Key? key}) => Opacity(opacity: 0.1, child: this);
  Widget opacity15({Key? key}) => Opacity(opacity: 0.15, child: this);
  Widget opacity20({Key? key}) => Opacity(opacity: 0.2, child: this);
  Widget opacity25({Key? key}) => Opacity(opacity: 0.25, child: this);
  Widget opacity30({Key? key}) => Opacity(opacity: 0.3, child: this);
  Widget opacity35({Key? key}) => Opacity(opacity: 0.35, child: this);
  Widget opacity40({Key? key}) => Opacity(opacity: 0.4, child: this);
  Widget opacity45({Key? key}) => Opacity(opacity: 0.45, child: this);
  Widget opacity50({Key? key}) => Opacity(opacity: 0.5, child: this);
  Widget opacity55({Key? key}) => Opacity(opacity: 0.55, child: this);
  Widget opacity60({Key? key}) => Opacity(opacity: 0.6, child: this);
  Widget opacity65({Key? key}) => Opacity(opacity: 0.65, child: this);
  Widget opacity70({Key? key}) => Opacity(opacity: 0.7, child: this);
  Widget opacity75({Key? key}) => Opacity(opacity: 0.75, child: this);
  Widget opacity80({Key? key}) => Opacity(opacity: 0.8, child: this);
  Widget opacity85({Key? key}) => Opacity(opacity: 0.85, child: this);
  Widget opacity90({Key? key}) => Opacity(opacity: 0.9, child: this);
  Widget opacity95({Key? key}) => Opacity(opacity: 0.95, child: this);
  Widget opacity100({Key? key}) => Opacity(opacity: 1.0, child: this);
}
