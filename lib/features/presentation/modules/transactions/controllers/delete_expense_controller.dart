import 'package:get/get.dart';
import 'package:organize_more/core/models/expense_dto.dart';

import 'package:organize_more/features/domain/usecases/delete_expense_usecase.dart';

import '../../../../../core/services/log/log.dart';
import '../../../../domain/usecases/delete_all_expense_usecase.dart';
import '../../../../domain/usecases/delete_between_expense_usecase.dart';
import '../../../routes/routes.dart';
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
  RxBool isLoading = false.obs;

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
    loaderListener(isLoading);
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
        deleteAll(expense.uuId);
        remove.value = Delete.delete_one;
        break;
    }
  }

  Future<void> delete(int id) async {
    isLoading.value = true;
    final result = await _deleteUsecase.call(ParameterDeleteExpense(id: id));
    isLoading.value = false;
    if (result.isLeft) {
      _log.error(result.left);
      Get.offAllNamed(Routes.ERROR_PAGE);
      message(MessageModel.error('Falha', result.left.toString()));
    }

    message(MessageModel.sucess('Finalizado', 'Deletado com sucesso!'));
  }

  Future<void> deleteBetween(ExpenseDto model) async {
    isLoading.value = true;
    final result = await _deleteBetweenUsecase.call(
      ParameterDeleteBetweenExpense(model: model.toMap()),
    );
    isLoading.value = false;

    if (result.isLeft) {
      _log.error(result.left);
      Get.offAllNamed(Routes.ERROR_PAGE);
      message(MessageModel.error('Falha', result.left.toString()));
    }

    message(MessageModel.sucess('Finalizado', 'Deletado com sucesso!'));
  }

  Future<void> deleteAll(String uuId) async {
    isLoading.value = true;
    final result = await _deleteAllUsecase.call(
      ParameterDeleteAllExpense(uuId: uuId),
    );
    isLoading.value = false;
    if (result.isLeft) {
      _log.error(result.left);
      Get.offAllNamed(Routes.ERROR_PAGE);
      message(MessageModel.error('Error', result.left.toString()));
    }

    message(MessageModel.sucess('Finalizado', 'Deletado com sucesso!'));
  }
}
