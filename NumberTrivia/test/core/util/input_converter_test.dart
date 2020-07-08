import 'package:NumberTrivia/core/util/input_converter.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  InputConverter inputConverter ;

  setUp((){
    inputConverter = InputConverter();
  });

  group("stringToUnsignedInteger",(){
    test("should return an integer when given string representation",(){
      final str = '123';
      final result = inputConverter.stringToUnsignedInteger(str);
      expect(result , Left(123));
    });

     test("should return an Failure if string is not a integer",(){
      final str = 'ABC';
      final result = inputConverter.stringToUnsignedInteger(str);
      expect(result , Right(InputValidFailure()));
    });

     test("should return an Failure if string is a negative integer",(){
      final str = '-12';
      final result = inputConverter.stringToUnsignedInteger(str);
      expect(result , Right(InputValidFailure()));
    });
  });
}