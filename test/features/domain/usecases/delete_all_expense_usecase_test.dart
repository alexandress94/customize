import 'package:customize/core/errors/usecase_exception.dart';
import 'package:customize/features/domain/repositories/delete_all_expense_repository.dart';
import 'package:customize/features/domain/usecases/delete_all_expense_usecase.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../core/mock/expense_id.dart';
import '../../../core/mock/expense_uuid.dart';

class DeleteAllExpenseRepositoryMock extends Mock
    implements DeleteAllExpenseRepository {}

void main() {
  late DeleteAllExpenseUsecase sut;
  late DeleteAllExpenseRepository repository;

  setUp(() {
    repository = DeleteAllExpenseRepositoryMock();
    sut = DeleteAllExpenseUsecase(repository: repository);
  });

  group('Test delete all expense usecase:', () {
    test('Should be return success when the result for a right', () async {
      when(() => repository.deleteAll(uuId: tExpenseUuid)).thenAnswer(
        (_) async => Right<Exception, int>(
          tExpenseId,
        ),
      );

      final result = await sut.call(
        ParameterDeleteAllExpense(uuId: tExpenseUuid),
      );

      expect(result.isRight, true);
    });
    test('Should be return success when the result for a id', () async {
      when(() => repository.deleteAll(uuId: tExpenseUuid)).thenAnswer(
        (_) async => Right<Exception, int>(tExpenseId),
      );

      final result = await sut(
        ParameterDeleteAllExpense(uuId: tExpenseUuid),
      );

      expect(result.right, tExpenseId);
    });

    test('Should be return failure when the result for a left', () async {
      when(() => repository.deleteAll(uuId: tExpenseUuid)).thenAnswer(
        (_) async => Left<Exception, int>(UsecaseException.invalidInput()),
      );

      final result = await sut(
        ParameterDeleteAllExpense(uuId: tExpenseUuid),
      );

      expect(result.isLeft, true);
    });
  });
}
