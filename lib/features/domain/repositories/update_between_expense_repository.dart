import 'package:either_dart/either.dart';

abstract class UpdateBetweenExpenseRepository {
  Future<Either<Exception, int>> updateBetween(
      {required Map<String, dynamic> model});
}
