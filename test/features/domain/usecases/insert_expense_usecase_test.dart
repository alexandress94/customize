import 'package:customize/core/errors/usecase_exception.dart';
import 'package:customize/features/domain/repositories/insert_expense_repository.dart';
import 'package:customize/features/domain/usecases/insert_expense_usecase.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../core/mock/expense_id.dart';
import '../../../core/mock/insert_expense.dart';

class InsertExpenseRepositoryMock extends Mock
    implements InsertExpenseRepository {}

void main() {
  late InsertExpenseUsecase sut;
  late InsertExpenseRepository repository;

  setUp(() {
    repository = InsertExpenseRepositoryMock();
    sut = InsertExpenseUsecase(repository: repository);
  });

  group('Test insert expense usecase:', () {
    test('Should be return success when the result for a right', () async {
      when(() => repository.insertExpense(expense: tInsertExpenseParameter))
          .thenAnswer(
        (_) async => Right<Exception, int>(tExpenseId),
      );

      final result = await sut.call(
        ParameterInsertExpense(expenses: tInsertExpenseParameter),
      );

      expect(result.isRight, true);
    });
    test('Should be return success when the result for a id', () async {
      when(() => repository.insertExpense(expense: tInsertExpenseParameter))
          .thenAnswer(
        (_) async => Right<Exception, int>(tExpenseId),
      );

      final result = await sut(
        ParameterInsertExpense(expenses: tInsertExpenseParameter),
      );

      expect(result.right, tExpenseId);
    });

    test('Should be return failure when the result for a left', () async {
      when(() => repository.insertExpense(expense: tInsertExpenseParameter))
          .thenAnswer(
        (_) async => Left<Exception, int>(UsecaseException.invalidInput()),
      );

      final result = await sut(
        ParameterInsertExpense(expenses: tInsertExpenseParameter),
      );

      expect(result.isLeft, true);
    });
  });
}
