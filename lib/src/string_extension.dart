import 'package:intl/intl.dart';

extension StringExtension on String {
  DateTime parseToDateTime(String dateFormat) {
    if (length > dateFormat.length) return DateTime.now();
    try {
      return DateFormat(dateFormat).parse(this);
    } on FormatException catch (_) {
      return DateTime.now();
    }
  }
}
