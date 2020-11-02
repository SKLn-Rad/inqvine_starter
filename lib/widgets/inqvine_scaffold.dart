import 'package:flutter/material.dart';

class InqvineScaffold extends StatelessWidget {
  const InqvineScaffold({
    @required this.child,
    this.blockDeviceTextScaling = true,
    this.willPopScope,
    Key key,
  }) : super(key: key);

  final Widget child;

  final bool blockDeviceTextScaling;
  final Future<bool> Function() willPopScope;

  void handleKeyboardDismiss(BuildContext context) {
    final FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    return WillPopScope(
      onWillPop: willPopScope ?? () async => true,
      child: MediaQuery(
        data: mediaQueryData.copyWith(
          textScaleFactor: blockDeviceTextScaling ? 1.0 : mediaQueryData.textScaleFactor,
          boldText: blockDeviceTextScaling ? false : mediaQueryData.boldText,
        ),
        child: ScrollConfiguration(
          behavior: InqvineScrollConfiguration(),
          child: GestureDetector(
            onTap: () => handleKeyboardDismiss(context),
            child: child,
          ),
        ),
      ),
    );
  }
}

class InqvineScrollConfiguration extends ScrollBehavior {
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }

  @override
  TargetPlatform getPlatform(BuildContext context) {
    return TargetPlatform.android;
  }
}
