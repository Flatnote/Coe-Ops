import 'package:coeops/constants.dart';
import 'package:coeops/home.dart';
import 'package:coeops/managers/app_manager.dart';
import 'package:coeops/models/user.dart';
import 'package:coeops/root.dart';
import 'package:coeops/services/auth_service.dart';
import 'package:coeops/services/locator.dart';
import 'package:coeops/ui/forgot_password.dart';
import 'package:coeops/ui/signin.dart';
import 'package:coeops/ui/signup.dart';
import 'package:coeops/view_model/google_button.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  setupLocator();
  return runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => GoogleButtonViewModel(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
          title: AppConstants.appName,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          builder: (context, widget) => Navigator(
                onGenerateRoute: (settings) => MaterialPageRoute(
                  builder: (context) => AppManager(
                    child: widget,
                  ),
                ),
              ),
          initialRoute: '/',
          routes: <String, WidgetBuilder>{
            '/': (BuildContext context) => new Root(),
            '/home': (BuildContext context) =>
                new MyHomePage(title: AppConstants.appName),
            '/signin': (BuildContext context) => new SigninPage(),
            '/signup': (BuildContext context) => new SignupPage(),
            '/forgotPassword': (BuildContext context) =>
                new ForgotPasswordPage()
          },
          navigatorObservers: <NavigatorObserver>[
            observer
          ]),
    );
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
