import 'package:flutter/material.dart';

// Custom imports for different pages within the app
import 'package:trip/pages/home_page.dart';
import 'package:trip/pages/login_page.dart';

// NavigatorUtil class to handle navigation throughout the app.
class NavigatorUtil {
  // A static BuildContext variable to keep track of the current context.
  static BuildContext? _context;

  // Static method to update the current context stored in this utility class
  static updateContext(BuildContext context) {
    NavigatorUtil._context = context;
  }

  // Static method to push a new page onto the navigation Stack
  // This allows the user to navigate to a new page with the ability to go back
  static push(BuildContext context, Widget widget) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
  }

  // Static method to navigate the HomePage and replace the current page
  // This is typically used when you don't want the user to go back the previous page
  static goToHome(BuildContext context) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
  }

  // Static method to navigate the LoginPage and replace the current page.
  // It uses the context stored in the navigatorUtil class
  // This method assumes that _context is not null & will throw an error if it is.
  static goToLogin() {
    Navigator.pushReplacement(_context!, MaterialPageRoute(builder: (context) => const LoginPage()));
  }
}