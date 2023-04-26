import 'dart:typed_data';
import 'package:firebase_books/Helper/FireStoreHelper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
  String? image;
  GlobalKey<FormState> insertFormKey = GlobalKey();
  final ImagePicker picker = ImagePicker();

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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                  onPressed: () async {
                                    XFile? file = await picker.pickImage(
                                        source: ImageSource.camera);
                                    if (file != null) {
                                      setState(() {
                                        image = file.path;
                                      });
                                    }
                                  },
                                  icon: Icon(
                                    Icons.camera,
                                    color: Colors.blue.shade900,
                                  )),
                              IconButton(
                                  onPressed: () async {
                                    XFile? file = await picker.pickImage(
                                        source: ImageSource.gallery);
                                    if (file != null) {
                                      setState(() {
                                        image = file.path;
                                      });
                                    }
                                  },
                                  icon: Icon(
                                    Icons.photo_album_outlined,
                                    color: Colors.blue.shade900,
                                  )),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
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

                              await StoreHelper.storeHelper.addBook(
                                  book: book!,
                                  author: authorName!,
                                  image: image!.toString());
                              image = null;
                              Navigator.of(context).pop();
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
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: data.length,
                  itemBuilder: (context, i) {
                    return Card(
                      elevation: 0,
                      child: ListView(
                        children: [
                          CircleAvatar(
                            radius: 70,
                            foregroundImage: NetworkImage(data[i]['image']),
                          ),
                          Text(data[i]['book']),
                        ],
                      ),
                    );
                    //   StaggeredGrid.count(
                    //   crossAxisCount: 3,
                    //   crossAxisSpacing: 2,
                    //   mainAxisSpacing: 3,
                    //   children: [
                    //     StaggeredGridTile.count(
                    //         crossAxisCellCount: 3,
                    //         mainAxisCellCount: 4,
                    //         child: GestureDetector(
                    //           onTap: () {
                    //             Navigator.of(context).pushNamed('details');
                    //           },
                    //           child: Container(
                    //             margin: const EdgeInsets.all(15),
                    //             padding: const EdgeInsets.all(6),
                    //             decoration: BoxDecoration(
                    //                 border: Border.all(
                    //                     width: 3, color: Colors.blue.shade900)),
                    //             child: Column(
                    //               mainAxisAlignment: MainAxisAlignment.start,
                    //               crossAxisAlignment: CrossAxisAlignment.start,
                    //               children: [
                    //                 Image.asset('assets/image/bookLogo.png'),
                    //                 Column(
                    //                   mainAxisAlignment:
                    //                       MainAxisAlignment.start,
                    //                   crossAxisAlignment:
                    //                       CrossAxisAlignment.start,
                    //                   children: [
                    //                     Text(
                    //                       data[i]['book'],
                    //                       style: TextStyle(
                    //                           color: Colors.blue.shade900,
                    //                           fontWeight: FontWeight.bold),
                    //                     ),
                    //                     Text(
                    //                       data[i]['author'],
                    //                       style: TextStyle(
                    //                           color: Colors.blue.shade900,
                    //                           fontWeight: FontWeight.w500),
                    //                     ),
                    //                   ],
                    //                 ),
                    //               ],
                    //             ),
                    //           ),
                    //         ))
                    //   ],
                    // );
                  },
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
