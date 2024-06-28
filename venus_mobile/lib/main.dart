import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thebags_mobile/models/cart.dart';
import 'package:thebags_mobile/routers/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return CartModel();
      },
      child: MaterialApp.router(
        title: 'Venus Restaurant',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routerConfig: router(),
      ),
    );
  }
}
