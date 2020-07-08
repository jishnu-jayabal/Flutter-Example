import 'package:NumberTrivia/core/network/network_info.dart';
import 'package:NumberTrivia/core/util/input_converter.dart';
import 'package:NumberTrivia/data/api/services/number_trivia_service.dart';
import 'package:NumberTrivia/data/local_cache_service.dart';
import 'package:NumberTrivia/data/repository/number_trivia_repositoryimpl.dart';
import 'package:NumberTrivia/domain/repository/number_trivia_repository.dart';
import 'package:NumberTrivia/domain/usecase/get_concrete_number_trivia.dart';
import 'package:NumberTrivia/domain/usecase/get_random_number_trivia.dart';
import 'package:NumberTrivia/presentation/bloc/numbertrivia_bloc.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //-----Features

    // Bloc
    sl.registerFactory(() => NumbertriviaBloc(
      sl(), sl(), sl())
    );

    // Use Cases
    sl.registerLazySingleton(()=>GetConcreteNumberTrivia(sl()));
    sl.registerLazySingleton(()=>GetRandomNumberTrivia(sl()));

    // Repository
    sl.registerLazySingleton<NumberTriviaRepository>(() => NumberTriviaRepositoryImpl(
      localCacheService: sl(),
      networkInfo: sl(),
      numberTriviaService: sl()
    ));

    // Data
     sl.registerLazySingleton<LocalCacheService>(() => LocalCacheServiceImpl(sl()));
    sl.registerLazySingleton<NumberTriviaService>(() => NumberTriviaServiceImpl(sl()));

  //----Core

    sl.registerLazySingleton<InputConverter>(() => InputConverter());
    sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //---External

  final sharedPrefernces = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPrefernces);
  sl.registerLazySingleton<http.Client>(() => http.Client());
  sl.registerLazySingleton<DataConnectionChecker>(() => DataConnectionChecker());

  return;

}
