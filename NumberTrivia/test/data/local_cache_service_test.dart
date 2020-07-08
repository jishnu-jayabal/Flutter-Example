import 'dart:convert';

import 'package:NumberTrivia/core/error/exceptions.dart';
import 'package:NumberTrivia/data/api/models/number_trivia_model.dart';
import 'package:NumberTrivia/data/local_cache_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  MockSharedPreferences sharedPreferences;
  LocalCacheServiceImpl cacheService;

  setUp(() {
    sharedPreferences = MockSharedPreferences();
    cacheService = LocalCacheServiceImpl(sharedPreferences);
  });

  group("sharedPreferences", () {
    final numberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture("trivia_cached.json")));

    test("should return number trivia in case there is one", () async {
      when(sharedPreferences.getString(any))
          .thenReturn(fixture("trivia_cached.json"));
      final result = await cacheService.getLastNumberTrivia();
      verify(sharedPreferences.getString(any));
      expect(result, numberTriviaModel);
    });

    test("should throw cache Exception when there is no cache", () async {
      when(sharedPreferences.getString(any)).thenReturn(null);
      final result = cacheService.getLastNumberTrivia;
      expect(() => result(), throwsA(isInstanceOf<CacheException>()));
    });
  });

  group("cacheNumberTrivia", () {
    final numberTriviaModel = NumberTriviaModel(number: 1, text: "Test Text");

    test("should call shraedPreferences to save the data", () async {
      cacheService.cacheNumberTrivia(numberTriviaModel);
      final expectedJsonString = json.encode(numberTriviaModel.toJson());
      verify(sharedPreferences.setString(
          CACHED_NUMBER_TRIVIAL, expectedJsonString));
    });

    test("should throw cache Exception when there is no cache", () async {
      when(sharedPreferences.getString(any)).thenReturn(null);

      final result = cacheService.getLastNumberTrivia;

      expect(() => result(), throwsA(isInstanceOf<CacheException>()));
    });
  });
}
