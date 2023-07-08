import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MainUser extends Equatable {
  final String? name;
  final String? email;
  final String? photo;
  final DateTime? created;

  const MainUser(
      {required this.name,
      required this.email,
      required this.photo,
      required this.created});

  factory MainUser.fromUser(User? user) {
    return MainUser(
        name: user?.displayName,
        email: user?.email,
        photo: user?.photoURL,
        created: user?.metadata.creationTime);
  }

  factory MainUser.fromMap(Map<String, dynamic> map) {
    return MainUser(
        name: map["name"],
        email: map["email"],
        photo: map["photo"],
        created: map["created"]);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'photo': photo,
      'created': created,
    };
  }

  MainUser copyWith(
      {String? name, String? email, String? photo, DateTime? created}) {
    return MainUser(
        name: name ?? this.name,
        email: email ?? this.email,
        photo: photo ?? this.photo,
        created: created ?? this.created);
  }

  @override
  String toString() {
    return 'MainUser{name: $name, email: $email, photo: $photo, created: $created}';
  }

  @override
  List<Object?> get props => [name, email, photo, created];
}
