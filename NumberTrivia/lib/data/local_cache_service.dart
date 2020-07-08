import 'dart:convert';

import 'package:NumberTrivia/core/error/exceptions.dart';
import 'package:NumberTrivia/data/api/models/number_trivia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalCacheService {
  Future<NumberTriviaModel> getLastNumberTrivia();
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache);
}

const CACHED_NUMBER_TRIVIAL = "CACHED_NUMBER_TRIVIAL";

class LocalCacheServiceImpl implements LocalCacheService {

  final SharedPreferences _sharedPreference;

  LocalCacheServiceImpl(this._sharedPreference);

  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache) {
    return _sharedPreference.setString(CACHED_NUMBER_TRIVIAL, json.encode(triviaToCache.toJson()));
  }

  @override
  Future<NumberTriviaModel> getLastNumberTrivia() {
    final jsonString = this._sharedPreference.getString(CACHED_NUMBER_TRIVIAL);
    if(jsonString != null )
      return Future.value(NumberTriviaModel.fromJson(json.decode(jsonString)));
    else throw CacheException();
  }

}