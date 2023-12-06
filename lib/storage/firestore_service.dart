import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Example: Create a reference to a collection
  CollectionReference<Map<String, dynamic>> getExampleCollection() {
    return _firestore.collection('example_collection');
  }

  CollectionReference<Map<String, dynamic>> getUsersCollection() {
    return _firestore.collection('users');
  }

  // Example: Create a reference to a document
  DocumentReference<Map<String, dynamic>> getDocumentReference(String documentId) {
    return _firestore.collection('example_collection').doc(documentId);
  }

  Future<void> addUser(String name, String email, int age, bool isAdmin) async {
    try {
      await _firestore.collection('users').add({
        'name': name,
        'email': email,
        'age': age,
        'isAdmin': isAdmin,
      });
    } catch (e) {
      print('Error adding user: $e');
    }
  }
}