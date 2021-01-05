import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wardrobe_2/style/colors.dart';
import 'package:wardrobe_2/view/page/login_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter wardrobe',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: MyColor.primary,
        accentColor: MyColor.accent,
        scaffoldBackgroundColor: MyColor.primary,
        appBarTheme: AppBarTheme(
            color: MyColor.primary,
            elevation: 0,
            textTheme: TextTheme(
                title: TextStyle(
                    color: MyColor.text,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(color: MyColor.shadow,blurRadius: 2)
                    ],
                    fontSize: 25
                )
            ),
            shadowColor: MyColor.shadow,
            iconTheme: IconThemeData(
              color: MyColor.icon,
            )
        ),
        buttonTheme: ButtonThemeData(
            buttonColor: MyColor.accent,
            minWidth: double.infinity,
            textTheme: ButtonTextTheme.primary,
            padding: EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            )
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
    );
  }
}
