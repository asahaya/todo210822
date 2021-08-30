import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddModel extends ChangeNotifier {

  String? startTime;
  String? endTime;
  String? startTitle;
  String? endTitle;
  String? philosophy;
  String? addTodo;
  // DateTime?  createdAt;

  Future addList() async {
    // if (startTitle == null || startTitle!.isEmpty) {
    //   throw "タイトル記入なし";
    // }
    // if (endTitle == null|| endTitle!.isEmpty) {
    //   throw "タイトル記入なし";
    // }
    //FireStoreに追加処理（Writing)かきこ
    await FirebaseFirestore.instance.collection("todo").add({

      "startTime":startTime,
      "startTitle":startTitle,
      "endTime":startTime,
      "endTitle":startTitle,
      "philosophy":philosophy,
      "addTodo":addTodo,
      "createdAt":Timestamp.now(),
    });

  }
}
