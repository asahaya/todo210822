import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo210822/list/list_page.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "list",
      home: HomeList(),
    );
  }
}
