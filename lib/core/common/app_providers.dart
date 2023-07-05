import 'package:provider/provider.dart';

import '../../app/modules/authentication/presentation/providers/authentication_provider.dart';
import '../../app/modules/todo/presentation/providers/todo_provider.dart';

final class AppProviders {
  static final providers = [
    ChangeNotifierProvider<AuthenticationProvider>(
      create: (_) => AuthenticationProvider(),
    ),
    ChangeNotifierProvider<TodoProvider>(
      create: (_) => TodoProvider(),
    ),
  ];
}
