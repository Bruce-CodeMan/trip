/// Checks whether the given string [text] is not empty.
///
/// Returns `true` if [text] contains one or more characters.
/// and is not just a string with only whitespace characters.
/// Returns `false` if [text] is `null` or empty
bool isNotEmpty(String? text) {
  return text?.isNotEmpty ?? false;
}

/// Checks if the given string [text] is empty.
///
/// Returns `true` if [text] is `null` or contains no characters.
/// Returns `false` if [text] contains one or more characters.
bool isEmpty(String? text) {
  return text?.isEmpty ?? true;
}