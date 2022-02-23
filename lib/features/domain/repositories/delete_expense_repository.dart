import 'package:either_dart/either.dart';

abstract class DeleteExpenseRepository {
  Future<Either<Exception, int>> delete({required int id});
}
