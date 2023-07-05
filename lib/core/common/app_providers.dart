import '../../app/modules/home/presentation/providers/home_provider.dart';
import 'package:provider/provider.dart';

import '../../app/modules/authentication/providers/authentication_provider.dart';

final class AppProviders {
  static final providers = [
    ChangeNotifierProvider<AuthenticationProvider>(
        create: (_) => AuthenticationProvider()),
    ChangeNotifierProvider<HomeProvider>(create: (_) => HomeProvider()),
  ];
}
