part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();
}

class WeatherInitial extends WeatherState {
  @override
  List<Object> get props => [];
}

class WeatherLoading extends WeatherState {
  @override
  List<Object> get props => [];
}

class WeatherLoaded extends WeatherState {
  final Weather  _weather;

  Weather get weather => _weather;
  void set weather(value) => _weather;
  
  WeatherLoaded(this._weather);
  @override
  List<Object> get props => [_weather];
}
