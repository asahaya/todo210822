import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo210822/domain/koutei.dart';
import 'package:todo210822/list/domain/koutei.dart';

class HomeListModel extends ChangeNotifier {
  final _userColl = FirebaseFirestore.instance.collection("todo");

  List<Koutei>? koutei;

  void tsuikaList() async {
    final QuerySnapshot snapshot = await _userColl.orderBy("createdAt",descending: false).get();

    final List<Koutei> koutei = snapshot.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

      final String id = document.id;
      final String startTime = data["startTime"];
      final String startTitle = data["startTitle"];
      final String endTime = data["endTime"];
      final String endTitle = data["endTitle"];
      final String philosophy = data["philosophy"];
      final String addTodo = data["addTodo"];
      final Timestamp createdAt = data["createdAt"];
      final String? imgURL = data["imageURL"];

      return Koutei(id, startTime, startTitle, endTime, endTitle, philosophy,
          addTodo,imgURL);
    }).toList();

    this.koutei = koutei;
    notifyListeners();
  }

  void irekae(int oldIndex, int newIndex,items){

    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final int item = items.removeAt(oldIndex);
    items.insert(newIndex, item);
    notifyListeners();
  }



  Future delete(Koutei koutei) {
    return FirebaseFirestore.instance
        .collection("todo")
        .doc(koutei.id)
        .delete();
  }

  // void irekae() async{
  //   final QuerySnapshot snapshot = await _userColl.get();
  //   FirebaseFirestore.instance
  //       .collection("todo")
  //       .get();

    //   FirebaseFirestore.instance
    //       .collection("todo")
    //       .orderBy("createdAt", descending: true).get();


  //     this.koutei=koutei;
  //     notifyListeners();
  // }
}
