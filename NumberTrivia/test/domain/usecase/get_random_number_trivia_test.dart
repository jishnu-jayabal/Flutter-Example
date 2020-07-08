import 'package:NumberTrivia/domain/entities/number_trivia.dart';
import 'package:NumberTrivia/domain/repository/number_trivia_repository.dart';
import 'package:NumberTrivia/domain/usecase/get_random_number_trivia.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockNumberTriviaRepository extends Mock implements NumberTriviaRepository {}

void main() {
  NumberTriviaRepository numberTriviaRepository;
  GetRandomNumberTrivia usecase;

  setUp(() {
    numberTriviaRepository = MockNumberTriviaRepository();
    usecase = new GetRandomNumberTrivia(numberTriviaRepository);
  });

  final tNumberTrivia = NumberTrivia(number: 1, text: "test");

  test("Should Get Random Number Trivia from service", () async {
    //arange
    when(numberTriviaRepository.getRandomNumberTrivia())
        .thenAnswer((_) async => Left(tNumberTrivia));

    //act
    final result = await usecase();

    //assert
    expect(result, Left(tNumberTrivia));
    verify(numberTriviaRepository.getRandomNumberTrivia());
    verifyNoMoreInteractions(numberTriviaRepository);
  });
}
