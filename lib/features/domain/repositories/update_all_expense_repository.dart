import 'package:either_dart/either.dart';

abstract class UpdateAllExpenseRepository {
  Future<Either<Exception, int>> updateAll(
      {required Map<String, dynamic> model});
}
