import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_books/Helper/FireStorageHelper.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StoreHelper {
  StoreHelper._();
  static final StoreHelper storeHelper = StoreHelper._();

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  CollectionReference? collectionReference;
  connectCollection() {
    collectionReference = fireStore.collection('books');
  }

  Future<void> addBook(
      {required String book,
      required String author,
      required String image}) async {
    connectCollection();
    String bId = DateTime.now().millisecondsSinceEpoch.toString();
    FirebaseStorageHelper.firebaseStorageHelper
        .uploadFile(imagePath: image, bId: bId);

    String imagePath =
        "https://firebasestorage.googleapis.com/v0/b/fir-books-22.appspot.com/o/food.jpg?alt=media&token=1e43258f-27ee-49d4-b94b-b88a35485e56";
    await collectionReference!
        .doc(bId)
        .set({
          'id': bId,
          'book': book,
          'author': author,
          'image': imagePath,
        })
        .then(
          (value) => print("books is add...."),
        )
        .catchError((error) => print("$error"));
  }

  Stream<QuerySnapshot<Object?>> getBooks() {
    connectCollection();

    return collectionReference!.snapshots();
  }

  editBooks({required String id, required Map<Object, Object> data}) {
    connectCollection();

    collectionReference!
        .doc(id)
        .update(data)
        .then((value) => print("books Edit..."))
        .catchError((error) => print(error));
  }

  removeBooks({required String id}) {
    connectCollection();

    collectionReference!
        .doc(id)
        .delete()
        .then((value) => print("notes delete.."))
        .catchError((error) {
      print(error);
    });
  }
}
