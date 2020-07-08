part of 'numbertrivia_bloc.dart';

abstract class NumbertriviaEvent extends Equatable {
  const NumbertriviaEvent();
}

class GetConcreteNumberTriviaEvent extends NumbertriviaEvent {
  final String number;

  GetConcreteNumberTriviaEvent(this.number);
  @override
  List<Object> get props => [number];  
}

class GetRandomNumberTriviaEvent extends NumbertriviaEvent {
  @override
  List<Object> get props => [];  
}