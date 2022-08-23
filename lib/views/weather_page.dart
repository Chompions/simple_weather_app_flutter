import 'package:flutter/material.dart';
import 'package:pre_test_submission/constants.dart';
import 'package:pre_test_submission/models/current_weather.dart';
import 'package:pre_test_submission/models/forecast_weather.dart';
import 'package:pre_test_submission/models/location.dart';
import 'package:pre_test_submission/services/remote_service.dart';
import 'package:pre_test_submission/views/forecast_card.dart';
import 'package:pre_test_submission/views/today_card.dart';
import 'package:collection/collection.dart';

class WeatherPage extends StatefulWidget {
  WeatherPage({
    Key? key,
    required this.name,
    required this.location,
  }) : super(key: key);

  final String name;
  final Location location;

  static const routeName = '/weather_page';

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  late RemoteService remoteService;

  @override
  void initState() {
    remoteService = RemoteService(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            ColorBrightPurple,
            ColorDarkPurple,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text("Prediksi cuaca"),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: FutureBuilder(
              future: Future.wait([
                remoteService.getCurrentWeather(widget.location),
                remoteService.getForecastWeather(widget.location),
              ]),
              builder: ((context, AsyncSnapshot<List<dynamic>> snapshot) {
                if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                  CurrentWeather currentWeather = snapshot.data![0];
                  ForecastWeather forecastWeather = snapshot.data![1];

                  Map<int, List<ForecastItem>> forecastList = forecastWeather.list!
                      .groupListsBy((element) => remoteService.convertDateTime(element.dt).day);

                  return ListView(
                    children: [
                      TodayCard(
                        widget: widget,
                        remoteService: remoteService,
                        currentWeather: currentWeather,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Column(children: [
                        ForecastCard(
                          forecastList: forecastList,
                          remoteService: remoteService,
                        ),
                      ]),
                    ],
                  );
                }
                if (snapshot.connectionState == ConnectionState.done && snapshot.hasError) {
                  return Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: Column(
                      children: [
                        Text("An error has occured"),
                        Text("${snapshot.error}"),
                      ],
                    ),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                return Text("Something's wrong $snapshot");
              }),
            ),
          ),
        ),
      ),
    );
  }
}
