part of 'numbertrivia_bloc.dart';

abstract class NumbertriviaState extends Equatable {
  const NumbertriviaState();
}

class NumbertriviaInitial extends NumbertriviaState {
  @override
  List<Object> get props => [];
}

class Loading extends NumbertriviaState {
  @override
  List<Object> get props => [];
}

class Loaded extends NumbertriviaState {

  final NumberTrivia numberTrivia;

  Loaded(this.numberTrivia);

  @override
  List<Object> get props => [];
}

class Error extends NumbertriviaState{
  final String msg;
  Error(this.msg);

  @override
  List<Object> get props => [];

}

