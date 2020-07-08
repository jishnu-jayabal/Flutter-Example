part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  WeatherEvent(): super();
}

class GetWeatherEvent extends WeatherEvent {

  final String cityName;

  GetWeatherEvent(this.cityName): super();

  @override
  List<Object> get props => [cityName];
  
}
