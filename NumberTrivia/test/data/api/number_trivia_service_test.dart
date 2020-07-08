import 'dart:convert';

import 'package:NumberTrivia/core/error/exceptions.dart';
import 'package:NumberTrivia/data/api/models/number_trivia_model.dart';
import 'package:NumberTrivia/data/api/services/number_trivia_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  MockHttpClient mockHttp;
  NumberTriviaServiceImpl numberTriviaService;

  setUp(() {
    mockHttp = MockHttpClient();
    numberTriviaService = NumberTriviaServiceImpl(mockHttp);
  });

  void setMockHttpClient200() {
    when(mockHttp.get(any, headers: anyNamed('headers'))).thenAnswer(
        (realInvocation) async => http.Response(fixture('trivia.json'), 200));
  }

  void setMockHttpClient404() {
    when(mockHttp.get(any, headers: anyNamed('headers'))).thenAnswer(
        (realInvocation) async => http.Response(" SOmething went wrong", 404));
  }

  group("getConcreteNumberTrivia", () {
    final tNumber = 1;
    final tNumberModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));
    test("should perform a GET Request on a url with number being the endpoint",
        () async {
      setMockHttpClient200();
      numberTriviaService.getConcreteNumberTrivia(tNumber);
      verify(mockHttp.get('http://numbersapi.com/$tNumber',
          headers: {'Content-type': 'application/json'}));
    });

    test("should return number trivia when response code is 200", () async {
      setMockHttpClient200();
      final result = await numberTriviaService.getConcreteNumberTrivia(tNumber);
      expect(result, tNumberModel);
    });

    test("should throw ServerException if status 404", () async {
      setMockHttpClient404();
      final call = numberTriviaService.getConcreteNumberTrivia;
      expect(() => call(tNumber), throwsA(isInstanceOf<ServerException>()));
    });
  });

   group("getRandomNumberTrivia", () {

    final tNumberModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));
    test("should perform a GET Request on a url with number being the endpoint",
        () async {
      setMockHttpClient200();
      numberTriviaService.getRandomNumberTrivia();
      verify(mockHttp.get('http://numbersapi.com/random',
          headers: {'Content-type': 'application/json'}));
    });

    test("should return number trivia when response code is 200", () async {
      setMockHttpClient200();
      final result = await numberTriviaService.getRandomNumberTrivia();
      expect(result, tNumberModel);
    });

    test("should throw ServerException if status 404", () async {
      setMockHttpClient404();
      final call = numberTriviaService.getRandomNumberTrivia;
      expect(() => call(), throwsA(isInstanceOf<ServerException>()));
    });
  });
}
