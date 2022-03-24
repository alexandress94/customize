import 'package:get/get.dart';
import 'package:organize_more/features/domain/entities/expense_entity.dart';
import 'package:organize_more/features/domain/usecases/delete_expense_usecase.dart';
import 'package:organize_more/features/presentation/utils/show_snackbar.dart';

import '../../../../../core/services/log/log.dart';

enum Delete {
  delete_one,
  delete_between,
  delete_all,
}

class DeleteExpenseController extends GetxController {
  final DeleteExpenseUsecase _usecase;
  final Log _log;

  DeleteExpenseController({
    required DeleteExpenseUsecase usecase,
    required Log log,
  })  : _usecase = usecase,
        _log = log;

  Rx<Delete> remove = Delete.delete_one.obs;

  Future<void> deleteExpense(ExpenseEntity expense) async {
    switch (remove.value) {
      case Delete.delete_one:
        await delete(expense.id!);
        remove.value = Delete.delete_one;
        break;
      case Delete.delete_between:
        print('delete between');
        remove.value = Delete.delete_one;
        break;
      case Delete.delete_all:
        print('Delete all');
        remove.value = Delete.delete_one;
        break;
    }
  }

  Future<void> delete(int id) async {
    final result = await _usecase.call(ParameterDeleteExpense(id: id));

    if (result.isLeft) {
      _log.error(result.left);
      showSnackBar(
        resopnse: StatusNotification.ERROR,
        message: result.left.toString(),
      );
      return;
    }

    showSnackBar(
      resopnse: StatusNotification.SUCCESS,
      message: 'Deletado com sucesso.',
    );
  }
}
