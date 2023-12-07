import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // TODO: REMOVE LATER Example: Create a reference to a collection
  CollectionReference<Map<String, dynamic>> getExampleCollection() {
    return _firestore.collection('example_collection');
  }

  // TODO: REMOVE LATER
  CollectionReference<Map<String, dynamic>> getUsersCollection() {
    return _firestore.collection('users');
  }

  // TODO: REMOVE LATER, Example: Create a reference to a document
  DocumentReference<Map<String, dynamic>> getDocumentReference(
      String documentId) {
    return _firestore.collection('example_collection').doc(documentId);
  }

  // TODO: Remove, reference sample code
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

  // TODO: remove, reference sample code
  Future<void> addUsers(List<Map<String, dynamic>> users) async {
    try {
      final CollectionReference<Map<String, dynamic>> usersCollection =
          _firestore.collection('users');

      final List<Future<void>> futures = [];
      for (final user in users) {
        futures.add(usersCollection.add(user));
      }

      await Future.wait(futures);
    } catch (e) {
      print('Error adding users: $e');
    }
  }

  // TODO: get rid of this function after using it as a reference.
  // Tasks are not meant to be stored on cloud
  // This function is meant to test connection between db and firestore
  Future<void> addTasks(List tasks) async {
    try {
      final CollectionReference<Map<String, dynamic>> tasksCollection =
          _firestore.collection('tasks');

      final List<Future<void>> futures = [];
      for (final task in tasks) {
        futures.add(tasksCollection.add(task.toMap()));
        print(task);
      }

      // TODO: Testing block, prints what's inside the collection snapshot
      print("all tasks:\n");
      try {
        QuerySnapshot querySnapshot = await tasksCollection.orderBy('name').get();

        if (querySnapshot.docs.isNotEmpty) {
          querySnapshot.docs.forEach((doc) {
            print('Document ID: ${doc.id}');
            print('Data: ${doc.data()}');
            print('-------------');
          });
        } else {
          print('No documents found in the collection.');
        }
      } catch (e) {
        print('Error: $e');
      }

      await Future.wait(futures);
    } catch (e) {
      print('Error adding tasks: $e');
    }
  }
}
