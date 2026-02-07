import 'package:battle_gender/app/app.dart';
import 'package:battle_gender/app/router/app_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'core/firebase/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final _appRouter = AppRouter();
  runApp(MyApp(router: _appRouter));
}
