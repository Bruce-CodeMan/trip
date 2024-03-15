import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Custom imports for different pages within the app
import 'package:trip/pages/home_page.dart';
import 'package:trip/pages/login_page.dart';
import 'package:trip/widgets/bruce_webview.dart';

/// NavigatorUtil class to handle navigation throughout the app.
class NavigatorUtil {
  /// A static BuildContext variable to keep track of the current context.
  /// Need declares the _context in the tabNavigator
  static BuildContext? _context;

  /// Static method to update the current context stored in this utility class
  static updateContext(BuildContext context) {
    NavigatorUtil._context = context;
  }

  /// Static method to push a new page onto the navigation Stack
  /// This allows the user to navigate to a new page with the ability to go back
  static push(BuildContext context, Widget widget) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
  }

  /// Static method to navigate the HomePage and replace the current page
  /// This is typically used when you don't want the user to go back the previous page
  static goToHome(BuildContext context) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
  }

  /// Static method to navigate the LoginPage and replace the current page.
  /// It uses the context stored in the navigatorUtil class
  /// This method assumes that _context is not null & will throw an error if it is.
  static goToLogin() {
    Navigator.pushReplacement(_context!, MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  /// Static method to return back the previous page.
  static pop(BuildContext context) {
    if(Navigator.canPop(context)) {
      Navigator.pop(context);
    }else {
      SystemNavigator.pop();
    }
  }

  /// Static method to jump to the H5 page
  static jumpToH5({
    BuildContext? context,
    String? url,
    String? title,
    bool? hideAppBar,
    String? statusBarColor
  }) {
    if(url == null) {
      debugPrint("url is null jumpToH5 failed.");
      return;
    }
    BuildContext? safeContext;
    if(context != null) {
      safeContext = context;
    }else if(_context?.mounted ?? false) {
      safeContext = _context;
    }else {
      debugPrint("context is null jumpToH5 failed.");
      return;
    }
    Navigator.push(
      safeContext!,
      MaterialPageRoute(
        builder: (context) => BruceWebView(
          url: url,
          title: title,
          hideAppBar: hideAppBar,
          statusBarColor: statusBarColor,
        ))
    );
  }
}