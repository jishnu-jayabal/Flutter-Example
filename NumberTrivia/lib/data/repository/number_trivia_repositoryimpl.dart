import 'package:NumberTrivia/core/error/exceptions.dart';
import 'package:NumberTrivia/core/error/failures.dart';
import 'package:NumberTrivia/core/network/network_info.dart';
import 'package:NumberTrivia/data/api/models/number_trivia_model.dart';
import 'package:NumberTrivia/data/api/services/number_trivia_service.dart';
import 'package:NumberTrivia/data/local_cache_service.dart';
import 'package:NumberTrivia/domain/entities/number_trivia.dart';
import 'package:NumberTrivia/domain/repository/number_trivia_repository.dart';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  final NumberTriviaService numberTriviaService;
  final LocalCacheService localCacheService;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl(
      {@required this.networkInfo,
      @required this.numberTriviaService,
      @required this.localCacheService});

  Future<Either<NumberTrivia, Failures>> getRandomNumberTrivia() async {
    return this._getTrivia(() => numberTriviaService.getRandomNumberTrivia());
  }

  Future<Either<NumberTrivia, Failures>> getConcreteNumberTrivia(
      int number) async {
    return this
        ._getTrivia(() => numberTriviaService.getConcreteNumberTrivia(number));
  }

  Future<Either<NumberTrivia, Failures>> _getTrivia(
      Future<NumberTriviaModel> Function() getConcreteOrRandom) async {
    if (await networkInfo.isConnected == true) {
      try {
        final remoteTriviaModel = await getConcreteOrRandom();
        localCacheService.cacheNumberTrivia(remoteTriviaModel);
        final NumberTrivia trivia = NumberTrivia(
            text: remoteTriviaModel.text, number: remoteTriviaModel.number);
        return Left(trivia);
      } on ServerException {
        return Right(ServerFailure());
      }
    } else {
      try {
        final localTriviamodel = await localCacheService.getLastNumberTrivia();
        final NumberTrivia trivia = NumberTrivia(
            text: localTriviamodel.text, number: localTriviamodel.number);
        return Left(trivia);
      } on CacheException {
        return Right(CacheFailure());
      }
    }
  }
}
