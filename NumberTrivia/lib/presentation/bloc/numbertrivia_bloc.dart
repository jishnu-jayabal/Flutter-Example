import 'dart:async';

import 'package:NumberTrivia/core/error/failures.dart';
import 'package:NumberTrivia/core/util/input_converter.dart';
import 'package:NumberTrivia/domain/entities/number_trivia.dart';
import 'package:NumberTrivia/domain/usecase/get_concrete_number_trivia.dart';
import 'package:NumberTrivia/domain/usecase/get_random_number_trivia.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'numbertrivia_event.dart';
part 'numbertrivia_state.dart';

const String SERVER_FAILURE_MESSAGE = "Server Failure";
const String CACHE_FAILURE_MESSAGE = "Cache Failure";
const String INVALID_INPUT_FAILURE_MESSAGE = "The number should be positive message or zero";

class NumbertriviaBloc extends Bloc<NumbertriviaEvent, NumbertriviaState> {


  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;

  NumbertriviaBloc(this.getConcreteNumberTrivia, this.getRandomNumberTrivia, this.inputConverter) : super(NumbertriviaInitial());

  @override
  Stream<NumbertriviaState> mapEventToState(
    NumbertriviaEvent event,
  ) async* {
    if(event is GetConcreteNumberTriviaEvent) {
      final either = inputConverter.stringToUnsignedInteger(event.number);
      yield* either.fold((integer) async* {
       yield Loading();
       final failureorTrivia = await getConcreteNumberTrivia(number: integer);
       yield* _eitherLoadedOrErrorState(failureorTrivia);
      }, (r) async* { yield Error(INVALID_INPUT_FAILURE_MESSAGE);});
    } else if(event is GetRandomNumberTriviaEvent) {
      yield Loading();
       final failureorTrivia = await getRandomNumberTrivia();
       yield* _eitherLoadedOrErrorState(failureorTrivia);
    }
  }

  Stream<NumbertriviaState> _eitherLoadedOrErrorState(Either<NumberTrivia,Failures> failureorTrivia) async* {
     yield failureorTrivia.fold((trivia) => Loaded(trivia), (failure) => Error(_mapFailureToMessage(failure)) );
  }
  String _mapFailureToMessage(Failures failures) {
    switch(failures.runtimeType) {
      case ServerFailure: return SERVER_FAILURE_MESSAGE;
      case CacheFailure: return CACHE_FAILURE_MESSAGE;
      default: return "UNEXPECTED_ERROR";
    }

  }
}
