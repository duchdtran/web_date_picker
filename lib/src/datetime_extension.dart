import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime? {
  String parseToString(String dateFormat) {
    if (this == null) return '';
    return DateFormat(dateFormat).format(this!);
  }
}
