import 'package:flutter/material.dart';
import 'package:pre_test_submission/constants.dart';
import 'package:pre_test_submission/models/forecast_weather.dart';
import 'package:pre_test_submission/services/remote_service.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ForecastCard extends StatelessWidget {
  const ForecastCard({
    Key? key,
    required this.forecastList,
    required this.remoteService,
  }) : super(key: key);

  final Map<int, List<ForecastItem>> forecastList;
  final RemoteService remoteService;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorDarkPurple,
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: ListView.builder(
        primary: false,
        shrinkWrap: true,
        itemCount: forecastList.length,
        itemBuilder: ((context, index) {
          int key = forecastList.keys.elementAt(index);
          return Container(
            height: 100,
            margin: EdgeInsets.only(top: 8),
            child: Row(
              children: [
                Container(
                  width: 60,
                  decoration: BoxDecoration(
                    color: ColorDarkPurple,
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(remoteService.getDate(forecastList[key]?.first.dt)),
                        Text(remoteService.getMonth(forecastList[key]?.first.dt)),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: forecastList[key]?.length,
                    itemBuilder: ((context, index) {
                      return Container(
                        width: 100,
                        margin: EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                            color: ColorBlackPurple,
                            borderRadius: BorderRadius.all(Radius.circular(12))),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                remoteService.getHourMinute(forecastList[key]?[index].dt),
                              ),
                              CachedNetworkImage(
                                width: 50,
                                imageUrl: remoteService.getOpenWeatherIconString(
                                    forecastList[key]?[index].weather?[0].icon ?? '01d'),
                              ),
                              Text(
                                  remoteService.getTempDegree(forecastList[key]?[index].main?.temp),
                                  style: TextStyle(fontSize: 12))
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class ForecastInfo extends StatelessWidget {
  ForecastInfo({
    Key? key,
    required this.time,
    required this.icon,
    required this.temp,
  }) : super(key: key);

  final String time;
  final IconData icon;
  final String temp;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 6),
      width: 100,
      decoration: BoxDecoration(
          color: ColorBlackPurple, borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(time),
              SizedBox(
                height: 8,
              ),
              Icon(icon),
              SizedBox(
                height: 8,
              ),
              Text(
                temp,
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
