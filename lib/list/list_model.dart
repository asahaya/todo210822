

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo210822/domain/koutei.dart';
import 'package:todo210822/list/domain/koutei.dart';

class HomeListModel extends ChangeNotifier{

  final _userColl= FirebaseFirestore.instance.collection("todo");

  List<Koutei>? koutei;

  void tsuikaList()async{
    final QuerySnapshot snapshot= await _userColl.get();

    final List<Koutei> koutei= snapshot.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
      final String id= document.id;
      final String title=data["title"];
      final String author=data["author"];
      return Koutei(id,title, author);
    }).toList();

     this.koutei=koutei;
     notifyListeners();
  }

   Future delete(Koutei koutei) {
     return FirebaseFirestore.instance.collection("todo").doc(koutei.id).delete();
   }
}