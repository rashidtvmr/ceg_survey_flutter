import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Survey_App/models/app.dart';

// import './screens/SplashScreen.dart';
import './screens/HomeScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppModel(),
      child: MaterialApp(
        title: 'Survey App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MainPage(),
      ),
    );
  }
}
