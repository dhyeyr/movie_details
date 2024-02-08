import 'package:flutter/material.dart';
import 'package:movie_details/view/home_page.dart';
import 'package:movie_details/view/new.dart';
import 'package:movie_details/view/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controller/search_provider.dart';
late SharedPreferences prefs;



void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SearchProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
            routes: {
              'HomePage': (context) =>  Home_Screen(),
              '/': (context) => const SplashScreen(),
            },
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            // themeMode: themeprovider.thememode,
          ),
    );

  }
}

