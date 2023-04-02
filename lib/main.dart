import 'package:firebase_books/view/screens/DetailPage.dart';
import 'package:firebase_books/view/screens/HomePage.dart';
import 'package:firebase_books/view/screens/SignUpPage.dart';
import 'package:firebase_books/view/screens/SplashPage.dart';
import 'package:firebase_books/view/screens/welcomePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    theme: ThemeData(useMaterial3: true),
    initialRoute: 'splash',
    routes: {
      '/': (context) => const HomePage(),
      'splash': (context) => const SplashPage(),
      'welcome': (context) => const WelcomePage(),
      'signUp': (context) => const SignUpPage(),
      'details': (context) => const DetailPage(),
    },
  ));
}
