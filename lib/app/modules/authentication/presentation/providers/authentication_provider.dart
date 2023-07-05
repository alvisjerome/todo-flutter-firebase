import 'package:flutter/material.dart';

import '../../../../../injection_container.dart';
import '../../datasource/repositories/authentication_repository.dart';

class AuthenticationProvider with ChangeNotifier {
  final authenticationRepository = sl<AuthenticationRepository>();
}
