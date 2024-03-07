import 'package:flutter/material.dart';

/// A custom button widget designed for the login screen
///
/// This button is styled specifically for the application's login interface.
/// It can be enabled or disabled based on the [isPressed] flag, and it executes
/// the [onPressed] callback when tapped
class LoginButton extends StatelessWidget {

  /// The text to display on the button.
  final String title;

  /// A flag indicating whether the button is enabled or disabled
  final bool isPressed;

  /// The callback function to be called when the button is pressed.
  /// If the button is disabled([isPressed] is false), the callback won't be executed.
  final VoidCallback? onPressed;

  /// creates an instance of LoginButton
  ///
  /// [title] is required and will be displayed on the button.
  /// [isPressed] defaults to true,indicating that button is enabled by default.
  /// [onPressed] is a callback that is invoked when the button is pressed,
  /// which could be null if the button is not intend to have an action.
  const LoginButton({
    super.key,
    required this.title,
    this.isPressed = true,
    this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      height: 5,
      onPressed: isPressed ? onPressed : null,
      color: Colors.orange,
      disabledColor: Colors.white54,
      child: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}
