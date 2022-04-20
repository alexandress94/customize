import 'package:organize_more/core/keys/guid_gen.dart';
import 'package:organize_more/core/models/expense_dto.dart';
import 'package:organize_more/core/values/format/format_date.dart';
import 'package:organize_more/core/values/format/format_weekday.dart';
import 'package:organize_more/features/domain/entities/expense_entity.dart';
import 'package:organize_more/features/domain/usecases/insert_expense_usecase.dart';

import 'package:organize_more/core/values/converts/convert_text.dart';
import 'package:organize_more/core/values/format/format_money.dart';
import 'package:organize_more/core/services/log/log.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../domain/usecases/update_expense_usecase.dart';
import '../../../routes/routes.dart';
import '../../../utils/loader_mixin.dart';
import '../../../utils/message_mixin.dart';
import '../../transactions/controllers/get_all_expense_controller.dart';

enum Portion {
  not,
  yeas,
}

class InsertOrUpdateExpenseController extends GetxController
    with LoaderMixin, MessageMixin {
  final getAllExpenseController = Get.find<GetAllExpenseController>();

  Portion installmentStatus = Portion.not;
  RxBool isRepeatSelected = false.obs;
  RxBool isSelectedPlot = false.obs;
  RxBool isSelectedYes = false.obs;
  RxString selectedItem = "Mensal".obs;
  Rx<DateTime> date = DateTime.now().obs;
  final Map<String, dynamic> arguments;
  Rxn<ExpenseEntity> expense = Rxn<ExpenseEntity>();

  final isLoading = false.obs;
  final message = Rxn<MessageModel>();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  final descriptionTextEditingController = TextEditingController();
  final moneyTextEditingController = TextEditingController(text: '0,00');
  final portionditingController = TextEditingController(text: '1');
  final TextEditingController dueDateController = TextEditingController();

  final InsertExpenseUsecase _insertExpenseUsecase;
  final UpdateExpenseUsecase _updateExpenseUsecase;
  final Log _log;

  InsertOrUpdateExpenseController({
    required InsertExpenseUsecase insertExpenseUsecase,
    required UpdateExpenseUsecase updateExpenseUsecase,
    required this.arguments,
    required Log log,
  })  : _insertExpenseUsecase = insertExpenseUsecase,
        _updateExpenseUsecase = updateExpenseUsecase,
        _log = log;

  GlobalKey<FormState> get getFormKey => _formkey;

  bool get isValidationForm => _formkey.currentState!.validate();

  @override
  onInit() {
    super.onInit();
    _setValueTextField();
    loaderListener(isLoading);
    messageListener(message);
  }

  String displayCurrentDayDescription() {
    String weekDay = FormatWeekday.descriptionWeekday(date.value);
    return "$weekDay Hoje";
  }

  void selectedDueDateCreateExpense() {
    String dateFormat = FormatDate.replaceMaskDate(date: date.value);
    String weekDay = FormatWeekday.descriptionWeekday(date.value);
    var now = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );

    var lastDay = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day - 1,
    );
    var nextDay = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day + 1,
    );

    if (date.value == now) {
      dueDateController.text = "$weekDay Hoje";
    } else if (date.value == lastDay) {
      dueDateController.text = "$weekDay Ontem";
    } else if (date.value == nextDay) {
      dueDateController.text = "$weekDay Amanhã ";
    } else {
      dueDateController.text = '$weekDay $dateFormat';
    }
  }

  void selectedDueDateUpdateExpense(DateTime dueDate) {
    String dateFormat = FormatDate.replaceMaskDate(date: dueDate);
    String weekDay = FormatWeekday.descriptionWeekday(dueDate);
    var now = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );

    var lastDay = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day - 1,
    );
    var nextDay = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day + 1,
    );

    if (dueDate == now) {
      dueDateController.text = "$weekDay Hoje";
    } else if (dueDate == lastDay) {
      dueDateController.text = "$weekDay Ontem";
    } else if (dueDate == nextDay) {
      dueDateController.text = "$weekDay Amanhã ";
    } else {
      dueDateController.text = '$weekDay $dateFormat';
    }
  }

  List<String> suggestionMenuItems = [
    'Diário',
    'Semanal',
    'Mensal',
    'Trimestre',
    'Semestre',
    'Anual',
  ];

  String? validatorMoney(String money) {
    if (FormatMoney.replaceMask(value: money) <= 0.0) {
      return "Valor obrigatório.";
    }
    return null;
  }

  String? validatorDescription(String description) {
    if (description.isEmpty) {
      return "Descrição obrigatório.";
    }
    return null;
  }

  String? validatorPortion(String installment) {
    if (installment.isEmpty) {
      return 'Parcela obrigatório.';
    } else if (ConvertText.toInteger(value: installment) == 0) {
      return 'Parcela não pode ser zero.';
    } else if (ConvertText.toInteger(value: installment) < 0) {
      return 'Parcela obrigatório.';
    } else if (ConvertText.toInteger(value: installment) > 99) {
      return 'Apenas parcelas menores que 100';
    }
    return null;
  }

  _setValueTextField() {
    if (arguments['ExpenseEntity'] != null) {
      final expense = arguments['ExpenseEntity'] as ExpenseEntity;
      descriptionTextEditingController.text = expense.description;
      moneyTextEditingController.text = FormatMoney.outputMask(
        expense.valueTransaction.toString(),
      ).replaceAll('R\$', '');
      selectedDueDateUpdateExpense(expense.dueDate);
      // dueDateController.text =
      //     '${FormatWeekday.descriptionWeekday(expense.dueDate)}'
      //     ' ${FormatDate.replaceMaskDate(date: expense.dueDate)}';

    } else {
      descriptionTextEditingController.clear();
      moneyTextEditingController.text = '0,00';
      dueDateController.text = displayCurrentDayDescription();
    }
  }

  void selectedNo(Portion? value) {
    installmentStatus = value!;
    isSelectedPlot.value = false;
    isSelectedYes.value = false;
    portionditingController.text = "1";
    selectedItem.value = "Mensalmente";
    update(['modified-plot']);
    update(['visibility-dropbuttom']);
  }

  void selectedYeas(Portion? value) {
    installmentStatus = value!;
    isSelectedPlot.value = true;
    isSelectedYes.value = true;
    update(['modified-plot']);
    update(['visibility-dropbuttom']);
  }

  DateTime _verifyItemSelected(int counter) {
    switch (selectedItem.value) {
      case "Diário":
        return DateTime(
            date.value.year, date.value.month, date.value.day + counter);
      case "Semanal":
        return DateTime(
            date.value.year, date.value.month, date.value.day + (7 * counter));
      case "Trimestre":
        return DateTime(
            date.value.year, date.value.month + (3 * counter), date.value.day);
      case "Semestre":
        return DateTime(
            date.value.year, date.value.month + (6 * counter), date.value.day);
      case "Anual":
        return DateTime(
            date.value.year, date.value.month + (12 * counter), date.value.day);
      default:
        return DateTime(
            date.value.year, date.value.month + counter, date.value.day);
    }
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

      final String uuId = GUIDGen.generate();

      for (int count = 0; count < portion; count++) {
        DateTime dueDate = _verifyItemSelected(count);

        final ExpenseDto _expense = ExpenseDto(
          uuId: uuId,
          description: descriptionTextEditingController.value.text,
          valueTransaction: money,
          installmentNumber: portion,
          amountInstallments: count + 1,
          isPayment: 0,
          isPortion: installmentStatus.index,
          transactionDate: DateTime.now(),
          dueDate: dueDate,
        );

        final result = await _insertExpenseUsecase(
          ParameterInsertExpense(
            expenses: _expense.toMap(),
          ),
        );
        if (result.isLeft) {
          _log.error(result.left);
          isLoading.value = false;
          Get.offAllNamed(Routes.ERROR_PAGE);
          message(MessageModel.error('Falha', result.left.toString()));
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

  Future<void> updateExpense() async {
    isLoading.value = true;
    if (isValidationForm) {
      final expense = arguments['ExpenseEntity'] as ExpenseEntity;
      double money = FormatMoney.replaceMask(
        value: moneyTextEditingController.value.text,
      );

      final result = await _updateExpenseUsecase.call(
        ParameterUpdateExpense(
          id: expense.id!,
          uuId: expense.uuId,
          description: descriptionTextEditingController.value.text,
          date: FormatDate.replaceMaskDateForDatabase(date: date.value),
          value: money,
        ),
      );

      isLoading.value = false;
      if (result.isLeft) {
        _log.error(result.left);
        Get.offAllNamed(Routes.ERROR_PAGE);
        message(MessageModel.error('Erro', result.left.toString()));
      }

      _log.debug(result.right);
      Get.back();
      message(MessageModel.sucess('Finalizado', 'Atualizado com sucesso'));
      await getAllExpenseController.find();
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
