import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../core/enums/collections_enum.dart';
import '../models/todo.dart';

abstract interface class TodoRepository {
  Stream<List<Todo>> getTodos();
  Future<String> addTodo(Todo todo);
  Future<void> updateTodo(Todo todo);
  Future<void> deleteTodo(String todoId);
}

class TodoRepositoryImpl implements TodoRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;
  late final CollectionReference _todosCollection;

  TodoRepositoryImpl({required this.firestore, required this.firebaseAuth}) {
    _todosCollection = firestore
        .collection(CollectionEnum.users.name)
        .doc(firebaseAuth.currentUser?.uid)
        .collection(CollectionEnum.todos.name);
  }

  @override
  Stream<List<Todo>> getTodos() {
    return _todosCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>?;
        return Todo.fromMap(id: doc.id, map: data);
      }).toList();
    });
  }

  @override
  Future<String> addTodo(Todo todo) async {
    final docRef = await _todosCollection.add(todo.toMap());
    return docRef.id;
  }

  @override
  Future<void> updateTodo(Todo todo) async {
    final docRef = _todosCollection.doc(todo.id);
    return await docRef.update(todo.toMap());
  }

  @override
  Future<void> deleteTodo(String todoId) async {
    final docRef = _todosCollection.doc(todoId);
    return await docRef.delete();
  }
}
