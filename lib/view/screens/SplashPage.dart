import 'dart:async';

import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed('welcome');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          alignment: Alignment.center,
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 250,
              ),
              TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: 1),
                duration: const Duration(seconds: 2),
                builder: (context, val, widget) {
                  return Transform.scale(
                    scale: val,
                    child: widget,
                  );
                },
                child: Image.asset(
                  'assets/image/bookLogo.png',
                ),
              ),
              Text(
                "Read your favorite books",
                style: TextStyle(
                    color: Colors.blue.shade900,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              const SizedBox(
                height: 270,
              ),
              Text(
                "Reading give us someplace to go when we\n           have to stay where we are.",
                style: TextStyle(color: Colors.blueGrey.shade700, fontSize: 15),
              ),
              LinearProgressIndicator(
                minHeight: 3,
                backgroundColor: Colors.blue.shade900,
                color: Colors.blue.shade200,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
