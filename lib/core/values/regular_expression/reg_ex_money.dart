abstract class RegExMoney {
  static bool isMoney(String input) {
    return RegExp(
      '^[+-]?[0-9]{1,3}(?:[0-9]*(?:[.,][0-9]{2})?|(?:,[0-9]{3})*(?:\.[0-9]{2})?|(?:\.[0-9]{3})*(?:,[0-9]{2})?)\$',
    ).hasMatch(input);
  }
}
