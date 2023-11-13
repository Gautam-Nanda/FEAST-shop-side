import 'package:flutter/material.dart';
import 'package:storeapp/screens/allorders.dart';
import 'package:storeapp/screens/home.dart';
import 'package:storeapp/screens/login.dart';
import 'package:storeapp/screens/trade.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Inter',
        primarySwatch: Colors.orange,
      ),
      home: LoginScreen(),
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
        TradeScreen.routeName: (context) => const TradeScreen(),
        AllOrders.routeName: (context) => const AllOrders(),
      },
    );
  }
}