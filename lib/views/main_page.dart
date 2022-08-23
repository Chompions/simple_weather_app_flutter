import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pre_test_submission/constants.dart';
import 'package:pre_test_submission/models/location.dart';
import 'package:pre_test_submission/models/user_arguments.dart';
import 'package:pre_test_submission/views/weather_page.dart';
import 'package:pre_test_submission/services/local_service.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String name = "";

  Location? currentProvince;
  Location? currentRegency;

  late LocalService localService;
  List<Location>? locations;
  List<Location>? provinces;
  List<Location>? regencies;

  bool locationsLoaded = false;

  void getLocalData() async {
    localService = LocalService(context);
    locations = await localService.getLocations();

    provinces = localService.getProvince(locations);

    setState(() {
      (locations != null && provinces != null) ? locationsLoaded = true : locationsLoaded = false;
    });
  }

  @override
  void initState() {
    getLocalData();
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
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                ListView(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: 200,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                            ),
                            Container(
                              height: 150,
                              child: SvgPicture.asset('data/undraw_weather_app.svg'),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Yuk \nprediksi \ncuaca \ndilokasimu!",
                          style: TextStyle(
                            color: ColorYellow,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        TextField(
                          enabled: locationsLoaded,
                          onChanged: (value) {
                            setState(() {
                              name = value;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: 'Siapa namamu?',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 16.0,
                            bottom: 4.0,
                          ),
                          child: Text(
                            "Kamu dimana?",
                            style: TextStyle(color: Colors.white.withOpacity(0.5)),
                          ),
                        ),
                        DropdownButton<Location>(
                          isExpanded: true,
                          menuMaxHeight: 300,
                          dropdownColor: ColorBlackPurple,
                          value: currentProvince,
                          onChanged: (value) {
                            regencies = localService.getRegency(locations, value);
                            setState(() {
                              currentRegency = null;
                              currentProvince = value;
                            });
                          },
                          hint: Text("Provinsi"),
                          items: provinces?.map((e) {
                            return DropdownMenuItem<Location>(
                              child: Text(e.name),
                              value: e,
                            );
                          }).toList(),
                        ),
                        DropdownButton<Location>(
                          isExpanded: true,
                          menuMaxHeight: 300,
                          dropdownColor: ColorBlackPurple,
                          value: currentRegency,
                          onChanged: (value) {
                            setState(() {
                              currentRegency = value;
                            });
                          },
                          hint: Text("Kota / Kabupaten"),
                          items: regencies?.map((e) {
                            return DropdownMenuItem<Location>(
                              child: Text(e.name),
                              value: e,
                            );
                          }).toList(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 4.0,
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: ColorYellow,
                              ),
                              onPressed: (name.isNotEmpty && currentRegency != null)
                                  ? () {
                                      print("$name and $currentRegency");
                                      Navigator.pushNamed(context, WeatherPage.routeName,
                                          arguments: UserArguments(name, currentRegency!));
                                    }
                                  : null,
                              child: Text(
                                "Dapatkan cuacamu sekarang!",
                                style: TextStyle(
                                  color: ColorDarkPurple,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                AnimatedOpacity(
                  opacity: !locationsLoaded ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 500),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: CircularProgressIndicator(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
