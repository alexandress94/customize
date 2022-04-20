class FormatWeekday {
  FormatWeekday._instance();

  static String descriptionWeekday(DateTime date) {
    switch (date.weekday) {
      case 1:
        return "Seg,";
      case 2:
        return "Ter,";
      case 3:
        return "Qua,";
      case 4:
        return "Qui,";
      case 5:
        return "Sex,";
      case 6:
        return "Sáb,";
      case 7:
        return "Dom,";
      default:
        return "Não definido";
    }
  }
}
