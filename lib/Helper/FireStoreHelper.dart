import 'package:cloud_firestore/cloud_firestore.dart';

class StoreHelper {
  StoreHelper._();
  static final StoreHelper storeHelper = StoreHelper._();

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  CollectionReference? collectionReference;
  connectCollection() {
    collectionReference = fireStore.collection('books');
  }

  Future<void> addNote({required String book, required String author}) async {
    connectCollection();
    String bId = DateTime.now().millisecondsSinceEpoch.toString();
    await collectionReference!
        .doc(bId)
        .set({
          'id': bId,
          'book': book,
          'author': author,
        })
        .then(
          (value) => print("books is add...."),
        )
        .catchError((error) => print("$error"));
  }

  Stream<QuerySnapshot<Object?>> getNotes() {
    connectCollection();

    return collectionReference!.snapshots();
  }

  editUser({required String id, required Map<Object, Object> data}) {
    connectCollection();

    collectionReference!
        .doc(id)
        .update(data)
        .then((value) => print("books Edit..."))
        .catchError((error) => print(error));
  }

  removeNotes({required String id}) {
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
