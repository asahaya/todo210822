import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddModel extends ChangeNotifier {
  String? title;
  String? author;

  Future addList() async {
    if (title == null || title!.isEmpty) {
      throw "タイトル記入なし";
    }
    if (author == null|| author!.isEmpty) {
      throw "タイトル記入なし";
    }
    //FireStoreに追加処理（Writing)かきこ
    await FirebaseFirestore.instance.collection("todo").add({
      "title": title,
      "author": author,
    });
  }
}
