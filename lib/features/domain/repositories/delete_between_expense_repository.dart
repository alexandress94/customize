import 'package:either_dart/either.dart';

abstract class DeleteBetweenExpenseRepository {
  Future<Either<Exception, int>> deleteBetween(
      {required Map<String, dynamic> model});
}
