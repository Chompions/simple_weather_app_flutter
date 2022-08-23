import 'package:flutter/material.dart';
import 'package:pre_test_submission/models/user_arguments.dart';
import 'package:pre_test_submission/views/main_page.dart';
import 'package:pre_test_submission/views/weather_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

Future<void> main() async {
  await DotEnv.load();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      initialRoute: MainPage.routeName,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case MainPage.routeName:
            return MaterialPageRoute(builder: (context) => MainPage());
          case WeatherPage.routeName:
            {
              final args = settings.arguments as UserArguments;
              return MaterialPageRoute(
                  builder: (context) => WeatherPage(name: args.name, location: args.location));
            }
        }
        assert(false, 'Need to implement ${settings.name}');
        return null;
      },
    );
  }
}
