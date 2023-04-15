import 'dart:typed_data';

import 'package:firebase_books/Helper/FireStoreHelper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  void onTapItem(int i) {
    setState(() {
      index = i;
    });
  }

  List data = [];

  String? book;
  String? authorName;
  Uint8List? image;
  GlobalKey<FormState> insertFormKey = GlobalKey();

  TextEditingController bookController = TextEditingController();
  TextEditingController authorController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue.shade900,
          title: const Text(
            "BookStore",
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.more_vert,
                  color: Colors.white,
                  size: 20,
                ))
          ],
          centerTitle: true,
        ),
        bottomNavigationBar: Container(
          height: 60,
          width: double.infinity,
          color: Colors.blue.shade50,
          child: BottomNavigationBar(
            type: BottomNavigationBarType.shifting,
            selectedItemColor: Colors.blue.shade900,
            iconSize: 25,
            selectedLabelStyle: TextStyle(
                color: Colors.blue.shade900, fontWeight: FontWeight.bold),
            onTap: onTapItem,
            currentIndex: index,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: const Icon(
                    Icons.home_outlined,
                    color: Colors.black,
                  ),
                  activeIcon: Icon(
                    Icons.home_outlined,
                    color: Colors.blue.shade900,
                  ),
                  label: "Home"),
              BottomNavigationBarItem(
                  icon: const Icon(
                    Icons.category_outlined,
                    color: Colors.black,
                  ),
                  activeIcon: Icon(
                    Icons.category_outlined,
                    color: Colors.blue.shade900,
                  ),
                  label: "Category"),
              BottomNavigationBarItem(
                  icon: const Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  activeIcon: Icon(
                    Icons.search,
                    color: Colors.blue.shade900,
                  ),
                  label: "Search"),
              BottomNavigationBarItem(
                  icon: const Icon(
                    Icons.bookmark_outline,
                    color: Colors.black,
                  ),
                  activeIcon: Icon(
                    Icons.bookmark_outline,
                    color: Colors.blue.shade900,
                  ),
                  label: "BookMark"),
              BottomNavigationBarItem(
                  icon: const Icon(
                    Icons.settings,
                    color: Colors.black,
                  ),
                  activeIcon: Icon(
                    Icons.settings,
                    color: Colors.blue.shade900,
                  ),
                  label: "Settings"),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue.shade900,
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Center(
                      child: Text(
                        "Insert Books",
                        style: TextStyle(
                            color: Colors.blue.shade900,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    content: Form(
                      key: insertFormKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Enter First Book Name....";
                              }
                              return null;
                            },
                            onSaved: (val) {
                              setState(() {
                                book = val!;

                                bookController.text;
                              });
                            },
                            controller: bookController,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                label: const Text("Book Name"),
                                labelStyle:
                                    TextStyle(color: Colors.blue.shade900),
                                hintText: "Enter First Book Name..."),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Enter First Author Name....";
                              }
                              return null;
                            },
                            onSaved: (val) {
                              setState(() {
                                authorName = val!;

                                authorController.text;
                              });
                            },
                            textInputAction: TextInputAction.done,
                            controller: authorController,
                            decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                label: const Text("Author Name"),
                                labelStyle:
                                    TextStyle(color: Colors.blue.shade900),
                                hintText: "Enter First Author Name..."),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue.shade900),
                              onPressed: () async {
                                // final ImagePicker picker = ImagePicker();
                                //
                                // // XFile? qFile =
                                // //     await picker.pickImage(source: ImageSource.camera);
                                //
                                // XFile? xFile = await picker.pickImage(
                                //     source: ImageSource.gallery);
                                //
                                // // image = await qFile!.readAsBytes();
                                // image = await xFile!.readAsBytes();
                              },
                              child: const Text(
                                "PICK IMAGE",
                                style: TextStyle(color: Colors.white),
                              )),
                        ],
                      ),
                    ),
                    actions: [
                      OutlinedButton(
                          onPressed: () {
                            bookController.clear();
                            authorController.clear();

                            setState(() {
                              book = null;
                              authorName = null;
                              image = null;
                            });

                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "CLEAR",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue.shade900),
                          )),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue.shade900),
                          onPressed: () async {
                            if (insertFormKey.currentState!.validate()) {
                              insertFormKey.currentState!.save();

                              // Student s1 = Student(
                              //     name: name!,
                              //     age: age!,
                              //     course: course!,
                              //     image: image);
                              // int res = await DBHelper.dbHelper.insert(data: s1);
                              //  if (res > 0) {
                              //    setState(() {
                              //    //  getAllStudents = DBHelper.dbHelper.fetchAllStudents();
                              //    });
                              //    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              //        behavior: SnackBarBehavior.floating,
                              //        backgroundColor: Colors.indigo.shade900,
                              //        content: const Text(
                              //          "Record inserted successfully...",
                              //          style: TextStyle(color: Colors.white),
                              //        )));
                              //  } else {
                              //    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              //        behavior: SnackBarBehavior.floating,
                              //        backgroundColor: Colors.white,
                              //        content: Text(
                              //          "Record insertion failed...",
                              //          style: TextStyle(color: Colors.indigo.shade900),
                              //        )));
                              //  }
                              print("save all");
                            }
                            bookController.clear();
                            authorController.clear();

                            setState(() {
                              book = null;
                              authorName = null;
                              image = null;
                            });
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            "INSERT",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )),
                    ],
                  );
                });
          },
          child: const Icon(Icons.add),
        ),
        body: Center(
          child: StreamBuilder(
            stream: StoreHelper.storeHelper.getBooks(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "Error :- ${snapshot.error} ",
                    style: TextStyle(color: Colors.blue.shade900),
                  ),
                );
              } else if (snapshot.hasData) {
                data = snapshot.data!.docs;
                return ListView.builder(
                  itemBuilder: (context, i) {
                    return Text(data[i]['book']);
                  },
                  itemCount: data.length,
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.blue.shade900,
                    backgroundColor: Colors.blue.shade500,
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
