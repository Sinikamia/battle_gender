import 'package:auto_route/auto_route.dart';
import 'package:battle_gender/button/button_main.dart';
import 'package:flutter/material.dart';

import 'router/app_router.dart';

void main() {
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
    double width = MediaQuery.of(context).size.width;

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
              ButtonMain(onPressed: () {
                context.pushRoute(const RouteAddingNewGame());
              }),
            ],
          ),
        ],
      ),
    );
  }
}
