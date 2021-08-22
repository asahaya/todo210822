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

  //更新
  void setTitle(String title){
    this.title=title;
    notifyListeners();
  }
  void setAuthor(String author){
    this.author=author;
    notifyListeners();
  }


  bool isUpdated(){
    return title!=null || author!=null;
  }

  Future updateList() async {

    this.title=titleCon.text;
    this.author=authorCon.text;
    //FireStoreに追加処理（Writing)かきこ
    await FirebaseFirestore.instance.collection("todo").doc(koutei.id).update({
      "title": title,
      "author": author,
    });
  }
}
