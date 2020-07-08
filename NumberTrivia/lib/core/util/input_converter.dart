import 'package:NumberTrivia/core/error/failures.dart';
import 'package:dartz/dartz.dart';

class InputConverter {
  Either<int,Failures> stringToUnsignedInteger(String num) {
    try {
      final value = int.parse(num);
      if(value < 0)  return Right(InputValidFailure());
      else return Left(value);
    } on FormatException {
      return Right(InputValidFailure());
    }
  }
}

class InputValidFailure extends Failures {}