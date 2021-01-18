import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/theme/theme_bloc.dart';
import 'package:flutter_app/bloc/weather/weather_bloc.dart';
import 'package:flutter_app/page/home/home.dart';
import 'package:flutter_app/util.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  int num = 3;
  Timer timer;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ThemeBloc>().add(
          ThemeColorChanged(Util.getAppBrightness(context) == Brightness.dark));
      context.read<WeatherBloc>().add(WeatherRequested(cityName: "海淀"));
      timer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (num == 1) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomePage()));
          return;
        }
        if (mounted) {
          setState(() {
            num--;
          });
        }
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("$num",style: TextStyle(fontSize: 30),),
      ),
    );
  }
}
