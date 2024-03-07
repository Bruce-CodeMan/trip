import 'package:flutter/material.dart';

/// A custom Input widget with an underline divider
///
/// This widget creates a text field with an underline divider below it.
/// It allows customization of the hint text, keyboardType, and whether
/// the text is obscured(For password field).
class InputWidget extends StatelessWidget {

  /// The hint text displayed in the text field when it is empty
  final String hint;

  /// The callback function that is called when the text in the text field changes
  final ValueChanged<String>? onChanged;

  /// Whether to obscure the text being edited (e.g., for password)
  final bool obscureText;

  /// The type of keyboard to use for editing the text
  final TextInputType? keyboardType;

  /// creates an instance of InputWidget.
  ///
  /// [hint] is the hint text displayed in the text when it is empty
  /// [onChanged] is the callback function when the text changes
  /// [obscureText] determines whether the text is obscured. Default to false
  /// [keyboardType] specifies the type of keyboard for text input
  const InputWidget(
    this.hint,
  {
    super.key,
    this.onChanged,
    this.obscureText = false,
    this.keyboardType
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _input(),
        const Divider(
          color: Colors.white,
          height: 1,
          thickness: 0.5,
        )
      ],
    );
  }

  /// Builds and returns the text field with custom styling.
  Widget _input() {
    return TextField(
      onChanged: onChanged,              // Callback for the text change.
      obscureText: obscureText,          // Whether the text is obscured.
      keyboardType: keyboardType,        // The type of keyboard to display.
      autofocus: !obscureText,           // Autofocus when not obscuring text.
      cursorColor: Colors.white,         // Color of the cursor.
      style: const TextStyle(
          fontSize: 17,
          color: Colors.white,
          fontWeight: FontWeight.w400
      ),
      decoration: InputDecoration(
        border: InputBorder.none,        // No border around the text input.
        hintText: hint,                  // The displayed hint text.
        hintStyle: const TextStyle(
          fontSize: 17,
          color: Colors.grey,
        )
      ),
    );
  }
}
