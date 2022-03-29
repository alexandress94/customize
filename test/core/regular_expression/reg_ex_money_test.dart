import 'package:flutter_test/flutter_test.dart';
import 'package:organize_more/core/values/regular_expression/reg_ex_money.dart';

void main() {
  const validMoney = '20000';
  const validMoneyWithDecimal = '200.00';
  const invalidMoneyWithCharacter = 'a220.00';
  const invalidMoneyWithMask = 'R\$ 220.00';
  const invalidMoneyFormat = '0.220.00';

  group('Money: ', () {
    test('Expected return valid money with decimal', () {
      expect(RegExMoney.isMoney(validMoneyWithDecimal), true);
    });
    test('Expected return valid money', () {
      expect(RegExMoney.isMoney(validMoney), true);
    });
    test('Expected return failure money with input character', () {
      expect(RegExMoney.isMoney(invalidMoneyWithCharacter), false);
    });
    test('Expected return failure money with mask', () {
      expect(RegExMoney.isMoney(invalidMoneyWithMask), false);
    });
    test('Expected return failure money', () {
      expect(RegExMoney.isMoney(invalidMoneyFormat), false);
    });
  });
}
