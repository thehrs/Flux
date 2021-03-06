import 'dart:async';

import 'package:flutter/material.dart';

enum FxDrawerType {
  left,
  right,
  top,
  bottom,
}

mixin FxDrawer {
  static VoidCallback showTopNotification(
    BuildContext context, {
    required Widget child,
    bool showMask = false,
    bool autoHide = true,
  }) {
    return _showBaseDrawer(
      context,
      child: child,
      type: FxDrawerType.top,
      showMask: showMask,
      autoHide: autoHide,
    );
  }

  static VoidCallback showBottomNotification(
    BuildContext context, {
    required Widget child,
    bool showMask = false,
    bool autoHide = true,
  }) {
    return _showBaseDrawer(
      context,
      child: child,
      type: FxDrawerType.bottom,
      showMask: showMask,
      autoHide: autoHide,
    );
  }

  static VoidCallback show(
    BuildContext context, {
    required Widget child,
    FxDrawerType type = FxDrawerType.left,
    bool showMask = true,
    bool autoHide = false,
  }) {
    return _showBaseDrawer(
      context,
      child: child,
      type: type,
      showMask: showMask,
      autoHide: autoHide,
    );
  }

  static VoidCallback _showBaseDrawer(
    BuildContext context, {
    Widget? child,
    FxDrawerType type = FxDrawerType.left,
    bool showMask = false,
    bool autoHide = true,
  }) {
    final OverlayState? overlayState = Overlay.of(context);

    final GlobalKey<_FxDrawerState> key = GlobalKey();

    VoidCallback? hide;

    OverlayEntry? _overlayEntry = OverlayEntry(
      builder: (BuildContext context) => _FxDrawer(
        key: key,
        type: type,
        child: child,
        maskTap: hide,
        showMask: showMask,
      ),
    );
    overlayState?.insert(_overlayEntry);

    final ModalRoute? _route = ModalRoute.of(context);
    Future<bool> backClose() {
      hide!();
      return Future.value(false);
    }

    _route?.addScopedWillPopCallback(backClose);

    hide = () async {
      _route?.removeScopedWillPopCallback(backClose);
      await key.currentState?.reverseAnimation();
      _overlayEntry?.remove();
      _overlayEntry = null;
    };

    if (autoHide) {
      Future.delayed(
        const Duration(milliseconds: 2000),
        hide,
      );
    }

    return hide;
  }
}

class _FxDrawer extends StatefulWidget {
  final FxDrawerType? type;
  final Widget? child;
  final Function? maskTap;
  final bool? showMask;

  const _FxDrawer({
    Key? key,
    this.type,
    this.child,
    this.maskTap,
    this.showMask,
  }) : super(key: key);

  @override
  _FxDrawerState createState() => _FxDrawerState();
}

class _FxDrawerState extends State<_FxDrawer> with TickerProviderStateMixin {
  int duration = 300;
  GlobalKey boxKey = GlobalKey();
  AnimationController? controller;

  Animation<double>? offsetAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: Duration(milliseconds: duration),
      vsync: this,
    );

    offsetAnimation = Tween<double>(begin: 2000, end: 0).animate(
      CurvedAnimation(
        parent: controller!,
        curve: Curves.ease,
      ),
    );

    WidgetsBinding.instance?.addPostFrameCallback(getBoxHeight);
  }

  void getBoxHeight(Duration time) {
    initAnimation();
  }

  // Reverse Animation
  Future<void> reverseAnimation() async {
    await controller?.reverse();
  }

  // Initialization
  void initAnimation() {
    final double? size =
        widget.type == FxDrawerType.top || widget.type == FxDrawerType.bottom
            ? boxKey.currentContext?.size?.height
            : boxKey.currentContext?.size?.width;

    double begin;
    // switch case
    switch (widget.type!) {
      case FxDrawerType.top:
      case FxDrawerType.left:
        begin = -size!;
        break;
      case FxDrawerType.right:
      case FxDrawerType.bottom:
        begin = size!;
        break;
    }

    offsetAnimation = Tween<double>(begin: begin, end: 0).animate(
      CurvedAnimation(
        parent: controller!,
        curve: Curves.ease,
      ),
    );
    // Forward animation
    controller?.forward();
  }

  @override
  Widget build(BuildContext context) {
    Offset offset;
    double? top = 0.0;
    double? right = 0.0;
    double? bottom = 0.0;
    double? left = 0.0;

    // ????????????
    switch (widget.type!) {
      case FxDrawerType.top:
        bottom = null;
        break;
      case FxDrawerType.right:
        left = null;
        break;
      case FxDrawerType.bottom:
        top = null;
        break;
      case FxDrawerType.left:
        right = null;
        break;
    }
    return AnimatedBuilder(
        animation: controller!,
        builder: (BuildContext context, Widget? child) {
          // ??????
          if (widget.type == FxDrawerType.top ||
              widget.type == FxDrawerType.bottom) {
            offset = Offset(
              0,
              offsetAnimation!.value,
            );
          } else {
            offset = Offset(
              offsetAnimation!.value,
              0,
            );
          }

          final List<Widget> children = [];

          if (widget.showMask!) {
            children.add(Positioned(
              top: 0,
              right: 0,
              bottom: 0,
              left: 0,
              child: GestureDetector(
                onTap: maskTap,
                child: const DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.black45,
                  ),
                ),
              ),
            ));
          }

          children.add(
            Positioned(
              top: top,
              right: right,
              bottom: bottom,
              left: left,
              child: Transform.translate(
                offset: offset,
                child: DecoratedBox(
                  key: boxKey,
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Material(
                    child: widget.child,
                  ),
                ),
              ),
            ),
          );

          return Stack(children: children);
        });
  }

  void maskTap() {
    if (widget.maskTap != null) {
      widget.maskTap!();
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
