import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/Presntation/Screens/home_layout.dart';

import 'constant/app_observer.dart';

void main() {
  Bloc.observer = MyBlocObserver();



  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(canvasColor: Colors.grey[200], primarySwatch: Colors.grey),
      debugShowCheckedModeBanner: false,
      home: Layout(),
    );
  }
}
