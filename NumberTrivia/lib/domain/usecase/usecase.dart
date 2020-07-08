import 'package:NumberTrivia/core/error/failures.dart';
import 'package:dartz/dartz.dart';

abstract class UsecCase<Type,Params>{
  Future<Either<Type,Failures>> call();
}