import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controllers/insert_expense_controller.dart';

class TextFormFieldWidget extends GetView<InsertExpenseController> {
  final TextEditingController editingController;
  final String? label;
  final String? hint;
  // final String messageIsEmpty;
  final IconData icon;
  final List<TextInputFormatter>? inputMask;
  final TextInputType textInputType;
  final String? Function(String?) validator;

  const TextFormFieldWidget({
    Key? key,
    required this.editingController,
    this.label,
    this.hint,
    required this.icon,
    this.inputMask,
    required this.textInputType,
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: editingController,
      keyboardType: textInputType,
      inputFormatters: inputMask,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        icon: Icon(
          icon,
        ),
      ),
      validator: validator,
    );
  }
}
