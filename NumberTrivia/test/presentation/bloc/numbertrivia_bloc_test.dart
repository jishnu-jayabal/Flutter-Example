import 'package:NumberTrivia/core/error/failures.dart';
import 'package:NumberTrivia/core/util/input_converter.dart';
import 'package:NumberTrivia/domain/entities/number_trivia.dart';
import 'package:NumberTrivia/domain/usecase/get_concrete_number_trivia.dart';
import 'package:NumberTrivia/domain/usecase/get_random_number_trivia.dart';
import 'package:NumberTrivia/presentation/bloc/numbertrivia_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockGetConcreteNumberTrivia extends Mock
    implements GetConcreteNumberTrivia {}

class MockGetRandomNumberTrivia extends Mock implements GetRandomNumberTrivia {}

class MockInputConverter extends Mock implements InputConverter {}

void main() {
  MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  MockInputConverter mockInputConverter;
  NumbertriviaBloc bloc;

  setUp(() {
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockInputConverter = MockInputConverter();

    bloc = NumbertriviaBloc(mockGetConcreteNumberTrivia,
      mockGetRandomNumberTrivia, mockInputConverter);
  });

  test("Initial State should be NumberTriviaInitial()", () {
    expect(bloc.state, NumbertriviaInitial());
  });

  group("GetConcreteNumberTriviaEvent", () {
    final tNumber = 1;
    final tNumberStr = '1';
    final tNumberTrivia = NumberTrivia(text: "test trivia", number: 1);

    blocTest(
        "Should Call InputNumberConverter to validate and convert the string to unsigned integer",
        build: () async {
          when(mockInputConverter.stringToUnsignedInteger(any))
              .thenReturn(Left(tNumber));
                when(mockGetConcreteNumberTrivia(number: anyNamed("number")))
          .thenAnswer((realInvocation) async => Left(tNumberTrivia));
              return bloc;
        },
        act: (bloc) => bloc.add(GetConcreteNumberTriviaEvent(tNumberStr)),
        verify: (_) async {
          verify(mockInputConverter.stringToUnsignedInteger(tNumberStr))
              .called(1);
        });

    blocTest(
        
        "should emit [Error] when input is invalid",
        build: () async {
          when(mockInputConverter.stringToUnsignedInteger(any))
              .thenReturn(Right(InputValidFailure()));
              return bloc;
        },
        act: (bloc) => bloc.add(GetConcreteNumberTriviaEvent(tNumberStr)),
        expect: [Error(INVALID_INPUT_FAILURE_MESSAGE)],
      );

      blocTest(
        "should get data from the concrete use case",
        build: () async {
          when(mockInputConverter.stringToUnsignedInteger(any))
              .thenReturn(Left(tNumber));
          when(mockGetConcreteNumberTrivia(number: anyNamed("number")))
          .thenAnswer((realInvocation) async => Left(tNumberTrivia));
              return bloc;
        },
        act: (bloc) => bloc.add(GetConcreteNumberTriviaEvent(tNumberStr)),
        verify: (_) async{
          verify(mockGetConcreteNumberTrivia(number: tNumber));
        }
      );
      blocTest(
        "should emit [Loading() , Loaded()] when data is gotten successfully",
        build: () async {
          when(mockInputConverter.stringToUnsignedInteger(any))
              .thenReturn(Left(tNumber));
             when(mockGetConcreteNumberTrivia(number: anyNamed("number")))
          .thenAnswer((realInvocation) async => Left(tNumberTrivia));
              return bloc;
        },
        act: (bloc) => bloc.add(GetConcreteNumberTriviaEvent(tNumberStr)),
        expect: [Loading() , Loaded(tNumberTrivia)],
        verify: (_) async{
          verify(mockGetConcreteNumberTrivia(number: tNumber));
        }
      );

      blocTest(
        "should emit [Loading() , Error()] when fetching data fails",
        build: () async {
          when(mockInputConverter.stringToUnsignedInteger(any))
              .thenReturn(Left(tNumber));
             when(mockGetConcreteNumberTrivia(number: anyNamed("number")))
          .thenAnswer((realInvocation) async => Right(ServerFailure()));
              return bloc;
        },
        act: (bloc) => bloc.add(GetConcreteNumberTriviaEvent(tNumberStr)),
        expect: [Loading() , Error(SERVER_FAILURE_MESSAGE)],
        verify: (_) async{
          verify(mockGetConcreteNumberTrivia(number: tNumber));
        }
      );

      blocTest(
        "should emit [Loading() , Error()] when fetching data from cache fails",
        build: () async {
          when(mockInputConverter.stringToUnsignedInteger(any))
              .thenReturn(Left(tNumber));
             when(mockGetConcreteNumberTrivia(number: anyNamed("number")))
          .thenAnswer((realInvocation) async => Right(CacheFailure()));
              return bloc;
        },
        act: (bloc) => bloc.add(GetConcreteNumberTriviaEvent(tNumberStr)),
        expect: [Loading() , Error(CACHE_FAILURE_MESSAGE)],
        verify: (_) async{
          verify(mockGetConcreteNumberTrivia(number: tNumber));
        }
      );

  });



  group("GetRandomNumberTriviaEvent", () {
    final tNumberTrivia = NumberTrivia(text: "test trivia", number: 1);

      blocTest(
        "should get data from the concrete use case",
        build: () async {
          when(mockGetRandomNumberTrivia())
          .thenAnswer((realInvocation) async => Left(tNumberTrivia));
              return bloc;
        },
        act: (bloc) => bloc.add(GetRandomNumberTriviaEvent()),
        verify: (_) async{
          verify(mockGetRandomNumberTrivia());
        }
      );
      blocTest(
        "should emit [Loading() , Loaded()] when data is gotten successfully",
        build: () async {
          when(mockGetRandomNumberTrivia())
          .thenAnswer((realInvocation) async => Left(tNumberTrivia));
              return bloc;
        },
        act: (bloc) => bloc.add(GetRandomNumberTriviaEvent()),
        expect: [Loading() , Loaded(tNumberTrivia)],
        verify: (_) async{
          verify(mockGetRandomNumberTrivia());
        }
      );

      blocTest(
        "should emit [Loading() , Error()] when fetching data fails",
        build: () async {
             when(mockGetRandomNumberTrivia())
          .thenAnswer((realInvocation) async => Right(ServerFailure()));
              return bloc;
        },
        act: (bloc) => bloc.add(GetRandomNumberTriviaEvent()),
        expect: [Loading() , Error(SERVER_FAILURE_MESSAGE)],
        verify: (_) async{
          verify(mockGetRandomNumberTrivia());
        }
      );

      blocTest(
        "should emit [Loading() , Error()] when fetching data from cache fails",
        build: () async {
            when(mockGetRandomNumberTrivia())
          .thenAnswer((realInvocation) async => Right(CacheFailure()));
              return bloc;
        },
        act: (bloc) => bloc.add(GetRandomNumberTriviaEvent()),
        expect: [Loading() , Error(CACHE_FAILURE_MESSAGE)],
        verify: (_) async{
          verify(mockGetRandomNumberTrivia());
        }
      );

  });
}
