import 'package:NumberTrivia/core/error/failures.dart';
import 'package:NumberTrivia/domain/entities/number_trivia.dart';
import 'package:NumberTrivia/domain/repository/number_trivia_repository.dart';
import 'package:NumberTrivia/domain/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

class GetConcreteNumberTrivia implements UsecCase {
  NumberTriviaRepository numberTriviaRepository;

  GetConcreteNumberTrivia(this.numberTriviaRepository);

  @override
  Future<Either<NumberTrivia,Failures>> call({
    @required int number
  }) async{
    return this.numberTriviaRepository.getConcreteNumberTrivia(number);
  }
}