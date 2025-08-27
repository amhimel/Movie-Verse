import 'package:flutter/material.dart';

class NavigationService {
  late GlobalKey<NavigatorState> navigatorKey;

  NavigationService() {
    navigatorKey = GlobalKey<NavigatorState>();
  }

  navigate(Widget widget) {
    return navigatorKey.currentState?.push(
      MaterialPageRoute(builder: (context) => widget),
    );
  }

  navigateReplace(Widget widget) {
    return navigatorKey.currentState?.pushReplacement(
      MaterialPageRoute(builder: (context) => widget),
    );
  }

  showSnackBar(Widget widget) {
    final context = navigatorKey.currentContext;
    ScaffoldMessenger.of(context!).hideCurrentMaterialBanner();
    final snackBarWidget = SnackBar(content: widget);
    ScaffoldMessenger.of(context).showSnackBar(snackBarWidget);
  }

  Future<void> showDialog(BuildContext? context, Widget widget) async {
    await showAdaptiveDialog(
      context: context ?? navigatorKey.currentContext!,
      builder: (context) => widget,
    );
  }
}
