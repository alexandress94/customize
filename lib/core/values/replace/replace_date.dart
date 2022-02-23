class DescriptionCalendarDate {
  static String parameter({required DateTime date}) {
    switch (date.month) {
      case 1:
        return "JAN/${date.year}";
      case 2:
        return "FEV/${date.year}";
      case 3:
        return "MAR/${date.year}";
      case 4:
        return "ABR/${date.year}";
      case 5:
        return "MAI/${date.year}";
      case 6:
        return "JUN/${date.year}";
      case 7:
        return "JUL/${date.year}";
      case 8:
        return "AGO/${date.year}";
      case 9:
        return "SET/${date.year}";
      case 10:
        return "OUT/${date.year}";
      case 11:
        return "NOV/${date.year}";
      case 12:
        return "DEZ/${date.year}";
      default:
        return "";
    }
  }
}
