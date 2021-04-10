import 'package:flutter/material.dart';
import 'splash.dart';
import 'sign.dart';

var routes = <String, WidgetBuilder>{
  "/sign": (BuildContext context) => SignIn(),
};

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primaryColor: Colors.blue, accentColor: Colors.blueAccent),
    home: Splash(),
    routes: routes,
  ));
}
