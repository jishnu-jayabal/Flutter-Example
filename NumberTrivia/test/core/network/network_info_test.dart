import 'package:NumberTrivia/core/network/network_info.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockDataConnectionChecker extends Mock implements DataConnectionChecker {}

void main() {

  NetworkInfoImpl networkInfo;
  MockDataConnectionChecker mockDataConnectionChecker;

  setUp((){
    mockDataConnectionChecker = MockDataConnectionChecker();
    networkInfo = NetworkInfoImpl(mockDataConnectionChecker);
  });
  
  group("isConnected", (){
    test("should forward call to DataConnectionChecker.hasConnection", (){

      final tHasConnection = Future.value(true);

      when(mockDataConnectionChecker.hasConnection)
      .thenAnswer((realInvocation) => tHasConnection);

      final result = networkInfo.isConnected;

      verify(mockDataConnectionChecker.hasConnection);
      expect(result, tHasConnection);
    });
  });
}