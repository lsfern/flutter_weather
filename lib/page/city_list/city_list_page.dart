import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/language/language_bloc.dart';
import 'package:flutter_app/bloc/theme/theme_bloc.dart';
import 'package:flutter_app/bloc/weather/weather_bloc.dart';
import 'package:flutter_app/generated/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CityListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text(S.of(context).cityManagement),
        elevation: 0,
      ),
      body: Column(
        children: [
          BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              return Expanded(
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: state.weatherList.length,
                    itemBuilder: (context, index) {
                      return DefaultTextStyle(
                          style: TextStyle(color: Colors.white, fontSize: 15),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () => context
                                  .read<WeatherBloc>()
                                  .add(WeatherCityChanged(context, index)),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(width: 10),
                                      Text(
                                          state.weatherList[index].data[0].wea),
                                      SizedBox(width: 20),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(state.weatherList[index].city),
                                            Row(
                                              children: [
                                                Text(
                                                    "${state.weatherList[index].data[0].tem1} / ${state.weatherList[index].data[0].tem2}"),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Text(
                                          "${state.currentIndex == index ? (S.of(context).currentCity) : ""}")
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  line(context)
                                ],
                              ),
                            ),
                          ));
                    }),
              );
            },
          ),
          line(context),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BlocBuilder<LanguageBloc, LanguageState>(
                builder: (context, state) => InkWell(
                    onTap: () => context
                        .read<LanguageBloc>()
                        .add(LanguageChanged(locale: null)),
                    child: Text(S.of(context).changeLanguage)),
              ),
              const SizedBox(width: 20),
              BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
                return InkWell(
                    onTap: () => context
                        .read<ThemeBloc>()
                        .add(ThemeColorChanged(!state.dark)),
                    child: Text(
                      "${!state.dark ? S.of(context).darkColor : S.of(context).lightColor}",
                    ));
              }),
              InkWell(
                onTap: () => context
                    .read<WeatherBloc>()
                    .add(WeatherCityAdded(cityName: "昌平")),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom)
        ],
      ),
    );
  }

  Widget line(BuildContext context) => Container(
        width: MediaQuery.of(context).size.width,
        height: 0.5,
        color: Colors.white,
      );
}
