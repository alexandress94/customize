import 'package:intl/intl.dart';

class FormatDate {
  static String replaceMaskDate({required DateTime date}) {
    return DateFormat("dd/MM/yyy").format(date);
  }

  static String replaceMaskFilterDate({required DateTime date}) {
    return DateFormat("MM/yyy").format(date);
  }

  static String replaceMaskDateForDatabase({required DateTime date}) {
    return DateFormat("yyy-MM-dd").format(date);
  }
}
