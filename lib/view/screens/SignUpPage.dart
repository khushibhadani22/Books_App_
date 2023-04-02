import 'package:flutter/material.dart';

import '../../Helper/FireBaseAuthHelper.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  String? email;
  String? password;
  String? name;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                  key: signUpFormKey,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              "Create an account\nLet's get Started!",
                              style: TextStyle(
                                  color: Colors.blue.shade900,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Enter your name first......";
                            }
                            return null;
                          },
                          onSaved: (val) {
                            setState(() {
                              name = nameController.text;
                            });
                          },
                          controller: nameController,
                          keyboardType: TextInputType.name,
                          style: TextStyle(color: Colors.blue.shade900),
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              hintText: "Name",
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                              ),
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.blue.shade900,
                              )),
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
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(color: Colors.blue.shade900),
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              hintText: "Email or Phone",
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                              ),
                              prefixIcon: Icon(
                                Icons.person,
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
                          obscureText: true,
                          style: TextStyle(color: Colors.blue.shade900),
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              hintText: "password",
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                              ),
                              suffixIcon: const Icon(
                                Icons.remove_red_eye_outlined,
                                color: Colors.grey,
                              ),
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.blue.shade900,
                              )),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue.shade900,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 145, vertical: 10)),
                            onPressed: () async {
                              if (signUpFormKey.currentState!.validate()) {
                                signUpFormKey.currentState!.save();

                                Map<String, dynamic> res =
                                    await AuthHelper.authHelper.signUp(
                                        name: name!,
                                        email: email!,
                                        password: password!);

                                if (res['user'] != null) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content:
                                        const Text("Sign Up Successful....."),
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: Colors.blue.shade900,
                                  ));
                                } else if (res['error'] != null) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(res['error']),
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: Colors.blue.shade900,
                                  ));
                                } else {
                                  Navigator.of(context).pop();

                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: const Text("Sign Up Failed....."),
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: Colors.blue.shade900,
                                  ));
                                }
                                Navigator.of(context).pop();
                              }
                              setState(() {
                                emailController.clear();
                                nameController.clear();
                                passwordController.clear();
                                email = null;
                                password = null;
                                name = null;
                              });
                            },
                            child: const Text(
                              "Sign up",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            )),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already have an account? ",
                                style: TextStyle(color: Colors.blue.shade900),
                              ),
                              Text(
                                "Log In",
                                style: TextStyle(
                                    color: Colors.blue.shade900,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
