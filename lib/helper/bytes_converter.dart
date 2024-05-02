extension ConvertByte on int {
  String formatBytes() {
    const int KB = 1024;
    const int MB = 1024 * 1024;

    if (this >= MB) {
      return '${(this / MB).toStringAsFixed(2)} MB';
    } else if (this >= KB) {
      return '${(this / KB).toStringAsFixed(2)} KB';
    } else {
      return "$this bytes";
    }
  }
}
