import 'package:equatable/equatable.dart';

class MainUser extends Equatable {
  final String name;
  final String email;
  final String photo;
  final String created;

  const MainUser(
      {required this.name,
      required this.email,
      required this.photo,
      required this.created});

  @override
  List<Object?> get props => [name, email, photo, created];
}
