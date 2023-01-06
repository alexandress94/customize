import 'package:customize/features/data/datasources/update_all_expense_datasource.dart';
import 'package:customize/features/data/repositories/update_all_expense_repository_implementation.dart';
import 'package:customize/features/domain/repositories/update_all_expense_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../core/mock/expense_id.dart';
import '../../../core/mock/update_expense.dart';

class UpdateAllExpenseDatasourceMock extends Mock
    implements UpdateAllExpenseDatasource {}

void main() {
  late UpdateAllExpenseRepository sut;
  late UpdateAllExpenseDatasource datasource;

  setUp(() {
    datasource = UpdateAllExpenseDatasourceMock();
    sut = UpdateAllExpenseRepositoryImplementation(datasource: datasource);
  });

  group('Test delete all expense repository:', () {
    test('Should be return success when the result for a right', () async {
      when(() => datasource.updateAll(model: tUpdateExpenseModel)).thenAnswer(
        (_) async => tExpenseId,
      );

      final result = await sut.updateAll(model: tUpdateExpenseModel);

      expect(result.isRight, true);
    });
    test('Should be return success when the result for a id', () async {
      when(() => datasource.updateAll(model: tUpdateExpenseModel)).thenAnswer(
        (_) async => tExpenseId,
      );

      final result = await sut.updateAll(model: tUpdateExpenseModel);

      expect(result.right, tExpenseId);
    });
  });
}
