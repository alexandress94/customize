import 'package:either_dart/either.dart';

abstract class Usecase<Output, Input> {
  Future<Either<Exception, Output>> call(Input parameter);
}

class NoParameter {}
