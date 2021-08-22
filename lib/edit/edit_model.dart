import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo210822/domain/koutei.dart';

class EditModel extends ChangeNotifier {

  final Koutei koutei;
  EditModel(this.koutei){
   titleCon.text=koutei.title;
   authorCon.text=koutei.author;
  }

  final titleCon=TextEditingController();
  final authorCon=TextEditingController();

  String? title;
  String? author;

  Future updateList() async {
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
