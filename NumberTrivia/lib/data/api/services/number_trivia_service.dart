import 'dart:convert';

import 'package:NumberTrivia/core/error/exceptions.dart';
import 'package:NumberTrivia/data/api/models/number_trivia_model.dart';
import 'package:http/http.dart';

abstract class NumberTriviaService {
  Future<NumberTriviaModel> getRandomNumberTrivia();
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);
}

class NumberTriviaServiceImpl extends NumberTriviaService {

  Client httpClient;

  NumberTriviaServiceImpl(this.httpClient);
  
  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) async {
    final response = await httpClient
    .get(
      'http://numbersapi.com/$number',headers: {'Content-type': 'application/json'});
    if(response.statusCode == 200) {
      return Future.value(NumberTriviaModel.fromJson(json.decode(response.body)));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() async {
      final response = await httpClient
    .get(
      'http://numbersapi.com/random',headers: {'Content-type': 'application/json'});
    if(response.statusCode == 200) {
      return Future.value(NumberTriviaModel.fromJson(json.decode(response.body)));
    } else {
      throw ServerException();
    }
  }
  
}