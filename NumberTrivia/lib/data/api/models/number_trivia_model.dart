import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class NumberTriviaModel  extends Equatable{

  final String text;
  final int number;

  NumberTriviaModel({
    @required this.text,
    @required this.number,
  });

  factory NumberTriviaModel.fromJson(Map<String, dynamic> json) {
    return NumberTriviaModel(
      text: json['text'],
      number: (json['number'] as num).toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'number': number,
    };
  }

  @override
  List<Object> get props => [text , number];

}
