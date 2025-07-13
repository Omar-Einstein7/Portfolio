import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreInterceptor {
  void onRequest(String collection, String? documentId, Map<String, dynamic>? data) {
    print('Request to collection: $collection, documentId: $documentId');
    if (data != null) print('Request data: $data');
  }

  void onResponse(dynamic response) {
    print('Response received: $response');
  }

  void onError(dynamic error) {
    print('Error occurred: $error');
  }
}

class FirestoreClient {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirestoreInterceptor _interceptor;

  FirestoreClient({FirestoreInterceptor? interceptor}) 
      : _interceptor = interceptor ?? FirestoreInterceptor();

  // GET METHOD
  Future<DocumentSnapshot> getDocument(String collection, String documentId) async {
    try {
      _interceptor.onRequest(collection, documentId, null);
      final DocumentSnapshot document = 
          await _firestore.collection(collection).doc(documentId).get();
      _interceptor.onResponse(document);
      return document;
    } catch (e) {
      _interceptor.onError(e);
      rethrow;
    }
  }

  Future<QuerySnapshot> getCollection(
    String collection, {
    Query Function(Query)? queryBuilder,
  }) async {
    try {
      _interceptor.onRequest(collection, null, null);
      Query query = _firestore.collection(collection);
      if (queryBuilder != null) {
        query = queryBuilder(query);
      }
      final response = await query.get();
      _interceptor.onResponse(response);
      return response;
    } catch (e) {
      _interceptor.onError(e);
      rethrow;
    }
  }

  // CREATE/POST METHOD
  Future<DocumentReference> addDocument(
    String collection,
    Map<String, dynamic> data,
  ) async {
    try {
      _interceptor.onRequest(collection, null, data);
      final response = await _firestore.collection(collection).add(data);
      _interceptor.onResponse(response);
      return response;
    } catch (e) {
      _interceptor.onError(e);
      rethrow;
    }
  }

  Future<void> setDocument(
    String collection,
    String documentId,
    Map<String, dynamic> data, {
    bool merge = true,
  }) async {
    try {
      _interceptor.onRequest(collection, documentId, data);
      await _firestore
          .collection(collection)
          .doc(documentId)
          .set(data, SetOptions(merge: merge));
      _interceptor.onResponse('Document set successfully');
    } catch (e) {
      _interceptor.onError(e);
      rethrow;
    }
  }

  // UPDATE/PUT METHOD
  Future<void> updateDocument(
    String collection,
    String documentId,
    Map<String, dynamic> data,
  ) async {
    try {
      _interceptor.onRequest(collection, documentId, data);
      await _firestore.collection(collection).doc(documentId).update(data);
      _interceptor.onResponse('Document updated successfully');
    } catch (e) {
      _interceptor.onError(e);
      rethrow;
    }
  }

  // DELETE METHOD
  Future<void> deleteDocument(String collection, String documentId) async {
    try {
      _interceptor.onRequest(collection, documentId, null);
      await _firestore.collection(collection).doc(documentId).delete();
      _interceptor.onResponse('Document deleted successfully');
    } catch (e) {
      _interceptor.onError(e);
      rethrow;
    }
  }

  // BATCH OPERATIONS
  Future<void> batchOperation(Future<void> Function(WriteBatch batch) operations) async {
    final WriteBatch batch = _firestore.batch();
    try {
      _interceptor.onRequest('batch', null, null);
      await operations(batch);
      await batch.commit();
      _interceptor.onResponse('Batch operation completed successfully');
    } catch (e) {
      _interceptor.onError(e);
      rethrow;
    }
  }

  // REAL-TIME UPDATES
  Stream<DocumentSnapshot> documentStream(String collection, String documentId) {
    _interceptor.onRequest(collection, documentId, null);
    return _firestore.collection(collection).doc(documentId).snapshots().map((event) {
      _interceptor.onResponse(event);
      return event;
    }).handleError((error) {
      _interceptor.onError(error);
      throw error;
    });
  }

  Stream<QuerySnapshot> collectionStream(
    String collection, {
    Query Function(Query)? queryBuilder,
  }) {
    _interceptor.onRequest(collection, null, null);
    Query query = _firestore.collection(collection);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    return query.snapshots().map((event) {
      _interceptor.onResponse(event);
      return event;
    }).handleError((error) {
      _interceptor.onError(error);
      throw error;
    });
  }
}