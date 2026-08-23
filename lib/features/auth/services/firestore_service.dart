import 'package:cloud_firestore/cloud_firestore.dart';

import 'database_service.dart';

class FireStoreService implements DatabaseService {
  // The code below comes from the official docs of cloud firestore
  // Creating an instance of firestore
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Future<void> addData(
      {required String path,
      required Map<String, dynamic> data,
      String? documentId}) async {
    if (documentId != null) {
      await firestore
          .collection(path)
          .doc(documentId)
          .set(data); // set is used to add data
    } else {
      // Accessing the collection then adding the data
      await firestore.collection(path).add(data);
    }
  }

  @override
  Future<dynamic> getData({
    required String path,
    String? documentId,
    // used to filter the data we will filter products based on these query parameters
    Map<String, dynamic>? query,
  }) async {
    // Accessing the collection then the document of a specific userId then getting the data
    if (documentId != null) {
      var data = await firestore.collection(path).doc(documentId).get();
      return data.data() as Map<String, dynamic>;
    } else {
      // I convert the return of this method from collectionReference to Query<Map<String, dynamic>> to be able to do operations on it like orderBy and limit
      Query<Map<String, dynamic>> data = firestore.collection(path);
      if (query != null) {
        if (query['orderBy'] != null) {
          var orderByField = query['orderBy'];
          var descending = query['descending'];
          data = data.orderBy(orderByField, descending: descending);
        }

        if (query['Limit'] != null) {
          var limit = query['Limit'];
          data = data.limit(limit);
        }

        var result = await data.get();
        return result.docs
            .map(
              (e) => e.data(),
            )
            .toList();
      }
    }
  }

  @override
  Future<bool> checkIfDataExists(
      {required String path, required String documentId}) async {
    var data = await firestore.collection(path).doc(documentId).get();
    return data.exists;
  }
}
