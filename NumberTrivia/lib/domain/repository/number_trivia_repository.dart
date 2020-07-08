
import 'package:NumberTrivia/core/error/failures.dart';
import 'package:NumberTrivia/domain/entities/number_trivia.dart';
import 'package:dartz/dartz.dart';

abstract class NumberTriviaRepository {
  Future<Either<NumberTrivia , Failures>> getRandomNumberTrivia();
  Future<Either<NumberTrivia , Failures>> getConcreteNumberTrivia(int number);
}