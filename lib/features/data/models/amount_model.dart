import 'package:customize/features/domain/entities/amount_entity.dart';

class AmountModel extends AmountEntity {
  AmountModel({
    required double values,
  }) : super(
          values: values,
        );

  factory AmountModel.fromMap(Map<String, dynamic> map) {
    return AmountModel(
      values: map['vl_transaction'] ?? 0.0,
    );
  }

  @override
  String toString() {
    return 'AmountModel{values: $values}';
  }
}
