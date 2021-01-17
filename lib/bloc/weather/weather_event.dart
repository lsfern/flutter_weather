part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent {}

class WeatherRequested extends WeatherEvent {
  final String cityName;

  WeatherRequested({this.cityName});
}

class WeatherRefreshed extends WeatherEvent {
  final String cityName;

  WeatherRefreshed(this.cityName);
}

class WeatherCityAdded extends WeatherEvent {
  final String cityName;

  WeatherCityAdded({this.cityName});
}

class WeatherCityChanged extends WeatherEvent {
  final BuildContext context;
  final int currentIndex;
  WeatherCityChanged(this.context,this.currentIndex);
}
