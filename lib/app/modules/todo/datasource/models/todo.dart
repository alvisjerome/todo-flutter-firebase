import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final String? id;
  final String? title;
  final String? description;
  final DateTime? dateTime;

  const Todo({this.id, this.title, this.description, this.dateTime});

  static Todo fromMap(
      {required String id, required Map<String, dynamic>? map}) {
    return Todo(
      id: id,
      title: map?['title'],
      description: map?['description'],
      dateTime: map?['dateTime'] != null
          ? (map?['dateTime'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toMap({idRequired = false}) {
    return {
      if (idRequired) 'id': id,
      'title': title,
      'description': description,
      'dateTime': dateTime,
    };
  }

  Todo copyWith(
      {String? id, String? title, String? description, DateTime? dateTime}) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  @override
  String toString() {
    return 'Todo{id: $id, title: $title, description: $description, dateTime: $dateTime}';
  }

  @override
  List<Object?> get props => [id, title, description, dateTime];
}
