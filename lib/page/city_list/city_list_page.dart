import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/weather/weather_bloc.dart';
import 'package:flutter_app/generated/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CityListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
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
                          child: Container(
                            color: state.currentIndex == index
                                ? Colors.lightBlue
                                : Colors.transparent,
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () => context
                                  .read<WeatherBloc>()
                                  .add(WeatherCityChanged(context, index)),
                              child: Row(
                                children: [
                                  SizedBox(width: 10),
                                  Text(state.weatherList[index].data[0].wea),
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
          Center(
            child: InkWell(
              onTap: () => context
                  .read<WeatherBloc>()
                  .add(WeatherCityAdded(cityName: "昌平")),
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom - 10)
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
