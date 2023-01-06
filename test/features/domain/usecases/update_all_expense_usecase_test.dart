import 'package:customize/core/errors/usecase_exception.dart';
import 'package:customize/features/domain/repositories/update_all_expense_repository.dart';
import 'package:customize/features/domain/usecases/update_all_expense_usecase.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../core/mock/expense_id.dart';
import '../../../core/mock/update_expense.dart';

class UpdateAllExpenseRepositoryMock extends Mock
    implements UpdateAllExpenseRepository {}

void main() {
  late UpdateAllExpenseUsecase sut;
  late UpdateAllExpenseRepository repository;

  setUp(() {
    repository = UpdateAllExpenseRepositoryMock();
    sut = UpdateAllExpenseUsecase(repository: repository);
  });

  group('Test update all expense usecase:', () {
    test('Should be return success when the result for a right', () async {
      when(() => repository.updateAll(model: tUpdateExpenseModel)).thenAnswer(
        (_) async => Right<Exception, int>(
          tExpenseId,
        ),
      );

      final result = await sut.call(tUpdateExpenseParameter);

      expect(result.isRight, true);
    });
    test('Should be return success when the result for a id', () async {
      when(() => repository.updateAll(model: tUpdateExpenseModel)).thenAnswer(
        (_) async => Right<Exception, int>(tExpenseId),
      );

      final result = await sut(tUpdateExpenseParameter);

      expect(result.right, tExpenseId);
    });

    test('Should be return failure when the result for a left', () async {
      when(() => repository.updateAll(model: tUpdateExpenseModel)).thenAnswer(
        (_) async => Left<Exception, int>(UsecaseException.invalidInput()),
      );

      final result = await sut(tUpdateExpenseParameter);

      expect(result.isLeft, true);
    });
  });
}
