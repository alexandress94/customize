import 'package:all_validations_br/all_validations_br.dart';

class ValidationImplementation {
  ValidationImplementation._instance();

  static String removeCharacter(String value) {
    return AllValidations.removeCharacters(value);
  }
}
