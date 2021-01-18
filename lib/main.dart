import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/bloc/language/language_bloc.dart';
import 'package:flutter_app/bloc/network/network_bloc.dart';
import 'package:flutter_app/bloc/theme/theme_bloc.dart';
import 'package:flutter_app/bloc/weather/weather_bloc.dart';
import 'package:flutter_app/generated/l10n.dart';
import 'package:flutter_app/page/home/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:oktoast/oktoast.dart';

import 'bloc_observer.dart';

// TODO 全局主题和系统语言切换测试
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  runApp(BlocProvider<NetworkBloc>(
      create: (BuildContext context) => NetworkBloc(), child: MyApp()));
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black,
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  StreamSubscription _netWorkSubscription;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 监听网络状态
      _netWorkSubscription = Connectivity()
          .onConnectivityChanged
          .listen((ConnectivityResult result) {
        context.read<NetworkBloc>().add(NetWorkChanged(result));
      });
    });
  }

  @override
  void dispose() {
    _netWorkSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<LanguageBloc>(
            create: (BuildContext context) => LanguageBloc(),
          ),
          BlocProvider<ThemeBloc>(
            create: (BuildContext context) => ThemeBloc(),
          ),
          BlocProvider<WeatherBloc>(
              create: (BuildContext context) => WeatherBloc()),
        ],
        child: OKToast(
            // 主题深浅模式切换
            child: BlocBuilder<ThemeBloc, ThemeState>(
                buildWhen: (prevState, nextState) =>
                    prevState.dark != nextState.dark,
                builder: (context, themeState) =>
                    // 语言切换
                    BlocBuilder<LanguageBloc, LanguageState>(
                        // 防止Builder多次重建
                        buildWhen: (prevState, nextState) =>
                            prevState.locale != nextState.locale,
                        builder: (context, languageBState) => MaterialApp(
                              onGenerateTitle: (context) =>
                                  S.of(context).appName,
                              // 默认使用当前系统语言
                              locale: languageBState.locale,
                              localizationsDelegates: [
                                S.delegate,
                                GlobalMaterialLocalizations.delegate,
                                GlobalCupertinoLocalizations.delegate,
                                GlobalWidgetsLocalizations.delegate,
                              ],
                              supportedLocales: [
                                ...S.delegate.supportedLocales
                              ],
                              localeResolutionCallback:
                                  (locale, supportLocales) {
                                Locale _useLocale;
                                // 中文 简繁体 处理
                                if (locale?.languageCode == 'zh') {
                                  if (locale?.countryCode == 'HK' ||
                                      locale?.countryCode == 'TW') {
                                    _useLocale = const Locale('zh', 'HK'); // 繁体
                                  } else {
                                    _useLocale = const Locale('zh', 'CN'); // 简体
                                  }
                                } else {
                                  _useLocale = locale;
                                }
                                // context
                                //     .read<LanguageBloc>()
                                //     .add(LanguageChanged(locale: _useLocale));
                                return _useLocale;
                              },
                              debugShowCheckedModeBanner: false,
                              theme: ThemeData(
                                  primaryColor: themeState.dark
                                      ? Colors.grey
                                      : Colors.lightBlueAccent,
                                  brightness: themeState.dark
                                      ? Brightness.dark
                                      : Brightness.light),
                              home: HomePage(),
                            )))));
  }
}
