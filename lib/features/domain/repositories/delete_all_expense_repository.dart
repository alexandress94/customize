import 'package:either_dart/either.dart';

abstract class DeleteAllExpenseRepository {
  Future<Either<Exception, int>> deleteAll({required String uuId});
}
