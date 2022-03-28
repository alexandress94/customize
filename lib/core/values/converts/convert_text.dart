abstract class ConvertText {
  static double toDouble({required String value}) {
    return double.parse(value);
  }

  static int toInteger({required String value}) {
    return int.parse(value);
  }

  static DateTime toDate({required String value}) {
    return DateTime.parse(value);
  }
}
