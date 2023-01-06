import 'package:customize/features/data/datasources/delete_all_expense_datasource.dart';
import 'package:customize/features/data/repositories/delete_all_expense_repository_implementation.dart';
import 'package:customize/features/domain/repositories/delete_all_expense_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../core/mock/expense_id.dart';
import '../../../core/mock/expense_uuid.dart';

class DeleteAllExpenseDatasourceMock extends Mock
    implements DeleteAllExpenseDatasource {}

void main() {
  late DeleteAllExpenseRepository sut;
  late DeleteAllExpenseDatasource datasource;

  setUp(() {
    datasource = DeleteAllExpenseDatasourceMock();
    sut = DeleteAllExpenseRepositoryImplementation(datasource: datasource);
  });

  group('Test delete all expense repository:', () {
    test('Should be return success when the result for a right', () async {
      when(() => datasource.deleteAll(uuId: tExpenseUuid)).thenAnswer(
        (_) async => tExpenseId,
      );

      final result = await sut.deleteAll(uuId: tExpenseUuid);

      expect(result.isRight, true);
    });
    test('Should be return success when the result for a id', () async {
      when(() => datasource.deleteAll(uuId: tExpenseUuid)).thenAnswer(
        (_) async => tExpenseId,
      );

      final result = await sut.deleteAll(uuId: tExpenseUuid);

      expect(result.right, tExpenseId);
    });
  });
}
