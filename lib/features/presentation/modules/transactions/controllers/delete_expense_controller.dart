import 'package:get/get.dart';
import 'package:organize_more/core/models/expense_dto.dart';

import 'package:organize_more/features/domain/usecases/delete_expense_usecase.dart';

import '../../../../../core/services/log/log.dart';
import '../../../../domain/usecases/delete_all_expense_usecase.dart';
import '../../../../domain/usecases/delete_between_expense_usecase.dart';
import '../../../utils/loader_mixin.dart';
import '../../../utils/message_mixin.dart';

enum Delete {
  delete_one,
  delete_between,
  delete_all,
}

class DeleteExpenseController extends GetxController
    with LoaderMixin, MessageMixin {
  final DeleteExpenseUsecase _deleteUsecase;
  final DeleteBetweenExpenseUsecase _deleteBetweenUsecase;
  final DeleteAllExpenseUsecase _deleteAllUsecase;
  final Log _log;

  final message = Rxn<MessageModel>();

  DeleteExpenseController({
    required DeleteExpenseUsecase deleteUsecase,
    required DeleteBetweenExpenseUsecase deleteBetweenUsecase,
    required DeleteAllExpenseUsecase deleteAllUsecase,
    required Log log,
  })  : _deleteUsecase = deleteUsecase,
        _deleteBetweenUsecase = deleteBetweenUsecase,
        _deleteAllUsecase = deleteAllUsecase,
        _log = log;

  Rx<Delete> remove = Delete.delete_one.obs;

  @override
  onInit() {
    super.onInit();
    messageListener(message);
  }

  Future<void> deleteExpense(ExpenseDto expense) async {
    switch (remove.value) {
      case Delete.delete_one:
        await delete(expense.id!);
        remove.value = Delete.delete_one;
        break;
      case Delete.delete_between:
        await deleteBetween(expense);
        remove.value = Delete.delete_one;
        break;
      case Delete.delete_all:
        deleteAll(expense.uuId!);
        remove.value = Delete.delete_one;
        break;
    }
  }

  Future<void> delete(int id) async {
    final result = await _deleteUsecase.call(ParameterDeleteExpense(id: id));

    if (result.isLeft) {
      _log.error(result.left);
      message(MessageModel.error('Falha', result.left.toString()));
      return;
    }

    message(MessageModel.sucess('Finalizado', 'Deletado com sucesso!'));
  }

  Future<void> deleteBetween(ExpenseDto model) async {
    final result = await _deleteBetweenUsecase.call(
      ParameterDeleteBetweenExpense(model: model.toMap()),
    );

    if (result.isLeft) {
      _log.error(result.left);
      message(MessageModel.error('Falha', result.left.toString()));
      return;
    }

    message(MessageModel.sucess('Finalizado', 'Deletado com sucesso!'));
  }

  Future<void> deleteAll(String uuId) async {
    final result = await _deleteAllUsecase.call(
      ParameterDeleteAllExpense(uuId: uuId),
    );

    if (result.isLeft) {
      _log.error(result.left);
      message(MessageModel.sucess('Finalizado', 'Deletado com sucesso!'));
      return;
    }

    message(MessageModel.sucess('Finalizado', 'Deletado com sucesso!'));
  }
}