import 'package:get/get.dart';
import 'package:organize_more/features/domain/usecases/delete_expense_usecase.dart';
import 'package:organize_more/features/presentation/utils/show_snackbar.dart';

import '../../../../../core/services/log/log.dart';

class DeleteExpenseController extends GetxController {
  final DeleteExpenseUsecase _usecase;
  final Log _log;

  DeleteExpenseController({
    required DeleteExpenseUsecase usecase,
    required Log log,
  })  : _usecase = usecase,
        _log = log;

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
