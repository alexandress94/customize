import 'package:intl/intl.dart';
import 'package:organize_more/core/values/converts/convert_text.dart';

abstract class FormatMoney {
  static double replaceMask({required String value}) {
    return ConvertText.toDouble(
      value: value.replaceAll('.', '').replaceAll(',', '.'),
    );
  }

  static String outputMask(String value) {
    NumberFormat formatter = NumberFormat.simpleCurrency(locale: 'pt_BR');
    double formatvalue = double.parse(value);
    return formatter.format(formatvalue);
  }
}
