import 'package:NumberTrivia/core/error/exceptions.dart';
import 'package:NumberTrivia/core/error/failures.dart';
import 'package:NumberTrivia/core/network/network_info.dart';
import 'package:NumberTrivia/data/api/models/number_trivia_model.dart';
import 'package:NumberTrivia/data/api/services/number_trivia_service.dart';
import 'package:NumberTrivia/data/local_cache_service.dart';
import 'package:NumberTrivia/data/repository/number_trivia_repositoryimpl.dart';
import 'package:NumberTrivia/domain/entities/number_trivia.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockNumberTriviaService extends Mock implements NumberTriviaService {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

class MockLocalService extends Mock implements LocalCacheService {}

void main() {
  MockNumberTriviaService mockNumberTriviaService;
  MockNetworkInfo mockNetworkInfo;
  LocalCacheService cacheService;
  NumberTriviaRepositoryImpl numberTriviaRepositoryImpl;

  setUp(() {
    mockNumberTriviaService = MockNumberTriviaService();
    cacheService = MockLocalService();
    mockNetworkInfo = MockNetworkInfo();
    numberTriviaRepositoryImpl = NumberTriviaRepositoryImpl(
        numberTriviaService: mockNumberTriviaService,
        networkInfo: mockNetworkInfo,
        localCacheService: cacheService);
  });

  void runTestOnline(Function body) {
    group("device is online", () {
      setUp(() {
        when(mockNetworkInfo.isConnected)
            .thenAnswer((realInvocation) async => true);
      });

      body();
    });
  }

  void runTestOffline(Function body) {
    group("device is offline", () {
      setUp(() {
        when(mockNetworkInfo.isConnected)
            .thenAnswer((realInvocation) async => false);
      });

      body();
    });
  }

  group("getConcreteNumberTrivia", () {
    final number = 1;

    final tnumberModel = NumberTriviaModel(text: "Test Text", number: 1);

    final tnumber = NumberTrivia(text: "Test Text", number: 1);

    test("should check if device is online", () async {
      when(mockNetworkInfo.isConnected)
          .thenAnswer((realInvocation) async => true);
      when(mockNumberTriviaService.getConcreteNumberTrivia(any))
          .thenAnswer((realInvocation) async => tnumberModel);

      numberTriviaRepositoryImpl.getConcreteNumberTrivia(number);

      verify(mockNetworkInfo.isConnected);
    });

    // Run Test on Online State
    runTestOnline(() {
      test(
          "should return remote data whem call to remote data source is success",
          () async {
        when(mockNumberTriviaService.getConcreteNumberTrivia(any))
            .thenAnswer((realInvocation) async => tnumberModel);

        final result =
            await numberTriviaRepositoryImpl.getConcreteNumberTrivia(number);

        verify(mockNumberTriviaService.getConcreteNumberTrivia(number));
        expect(result, Left(tnumber));
      });

      test(
          "should cache the data locally data whem call to remote data source is success",
          () async {
        when(mockNumberTriviaService.getConcreteNumberTrivia(any))
            .thenAnswer((realInvocation) async => tnumberModel);

        final result =
            await numberTriviaRepositoryImpl.getConcreteNumberTrivia(number);

        verify(mockNumberTriviaService.getConcreteNumberTrivia(number));
        verify(cacheService.cacheNumberTrivia(tnumberModel));
        expect(result, Left(tnumber));
      });

      test(
          "should return failure when call to remote data source is unsucccessfull",
          () async {
        when(mockNumberTriviaService.getConcreteNumberTrivia(any))
            .thenThrow(ServerException());

        final result =
            await numberTriviaRepositoryImpl.getConcreteNumberTrivia(number);

        verify(mockNumberTriviaService.getConcreteNumberTrivia(number));
        verifyZeroInteractions(cacheService);
        expect(result, Right(ServerFailure()));
      });
    });

    runTestOffline(() {
      test("Should return last cahed data if present", () async {
        when(cacheService.getLastNumberTrivia())
            .thenAnswer((realInvocation) async => tnumberModel);

        final result =
            await numberTriviaRepositoryImpl.getConcreteNumberTrivia(number);

        verify(cacheService.getLastNumberTrivia());
        verifyZeroInteractions(mockNumberTriviaService);

        expect(result, Left(tnumber));
      });

      test("Should return Cache Failiure when no cahed data if present",
          () async {
        when(cacheService.getLastNumberTrivia()).thenThrow(CacheException());

        final result =
            await numberTriviaRepositoryImpl.getConcreteNumberTrivia(number);

        verify(cacheService.getLastNumberTrivia());
        verifyZeroInteractions(mockNumberTriviaService);

        expect(result, Right(CacheFailure()));
      });
    });
  });

  group("getRandomNumberTrivia", () {
    final tnumberModel = NumberTriviaModel(text: "Test Text", number: 123);

    final tnumber = NumberTrivia(text: "Test Text", number: 123);

    test("should check if device is online", () async {
      when(mockNetworkInfo.isConnected)
          .thenAnswer((realInvocation) async => true);
      when(mockNumberTriviaService.getRandomNumberTrivia())
          .thenAnswer((realInvocation) async => tnumberModel);

      numberTriviaRepositoryImpl.getRandomNumberTrivia();

      verify(mockNetworkInfo.isConnected);
    });

    // Run Test on Online State
    runTestOnline(() {
      test(
          "should return remote data whem call to remote data source is success",
          () async {
        when(mockNumberTriviaService.getRandomNumberTrivia())
            .thenAnswer((realInvocation) async => tnumberModel);

        final result =
            await numberTriviaRepositoryImpl.getRandomNumberTrivia();

        verify(mockNumberTriviaService.getRandomNumberTrivia());
        expect(result, Left(tnumber));
      });

      test(
          "should cache the data locally data whem call to remote data source is success",
          () async {
        when(mockNumberTriviaService.getRandomNumberTrivia())
            .thenAnswer((realInvocation) async => tnumberModel);

        final result =
            await numberTriviaRepositoryImpl.getRandomNumberTrivia();

        verify(mockNumberTriviaService.getRandomNumberTrivia());
        verify(cacheService.cacheNumberTrivia(tnumberModel));
        expect(result, Left(tnumber));
      });

      test(
          "should return failure when call to remote data source is unsucccessfull",
          () async {
        when(mockNumberTriviaService.getRandomNumberTrivia())
            .thenThrow(ServerException());

        final result =
            await numberTriviaRepositoryImpl.getRandomNumberTrivia();

        verify(mockNumberTriviaService.getRandomNumberTrivia());
        verifyZeroInteractions(cacheService);
        expect(result, Right(ServerFailure()));
      });
    });

    runTestOffline(() {
      test("Should return last cahed data if present", () async {
        when(cacheService.getLastNumberTrivia())
            .thenAnswer((realInvocation) async => tnumberModel);

        final result =
            await numberTriviaRepositoryImpl.getRandomNumberTrivia();

        verify(cacheService.getLastNumberTrivia());
        verifyZeroInteractions(mockNumberTriviaService);

        expect(result, Left(tnumber));
      });

      test("Should return Cache Failiue when no cahed data if present",
          () async {
        when(cacheService.getLastNumberTrivia()).thenThrow(CacheException());

        final result =
            await numberTriviaRepositoryImpl.getRandomNumberTrivia();

        verify(cacheService.getLastNumberTrivia());
        verifyZeroInteractions(mockNumberTriviaService);

        expect(result, Right(CacheFailure()));
      });
    });
  });
}
