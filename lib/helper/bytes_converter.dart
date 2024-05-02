extension ConvertByte on int {
  String formatBytes() {
    const int kb = 1024;
    const int mb = 1024 * 1024;

    if (this >= mb) {
      return '${(this / mb).toStringAsFixed(2)} MB';
    } else if (this >= kb) {
      return '${(this / kb).toStringAsFixed(2)} KB';
    } else {
      return "$this bytes";
    }
  }
}
