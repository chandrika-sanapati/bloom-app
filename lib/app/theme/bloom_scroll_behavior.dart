import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Bouncy overscroll on Android and iOS so end-of-list rubber-banding feels
/// consistent. Skips the Material stretch/glow indicator, which can look weak
/// or odd on light canvases and emulators.
class BloomScrollBehavior extends MaterialScrollBehavior {
  const BloomScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.trackpad,
  };

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics());
  }

  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }
}
