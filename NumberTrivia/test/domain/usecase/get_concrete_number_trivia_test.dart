import 'package:NumberTrivia/domain/entities/number_trivia.dart';
import 'package:NumberTrivia/domain/repository/number_trivia_repository.dart';
import 'package:NumberTrivia/domain/usecase/get_concrete_number_trivia.dart';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockNumberTriviaRepository extends Mock implements NumberTriviaRepository {}

void main() {
  NumberTriviaRepository numberTriviaRepository;
  GetConcreteNumberTrivia usecase;

  setUp(() {
    numberTriviaRepository = MockNumberTriviaRepository();
    usecase = new GetConcreteNumberTrivia(numberTriviaRepository);
  });

  final tNumber = 1;
  final tNumberTrivia = NumberTrivia(number: 1, text: "test");

  test("Should Get Concrete Number Trivia from service", () async {
    //arange
    when(numberTriviaRepository.getConcreteNumberTrivia(any))
        .thenAnswer((_) async => Left(tNumberTrivia));

    //act
    final result = await usecase(number: tNumber);

    //assert
    expect(result, Left(tNumberTrivia));
    verify(numberTriviaRepository.getConcreteNumberTrivia(tNumber));
    verifyNoMoreInteractions(numberTriviaRepository);
  });
}
