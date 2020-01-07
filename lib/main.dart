import 'package:coeops/constants.dart';
import 'package:coeops/design_course/create_course_form.dart';
import 'package:coeops/design_course/home_design_course.dart';
import 'package:coeops/managers/app_manager.dart';
import 'package:coeops/services/locator.dart';
import 'package:coeops/ui/forgot_password.dart';
import 'package:coeops/ui/signin.dart';
import 'package:coeops/ui/signup.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';

void main() async {
  setupLocator();
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      initialRoute: '/signin',
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) =>
            new MyHomePage(title: AppConstants.appName),
        '/signin': (BuildContext context) => new SigninPage(),
        '/signup': (BuildContext context) => new SignupPage(),
        '/forgotPassword': (BuildContext context) => new ForgotPasswordPage()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.analytics, this.observer})
      : super(key: key);

  final String title;
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _MyHomePageState createState() => _MyHomePageState(analytics, observer);
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState(this.analytics, this.observer);
  final FirebaseAnalyticsObserver observer;
  final FirebaseAnalytics analytics;

  void _navigateToCreatePage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CreateCourseForm()));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: DesignCourseHomeScreen(),
        floatingActionButton: FloatingActionButton(
          onPressed: _navigateToCreatePage,
          tooltip: 'New course',
          child: Icon(Icons.add),
        ),
      ),
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
