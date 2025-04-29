import 'package:auto_route/auto_route.dart';
import 'package:battle_gender/app/router/app_router.dart';
import 'package:battle_gender/shared/widgets/button/button_main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final _appRouter = AppRouter();
  runApp(MyApp(router: _appRouter));
}

class MyApp extends StatelessWidget {
  final AppRouter router;
  const MyApp({super.key, required this.router});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      routerConfig: router.config(),
    );
  }
}

@RoutePage()
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/battle_gender_1.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ButtonMain(
                  text: "Новая игра",
                  onPressed: () {
                    context.pushRoute(const RouteAddingNewGame());
                  }),
            ],
          ),
        ],
      ),
    );
  }
}
