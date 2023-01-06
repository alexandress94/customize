import 'package:customize/core/errors/usecase_exception.dart';
import 'package:customize/features/domain/entities/expense_entity.dart';
import 'package:customize/features/domain/repositories/get_all_expense_repository.dart';
import 'package:customize/features/domain/usecases/get_all_expense_usecase.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../core/mock/filter_date.dart';
import '../../../core/mock/list_expense_entity.dart';

class GetAllExpenseRepositoryMock extends Mock
    implements GetAllExpenseRepository {}

void main() {
  late GetAllExpenseUsecase sut;
  late GetAllExpenseRepository repository;

  setUp(() {
    repository = GetAllExpenseRepositoryMock();
    sut = GetAllExpenseUsecase(repository: repository);
  });

  group('Test get all expense usecase:', () {
    test('Should be return success when the result for a right', () async {
      when(() => repository.find(date: tFilterDate)).thenAnswer(
        (_) async => Right<Exception, List<ExpenseEntity>>(tListExpenseEntity),
      );

      final result = await sut(ParameterGetAllExpense(date: tFilterDate));

      expect(result.isRight, true);
    });
    test('Should be return success when the result for a list of expenses',
        () async {
      when(() => repository.find(date: tFilterDate)).thenAnswer(
        (_) async => Right<Exception, List<ExpenseEntity>>(tListExpenseEntity),
      );

      final result = await sut(ParameterGetAllExpense(date: tFilterDate));

      expect(result.right, tListExpenseEntity);
    });

    test('Should be return failure when the result for a left', () async {
      when(() => repository.find(date: tFilterDate)).thenAnswer(
        (_) async => Left<Exception, List<ExpenseEntity>>(
          UsecaseException.invalidInput(),
        ),
      );

      final result = await sut(ParameterGetAllExpense(date: tFilterDate));

      expect(result.isLeft, true);
    });
    test(
        'Should be return failure when the result for a parameter date is null',
        () async {
      when(() => repository.find(date: tFilterDate)).thenAnswer(
        (_) async => Left<Exception, List<ExpenseEntity>>(
          UsecaseException.invalidInput(),
        ),
      );

      final result = await sut(ParameterGetAllExpense(date: tFilterDate));

      expect(result.left, isA<UsecaseException>());
    });
  });
}
