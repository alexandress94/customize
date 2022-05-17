import 'package:customize/core/values/format/format_date.dart';

class Concatenate {
  late String _concatenateFirstDayOfMonthAndYear;
  late String _concatenateLastDayOfMonthAndYear;

  set selectedDate(DateTime date) {
    _initialFilter(selectedDate: date);
    _endFilter(selectedDate: date);
  }

  void _initialFilter({required DateTime selectedDate}) {
    final first = DateTime(selectedDate.year, selectedDate.month, 1);
    DateTime date = DateTime(selectedDate.year, selectedDate.month, first.day);
    _concatenateFirstDayOfMonthAndYear = FormatDate.replaceMaskDateForDatabase(
      date: date,
    );
  }

  void _endFilter({required DateTime selectedDate}) {
    final last = DateTime(selectedDate.year, selectedDate.month + 1, 0);
    DateTime date = DateTime(selectedDate.year, selectedDate.month, last.day);
    _concatenateLastDayOfMonthAndYear = FormatDate.replaceMaskDateForDatabase(
      date: date,
    );
  }

  String get lastDayOfMonthAndYear => _concatenateLastDayOfMonthAndYear;
  String get firstDayOfMonthAndYear => _concatenateFirstDayOfMonthAndYear;
}
