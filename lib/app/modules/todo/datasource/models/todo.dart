import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final String? id;
  final String? title;
  final String? description;
  final DateTime? dateTime;

  const Todo({this.id, this.title, this.description, this.dateTime});

  @override
  List<Object?> get props => [id, title, description, dateTime];
}
