import 'package:sprintf/sprintf.dart';

extension StringX on String {
  /// Formats the string with a single argument
  /// Uses the common sprintf denotation: %s, %d ..
  /// see [PrintFormat]
  String format(dynamic arg) => sprintf(this, [arg]);

  /// Formats the string with a list of arguments
  /// Uses the common sprintf denotation: %s, %d ..
  /// see [PrintFormat]
  String formats(List args) => sprintf(this, args);

  bool get isMultiLine => contains('\n');

  bool get isSingleLine => !isMultiLine;

  int localeCompareTo(
    String other,
    List<String> alphabet, {
    bool ignoreCase = true,
  }) {
    final mainString = ignoreCase ? toLowerCase() : this;
    final otherString = ignoreCase ? other.toLowerCase() : other;

    if (mainString == otherString) {
      return 0;
    }

    final firstLength = mainString.length;
    for (int i = 0; i < firstLength; i++) {
      final firstChar = mainString[i];
      if (otherString.length == i) {
        // otherString is shorter
        return 1;
      }
      final secondChar = otherString[i];

      if (firstChar == secondChar) {
        // chars equal, keep checking
      } else {
        final firstCharIndex = alphabet.indexOf(firstChar);
        final secondCharIndex = alphabet.indexOf(secondChar);

        if (firstCharIndex == -1 || secondCharIndex == -1) {
          // in case we found char that not exist in owr alphabet, we don't know the value of it,
          // so we ask native method to compare
          return firstChar.compareTo(secondChar);
        }

        if (firstCharIndex < secondCharIndex) {
          // in case firstChar comes earlier, it means that the mainString should be before second
          return -1;
        } else if (firstCharIndex > secondCharIndex) {
          // in case firstChar comes after, it means that the otherString should be before second
          return 1;
        }
      }
    }

    return mainString.compareTo(otherString);
  }
}
