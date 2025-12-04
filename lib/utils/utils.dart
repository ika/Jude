class Utils {
  String displayedTextFunc(int maxLen, String text) {
    final String displayedText = text.length > maxLen
        ? '${text.substring(0, maxLen)}...'
        : text;
    return displayedText;
  }
}
