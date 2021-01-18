import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/api/weather_repository.dart';
import 'package:flutter_app/bean/weather.dart';
import 'package:meta/meta.dart';
import 'package:oktoast/oktoast.dart';
import 'package:rxdart/rxdart.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial());

  @override
  Stream<Transition<WeatherEvent, WeatherState>> transformEvents(
    Stream<WeatherEvent> events,
    TransitionFunction<WeatherEvent, WeatherState> transitionFn,
  ) {
    //  事件在1秒之内多次调用只会响应最后一次
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 1000)),
      transitionFn,
    );
    //  事件在1秒之内多次调用只会响应第一次
    return super.transformEvents(
      events.throttleTime(const Duration(milliseconds: 1000)),
      transitionFn,
    );
  }

  /// async* 方法必须返回Stream<T> 对象
  /// async* yield 返回Stream<dynamic>
  /// async* yield* 调用一个函数并返回Stream<dynamic>
  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    if (event is WeatherRequested) {
      yield* mapEventToWeatherRequestState(event);
    }
    if (event is WeatherRefreshed) {
      yield* mapEventToWeatherRefreshState(event);
    }
    if (event is WeatherCityAdded) {
      yield* mapEventToWeatherCityState(event);
    }
    if (event is WeatherCityChanged) {
      yield* mapEventToWeatherCityChangeState(event);
    }
  }

  /// 获取某城市天气信息
  Stream<WeatherState> mapEventToWeatherRequestState(
      WeatherRequested event) async* {
    yield WeatherLoadInProgress();
    List<Weather> weatherList = await fetchCity(event.cityName);
    yield weatherList.isNotEmpty
        ? WeatherLoadSuccess(
            currentIndex: state.currentIndex, weatherList: weatherList)
        : WeatherLoadFailure();
  }

  /// 刷新某条数据
  Stream<WeatherState> mapEventToWeatherRefreshState(
      WeatherRefreshed event) async* {
    List<Weather> currentWeatherList = state.weatherList;
    String cityName = event.cityName;
    Weather weather = await WeatherRepository.getWeather(cityName: cityName);
    if (weather != null && weather?.city != null) {
      for (int i = 0; i < currentWeatherList.length; i++) {
        if (currentWeatherList[i].city == cityName) {
          weather.city += "刷新";
          currentWeatherList[i] = weather;
          break;
        }
      }
    }
    yield WeatherRefreshSuccess(state.currentIndex, currentWeatherList);
  }

  /// 添加城市天气信息
  Stream<WeatherState> mapEventToWeatherCityState(
      WeatherCityAdded event) async* {
    print("event is WeatherCityAdded");
    List<Weather> currentWeatherList = state.weatherList;
    String cityName = event.cityName;
    for (Weather weather in currentWeatherList) {
      if (weather.city == cityName) {
        showToast("城市已存在，请重新输入");
        return;
      }
    }
    List<Weather> weatherList = await fetchCity(cityName);
    if (weatherList.isNotEmpty) {
      yield WeatherLoadSuccess()
          .copyWith(state.currentIndex, state.weatherList + weatherList);
    } else {
      showToast("无对应城市信息，请重新输入");
    }
  }

  /// 切换城市
  Stream<WeatherState> mapEventToWeatherCityChangeState(
      WeatherCityChanged event) async* {
    if (event.currentIndex == state.currentIndex) return;
    Navigator.pop(event.context);
    yield WeatherLoadSuccess().copyWith(event.currentIndex, state.weatherList);
  }

  Future<List<Weather>> fetchCity(String cityName) async {
    List<Weather> weatherList = [];
    if (cityName.isEmpty) {
      showToast("请输入城市信息");
      return weatherList;
    }
    Weather weather = await WeatherRepository.getWeather(cityName: cityName);
    if (weather != null && weather?.city != null) {
      weatherList.add(weather);
    }
    return weatherList;
  }
}
