import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../expense/controllers/insert_or_update_expense_controller.dart';

class TextFormFieldWidget extends GetView<InsertOrUpdateExpenseController> {
  final TextEditingController editingController;
  final int? maxLenght;
  final String? hint;

  final IconData icon;
  final List<TextInputFormatter>? inputMask;
  final TextInputType textInputType;
  final String? Function(String?) validator;

  const TextFormFieldWidget({
    Key? key,
    required this.editingController,
    this.maxLenght,
    this.hint,
    required this.icon,
    this.inputMask,
    required this.textInputType,
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: maxLenght,
      controller: editingController,
      keyboardType: textInputType,
      inputFormatters: inputMask,
      decoration: InputDecoration(
        hintText: hint,
      ),
      validator: validator,
    );
  }
}
