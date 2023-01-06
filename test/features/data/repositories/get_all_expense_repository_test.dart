import 'package:customize/features/data/datasources/get_all_expense_datasource.dart';
import 'package:customize/features/data/models/expense_model.dart';
import 'package:customize/features/data/repositories/get_all_expense_repository_implementation.dart';
import 'package:customize/features/domain/repositories/get_all_expense_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../core/mock/filter_date.dart';
import '../../../core/mock/list_expense_model.dart';

class GetAllExpenseDatasourceMock extends Mock
    implements GetAllExpenseDatasource {}

void main() {
  late GetAllExpenseRepository sut;
  late GetAllExpenseDatasource datasource;

  setUp(() {
    datasource = GetAllExpenseDatasourceMock();
    sut = GetAllExpenseRepositoryImplementation(datasource: datasource);
  });

  group('Test insert expense repository:', () {
    test('Should be return success when the result for a right', () async {
      var model = tListExpenseModel
          .map((transactions) => ExpenseModel.fromMap(transactions))
          .toList();
      when(() => datasource.find(date: tFilterDate)).thenAnswer(
        (_) async => model,
      );

      final result = await sut.find(date: tFilterDate);

      expect(result.isRight, true);
    });
    test('Should be return success when the result for a id', () async {
      var model = tListExpenseModel
          .map((transactions) => ExpenseModel.fromMap(transactions))
          .toList();

      when(() => datasource.find(date: tFilterDate))
          .thenAnswer((_) async => model);

      final result = await sut.find(date: tFilterDate);

      expect(result.right, model);
    });
  });
}
