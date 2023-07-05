import 'package:cloud_firestore/cloud_firestore.dart';

abstract interface class TodoRepository {}

class TodoRepositoryImpl implements TodoRepository {
  final FirebaseFirestore firestore;

  TodoRepositoryImpl({required this.firestore});
}
