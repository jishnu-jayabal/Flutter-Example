import 'package:NumberTrivia/core/error/failures.dart';
import 'package:NumberTrivia/domain/entities/number_trivia.dart';
import 'package:NumberTrivia/domain/repository/number_trivia_repository.dart';
import 'package:NumberTrivia/domain/usecase/usecase.dart';

import 'package:dartz/dartz.dart';

class GetRandomNumberTrivia implements UsecCase {
  NumberTriviaRepository numberTriviaRepository;

  GetRandomNumberTrivia(this.numberTriviaRepository);

  @override
  Future<Either<NumberTrivia,Failures>> call() async{
    return this.numberTriviaRepository.getRandomNumberTrivia();
  }
}