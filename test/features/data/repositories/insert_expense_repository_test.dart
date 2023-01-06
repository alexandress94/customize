import 'package:customize/features/data/datasources/insert_expense_datasource.dart';
import 'package:customize/features/data/repositories/insert_expense_repository_implementation.dart';
import 'package:customize/features/domain/repositories/insert_expense_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../core/mock/expense_id.dart';
import '../../../core/mock/insert_expense.dart';

class InsertExpenseDatasourceMock extends Mock
    implements InsertExpenseDatasource {}

void main() {
  late InsertExpenseRepository sut;
  late InsertExpenseDatasource datasource;

  setUp(() {
    datasource = InsertExpenseDatasourceMock();
    sut = InsertExpenseRepositoryImplementation(datasource: datasource);
  });

  group('Test insert expense repository:', () {
    test('Should be return success when the result for a right', () async {
      when(() => datasource.insertExpense(model: tInsertExpenseParameter))
          .thenAnswer((_) async => tExpenseId);

      final result = await sut.insertExpense(expense: tInsertExpenseParameter);

      expect(result.isRight, true);
    });
    test('Should be return success when the result for a id', () async {
      when(() => datasource.insertExpense(model: tInsertExpenseParameter))
          .thenAnswer((_) async => tExpenseId);

      final result = await sut.insertExpense(expense: tInsertExpenseParameter);

      expect(result.right, tExpenseId);
    });
  });
}
