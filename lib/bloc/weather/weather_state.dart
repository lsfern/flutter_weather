part of 'weather_bloc.dart';

@immutable
abstract class WeatherState {
  /// 当前展示项
  final int currentIndex;

  /// 城市天气数组
  final List<Weather> weatherList;
  WeatherState({this.currentIndex = 0, this.weatherList});
}

class WeatherInitial extends WeatherState {}

class WeatherLoadInProgress extends WeatherState {}

class WeatherLoadSuccess extends WeatherState {
  WeatherLoadSuccess({int currentIndex, List<Weather> weatherList})
      : super(currentIndex: currentIndex, weatherList: weatherList);

  WeatherLoadSuccess copyWith(int currentIndex, List<Weather> weatherList) {
    return WeatherLoadSuccess(
        weatherList: weatherList, currentIndex: currentIndex);
  }
}

class WeatherRefreshSuccess extends WeatherState {
  WeatherRefreshSuccess(int currentIndex, List<Weather> weatherList)
      : super(currentIndex: currentIndex, weatherList: weatherList);
}

class WeatherLoadFailure extends WeatherState {
  WeatherLoadFailure() : super();
}
