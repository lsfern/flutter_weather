import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/weather/weather_bloc.dart';
import 'package:flutter_app/page/city_list/city_list_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// 天气组件
class WeatherWidget extends StatefulWidget {
  @override
  _WeatherWidgetState createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  ScrollController scrollController;
  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("WeatherWidget build");
    return BlocConsumer<WeatherBloc, WeatherState>(
        // 当切换了城市，才执行listener里代码
        listenWhen: (prevState, nextState) =>
            prevState.currentIndex != nextState.currentIndex,
        // 用于执行其他非build事件
        listener: (context, state) => scrollController?.animateTo(0.0,
            duration: Duration(milliseconds: 300), curve: Curves.easeIn),
        builder: (context, state) {
          final data = state.weatherList[state.currentIndex].data;
          final city = state.weatherList[state.currentIndex].city;
          return Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async =>
                      context.read<WeatherBloc>().add(WeatherRefreshed(city)),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 100),
                        Center(
                          child: DefaultTextStyle(
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    city,
                                  ),
                                  Text(
                                    data[0].wea,
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(data[0].hours[0].tem,
                                      style: TextStyle(
                                        fontSize: 40,
                                      )),
                                  Text("最高${data[0].tem1}  最低${data[0].tem2}",
                                      style: TextStyle(fontSize: 15)),
                                ],
                              )),
                        ),
                        SizedBox(height: 40),
                        line(context),
                        SizedBox(
                          height: 102,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(10),
                                child: DefaultTextStyle(
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                    child: Column(children: [
                                      Text(
                                        data[0].hours[index].hours,
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        data[0].hours[index].wea,
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        data[0].hours[index].tem,
                                      ),
                                    ])),
                              );
                            },
                            itemCount: data[0].hours.length,
                          ),
                        ),
                        line(context),
                        MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          removeBottom: true,
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              if (index == 0) return Container();
                              return Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: DefaultTextStyle(
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(width: 10),
                                        Text(
                                          data[index].week,
                                        ),
                                        Expanded(
                                            child: Center(
                                          child: Text(
                                            data[index].wea,
                                          ),
                                        )),
                                        Text(
                                          data[index].tem1,
                                        ),
                                        SizedBox(width: 15),
                                        Text(
                                          data[index].tem2,
                                        ),
                                        SizedBox(width: 15),
                                      ],
                                    )),
                              );
                            },
                            itemCount: data.length,
                          ),
                        ),
                        line(context),
                        DefaultTextStyle(
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(
                                      "空气质量：${data[0].airLevel}。${data[0].airTips}"),
                                ),
                                SizedBox(height: 10),
                                line(context),
                                otherWidget(context, "日出", data[0].sunrise),
                                otherWidget(context, "日落", data[0].sunset),
                                otherWidget(context, "湿度", data[0].humidity),
                                otherWidget(context, "风", data[0].winSpeed),
                                otherWidget(context, "能见度", data[0].visibility),
                                otherWidget(
                                    context, "气压", "${data[0].pressure}百帕"),
                              ],
                            )),
                      ],
                    ),
                  ),
                ),
              ),
              line(context),
              SizedBox(
                height: 10,
              ),
              Center(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CityListPage()));
                  },
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).padding.bottom)
            ],
          );
        });
  }

  Widget line(BuildContext context) => Container(
        width: MediaQuery.of(context).size.width,
        height: 0.5,
        color: Colors.white,
      );

  Widget otherWidget(BuildContext context, String str, String str1) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5),
          Text(str),
          Text(str1, style: TextStyle(fontSize: 20)),
          line(context),
        ],
      ),
    );
  }
}
