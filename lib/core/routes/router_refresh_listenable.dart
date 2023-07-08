import 'dart:async';

import 'package:flutter/foundation.dart';

class RouterRefreshListenable extends ChangeNotifier {
  late final StreamSubscription subscription;

  RouterRefreshListenable(Stream stream) {
    notifyListeners();
    subscription = stream.asBroadcastStream().listen(
          (_) => notifyListeners(),
        );
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
}
