part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
}

class ThemeChanged extends ThemeEvent {

  final AppThemes theme;

  ThemeChanged(this.theme);

  @override
  List<Object> get props => [theme];
  
}