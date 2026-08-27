// This class will contain all the methods that will be used to interact with the database => Read, Write, Delete, Update

abstract class DatabaseService {
  Future<void> addData({
    required String path,
    required Map<String, dynamic> data,
    String? documentId,
  });

  Future<dynamic> getData({
    required String path,
    String? documentId,
    Map<String, dynamic>? query,
    Map<String, dynamic>? where,
  });

  Future<bool> checkIfDataExists({
    required String path,
    required String documentId,
  });

  Future<void> updateData({
    required String path,
    required String documentId,
    required Map<String, dynamic> data,
  });

  Future<void> deleteData({
    required String path,
    required String documentId,
  });
}
