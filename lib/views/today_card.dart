import 'package:flutter/material.dart';
import 'package:pre_test_submission/constants.dart';
import 'package:pre_test_submission/models/current_weather.dart';
import 'package:pre_test_submission/services/remote_service.dart';
import 'package:pre_test_submission/views/weather_page.dart';

import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TodayCard extends StatelessWidget {
  TodayCard({
    required this.widget,
    required this.remoteService,
    required this.currentWeather,
  });

  final WeatherPage widget;
  final RemoteService remoteService;
  final CurrentWeather currentWeather;

  @override
  Widget build(BuildContext context) {
    DateTime currentTime = remoteService.convertDateTime(currentWeather.dt);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 18.0,
            right: 18.0,
            bottom: 16.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    remoteService.greetingString(currentTime),
                    style: TextStyle(
                      color: Colors.white.withOpacity(.8),
                    ),
                  ),
                  Container(
                    width: 200,
                    child: Text(
                      widget.name,
                      style: TextStyle(
                        fontSize: 26,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "di ${widget.location.name}",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withOpacity(.8),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: ColorDarkPurple,
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat('EEE, d MMM').format(currentTime),
                          style: TextStyle(
                            color: Colors.white.withOpacity(.8),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${currentWeather.main?.temp}",
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              " °C",
                              style: TextStyle(
                                fontSize: 22,
                                color: ColorYellow,
                              ),
                            )
                          ],
                        ),
                        Text(
                          currentWeather.name ?? "Kota/Kabupaten",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white.withOpacity(.8),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(
                          width: 100,
                          height: 50,
                          child: Container(
                            child: FittedBox(
                              fit: BoxFit.cover,
                              child: CachedNetworkImage(
                                width: 100,
                                filterQuality: FilterQuality.high,
                                imageUrl: remoteService.getOpenWeatherIconString(
                                    currentWeather.weather?[0].icon ?? '01d'),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          StringUtils.capitalize(currentWeather.weather?[0].description ?? "Cuaca"),
                          style: TextStyle(
                            color: Colors.white.withOpacity(.8),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 18,
                ),
                Container(
                  height: 95,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      TodayInfo(
                        icon: FontAwesomeIcons.droplet,
                        info: "${currentWeather.main?.humidity ?? 0} %",
                        description: "Kelembapan",
                      ),
                      TodayInfo(
                        icon: FontAwesomeIcons.arrowsDownToLine,
                        info: "${currentWeather.main?.pressure ?? 0} hPa",
                        description: "Tekanan",
                      ),
                      TodayInfo(
                        icon: FontAwesomeIcons.cloud,
                        info: "${currentWeather.clouds?.all ?? 0} %",
                        description: "Mendung",
                      ),
                      TodayInfo(
                        icon: FontAwesomeIcons.wind,
                        info: "${currentWeather.wind?.speed ?? 0} m/s",
                        description: "Angin",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class TodayInfo extends StatelessWidget {
  TodayInfo({Key? key, required this.icon, required this.info, required this.description})
      : super(key: key);

  final IconData icon;
  final String info;
  final String description;

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
              Icon(
                icon,
              ),
              SizedBox(
                height: 8,
              ),
              Text(info),
              Text(
                description,
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
