import 'package:organize_more/core/keys/guid_gen.dart';
import 'package:organize_more/core/models/expense_dto.dart';
import 'package:organize_more/features/domain/usecases/insert_expense_usecase.dart';

import 'package:organize_more/core/values/converts/convert_text.dart';
import 'package:organize_more/core/values/format/format_money.dart';
import 'package:organize_more/core/services/log/log.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/loader_mixin.dart';
import '../../../utils/message_mixin.dart';
import 'get_all_expense_controller.dart';

enum Portion {
  not,
  yeas,
}

class InsertExpenseController extends GetxController
    with LoaderMixin, MessageMixin {
  final getAllExpenseController = Get.find<GetAllExpenseController>();
  Portion installmentStatus = Portion.not;
  RxBool isRepeatSelected = false.obs;
  RxBool isSelectedPlot = false.obs;
  DateTime _date = DateTime.now();

  final isLoading = false.obs;
  final message = Rxn<MessageModel>();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final descriptionTextEditingController = TextEditingController();
  final moneyTextEditingController = TextEditingController(text: '0,00');
  final portionditingController = TextEditingController(text: '1');

  final InsertExpenseUsecase _usecase;
  final Log _log;

  InsertExpenseController({
    required InsertExpenseUsecase usecase,
    required Log log,
  })  : _usecase = usecase,
        _log = log;

  DateTime get getSelectedDate => _date;

  GlobalKey<FormState> get getFormKey => _formkey;

  bool get isValidationForm => _formkey.currentState!.validate();

  @override
  onInit() {
    super.onInit();
    loaderListener(isLoading);
    messageListener(message);
  }

  set setSelectedDate(DateTime date) {
    _date = date;
    update(['selected-date']);
  }

  void selectedNo(Portion? value) {
    installmentStatus = value!;
    isSelectedPlot.value = false;
    portionditingController.text = "1";
    update(['modified-plot']);
  }

  void selectedYeas(Portion? value) {
    installmentStatus = value!;
    isSelectedPlot.value = true;
    update(['modified-plot']);
  }

  Future<void> insertExpense() async {
    isLoading.value = true;
    if (isValidationForm) {
      int portion = ConvertText.toInteger(
        value: portionditingController.value.text,
      );

      double money = FormatMoney.replaceMask(
        value: moneyTextEditingController.value.text,
      );

      final String? uuId =
          installmentStatus.index == 1 ? GUIDGen.generate() : null;

      for (int count = 0; count < portion; count++) {
        final ExpenseDto _expense = ExpenseDto(
          uuId: uuId,
          description: descriptionTextEditingController.value.text,
          valueTransaction: money,
          installmentNumber: portion,
          amountInstallments: count + 1,
          isPayment: 0,
          isPortion: installmentStatus.index,
          transactionDate: DateTime.now(),
          dueDate: DateTime(
            getSelectedDate.year,
            getSelectedDate.month + count,
            getSelectedDate.day,
          ),
        );

        final result = await _usecase(
          ParameterInsertExpense(
            expenses: _expense.toMap(),
          ),
        );
        if (result.isLeft) {
          _log.error(result.left);
          isLoading.value = false;
          message(MessageModel.error('Falha', result.left.toString()));
          return;
        }
        _log.debug(result.right);
      }

      await getAllExpenseController.find();
      isLoading.value = false;
      _clearTextField();
      Get.back();
      message(MessageModel.sucess('Sucesso', 'Cadastro realizado!'));
    } else {
      isLoading.value = false;
      message(MessageModel.info('Falha', 'Verifique as críticas.'));
    }
  }

  void _clearTextField() {
    descriptionTextEditingController.clear();
    moneyTextEditingController.clear();
    portionditingController.clear();
  }

  @override
  void onClose() {
    descriptionTextEditingController.dispose();
    moneyTextEditingController.dispose();
    portionditingController.dispose();
    super.onClose();
  }
}