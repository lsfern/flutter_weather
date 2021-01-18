import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/network/network_bloc.dart';
import 'package:flutter_app/bloc/theme/theme_bloc.dart';
import 'package:flutter_app/bloc/weather/weather_bloc.dart';
import 'package:flutter_app/generated/l10n.dart';
import 'package:flutter_app/page/home/widget/weather.dart';
import 'package:flutter_app/util.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchWeather();
    });
  }

  /// 请求天气数据
  void fetchWeather() {
    // 数据为空才请求
    if(context.read<WeatherBloc>().state.weatherList.isEmpty){
      context.read<WeatherBloc>().add(WeatherRequested(cityName: "海淀"));
      // context.read<WeatherBloc>().add(WeatherRequested(cityName: "1000"));
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      Brightness brightness = Util.getAppBrightness(context);
      // 系统主题亮度模式已切换，程序内部也需要更换，有延迟
      if ((brightness == Brightness.dark) !=
          context.read<ThemeBloc>().state.dark) {
        setThemeBrightness(context);
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /// 判断系统是否是深色模式
  void setThemeBrightness(BuildContext context) {
    context.read<ThemeBloc>().add(
        ThemeColorChanged(Util.getAppBrightness(context) == Brightness.dark));
  }

  @override
  Widget build(BuildContext context) {
    print("Home build");
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: BlocListener<NetworkBloc, NetworkState>(
          listenWhen: (prevState, nextState) =>
              prevState.connectivityResult != nextState.connectivityResult,
          listener: (context, state) {
            if (state.connectivityResult == ConnectivityResult.none) {
              showToast("网络连接异常，请检查网络");
            }
          },
          child: BlocBuilder<WeatherBloc, WeatherState>(
            buildWhen: (prevState, nextState) {
              if (prevState.weatherList == null) return true;
              if (nextState is WeatherRefreshSuccess) return true;
              if (prevState.currentIndex == nextState.currentIndex)
                return false;
              return true;
            },
            builder: (context, state) {
              if (state is WeatherLoadInProgress) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is WeatherLoadSuccess ||
                  state is WeatherRefreshSuccess) {
                return WeatherWidget();
              }
              if (state is WeatherLoadFailure) {
                return Center(
                  child: InkWell(
                      onTap: () => fetchWeather(), child: Text("数据加载失败,点击重试")),
                );
              }
              return Container();
            },
          ),
        ));
  }
}
