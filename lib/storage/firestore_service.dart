import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:main/pages/Furniture.dart';
import 'package:main/pages/FurnitureModel.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // add all furniture from sqlite database to firestore
  Future<void> replaceFirestoreWithSqlite() async {
    List furnitureList = [];
    FurnituresModel furnitureModel = FurnituresModel();

    try {
      furnitureList = await furnitureModel.getAllFurnitures();
      final CollectionReference<Map<String, dynamic>> furnitureCollection =
          _firestore.collection('furniture');

      // get and delete firestore db
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await furnitureCollection.get();

      for (QueryDocumentSnapshot<Map<String, dynamic>> doc
          in querySnapshot.docs) {
        await doc.reference.delete();
      }

      // add sqlite furniture list to firestore db
      final List<Future<void>> futures = [];
      for (final furniture in furnitureList) {
        futures.add(furnitureCollection.add(furniture.toMap()));
        print(furniture);
      }

      await Future.wait(futures);
    } catch (e) {
      print('Error adding tasks: $e');
    }
  }

  // returns list of furniture from firestore db
  Future<List> getAllFurnitureFromFirestore() async {
    List furnitureList = [];

    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firestore.collection('furniture').get();

      querySnapshot.docs.forEach((doc) {
        Furniture furnitureData = Furniture.fromMap(doc.data());
        furnitureList.add(furnitureData);
      });

      return furnitureList;
    } catch (e) {
      print('Error retrieving users from Firestore: $e');
      return furnitureList; // Return an empty list or handle the error as needed
    }
  }

  // deletes sqlite db and inserts data from firestore to db
  void replaceSqliteWithFirestore() async {
    FirestoreService firestoreService = FirestoreService();
    FurnituresModel furnitureModel = FurnituresModel();

    // Retrieve furniture from Firestore
    List firestoreFurniture =
        await firestoreService.getAllFurnitureFromFirestore();

    // delete sqlite furniture db
    await furnitureModel.deleteDatabase();
    // Insert new data from Firestore
    for (int i = 0; i < firestoreFurniture.length; i++) {
      await furnitureModel.insertFurniture(firestoreFurniture[i]);
    }
  }
}
