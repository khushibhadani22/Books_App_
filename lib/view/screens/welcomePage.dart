import 'package:flutter/material.dart';

import '../../Helper/FireBaseAuthHelper.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? email;
  String? password;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Image.asset('assets/image/l.jpg'),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 620,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                child: Form(
                  key: signInFormKey,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Welcome Back",
                          style: TextStyle(
                              color: Colors.blue.shade900,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Login to Your Account",
                          style: TextStyle(
                            color: Colors.blue.shade900,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Enter your email first......";
                            }
                            return null;
                          },
                          onSaved: (val) {
                            setState(() {
                              email = emailController.text;
                            });
                          },
                          controller: emailController,
                          style: TextStyle(color: Colors.blue.shade900),
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              hintStyle: const TextStyle(color: Colors.grey),
                              hintText: "abc253@gmail.com",
                              prefixIcon: Icon(
                                Icons.email,
                                color: Colors.blue.shade900,
                              )),
                        ),
                        TextFormField(
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Enter your password first......";
                            }
                            return null;
                          },
                          onSaved: (val) {
                            setState(() {
                              password = passwordController.text;
                            });
                          },
                          controller: passwordController,
                          style: TextStyle(color: Colors.blue.shade900),
                          textInputAction: TextInputAction.done,
                          obscureText: true,
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              hintStyle: const TextStyle(color: Colors.grey),
                              hintText: "*********",
                              prefixIcon: Icon(
                                Icons.lock_outline,
                                color: Colors.blue.shade900,
                              )),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Forgot Password?",
                              style: TextStyle(color: Colors.blue.shade900),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue.shade900,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 150, vertical: 13)),
                            onPressed: () async {
                              if (signInFormKey.currentState!.validate()) {
                                signInFormKey.currentState!.save();

                                Map<String, dynamic> res = await AuthHelper
                                    .authHelper
                                    .signIn(email: email!, password: password!);

                                if (res['user'] != null) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content:
                                        const Text("Login In Successful....."),
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: Colors.blue.shade900,
                                  ));
                                  Navigator.of(context).pushReplacementNamed(
                                    '/',
                                  );
                                } else if (res['error'] != null) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(res['error']),
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: Colors.blue.shade900,
                                  ));
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: const Text("Login In Failed....."),
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: Colors.blue.shade900,
                                  ));
                                }
                              }
                              setState(() {
                                emailController.clear();
                                passwordController.clear();
                                email = null;
                                password = null;
                              });
                            },
                            child: const Text(
                              "Log In",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17),
                            )),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed('signUp');
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account?",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.blue.shade900),
                              ),
                              Text(
                                " Sign Up",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue.shade900),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                Map<String, dynamic> res = await AuthHelper
                                    .authHelper
                                    .signInWithGoogle();
                                if (res['user'] != null) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: const Text(
                                        "Login Successful With Google....."),
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: Colors.blue.shade900,
                                  ));
                                  Navigator.of(context).pushReplacementNamed(
                                    '/',
                                  );
                                } else if (res['error'] != null) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(res['error']),
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: Colors.blue.shade900,
                                  ));
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: const Text(
                                        "Login Failed With Google....."),
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: Colors.blue.shade900,
                                  ));
                                }
                              },
                              child: CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.white.withOpacity(0.9),
                                backgroundImage: const AssetImage(
                                  'assets/image/google.png',
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                Map<String, dynamic> res = await AuthHelper
                                    .authHelper
                                    .logInWithAnonymously();

                                if (res['user'] != null) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: const Text(
                                        "Login Successful As Guest....."),
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: Colors.blue.shade900,
                                  ));
                                  Navigator.of(context).pushReplacementNamed(
                                    '/',
                                  );
                                } else if (res['error'] != null) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(res['error']),
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: Colors.blue.shade900,
                                  ));
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: const Text(
                                        "Login Failed As Guest....."),
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: Colors.blue.shade900,
                                  ));
                                }
                              },
                              child: CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.person,
                                  color: Colors.blue.shade900,
                                  size: 40,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Column(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     const SizedBox(
            //       height: 100,
            //     ),
            //     Image.asset('assets/image/bookLogo.png'),
            //     Text(
            //       "Reading give us someplace to go when we\n           have to stay where we are.",
            //       style: TextStyle(color: Colors.blue.shade900, fontSize: 15),
            //     ),
            //     const SizedBox(
            //       height: 160,
            //     ),
            //     ElevatedButton(
            //         style: ElevatedButton.styleFrom(
            //             padding: const EdgeInsets.symmetric(
            //                 horizontal: 110, vertical: 10),
            //             backgroundColor: Colors.blue.shade900),
            //         onPressed: () {
            //           Navigator.of(context).pushNamed('/');
            //         },
            //         child: const Text(
            //           "Let's Get Started",
            //           style: TextStyle(color: Colors.white, fontSize: 17),
            //         )),
            //     const SizedBox(
            //       height: 10,
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
