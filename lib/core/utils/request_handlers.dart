import 'package:equatable/equatable.dart';

class RequestHandlers extends Equatable {
  final void Function([String? message])? onError;
  final void Function()? onLoading;
  final void Function()? onSuccess;

  const RequestHandlers({this.onError, this.onLoading, this.onSuccess});

  @override
  List<Object?> get props => [onError, onLoading, onSuccess];
}
