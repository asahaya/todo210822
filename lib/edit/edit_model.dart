import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo210822/domain/koutei.dart';

class EditModel extends ChangeNotifier {

  final Koutei koutei;
  EditModel(this.koutei){

   startTimeCon.text=koutei.startTime;
   startTitleCon.text=koutei.startTitle;
   endTimeCon.text=koutei.endTime;
   endTitleCon.text=koutei.endTitle;
   philoCon.text=koutei.philosophy;
   addTodoCon.text=koutei.addTodo;
  }


  final startTimeCon=TextEditingController();
  final startTitleCon=TextEditingController();
  final endTimeCon=TextEditingController();
  final endTitleCon=TextEditingController();
  final philoCon=TextEditingController();
  final addTodoCon=TextEditingController();



  String? startTime;
  String? endTime;
  String? startTitle;
  String? endTitle;
  String? philosophy;
  String? addTodo;
  // DateTime? createdAt;

  //更新

  void setStartTime(String startTime){
    this.startTime=startTime;
    notifyListeners();
  }
  void setStartTitle(String startTitle){
    this.startTitle=startTitle;
    notifyListeners();
  }
  void setEndTime(String endTime){
    this.endTime=endTime;
    notifyListeners();
  }
  void setEndTitle(String endTitle){
    this.endTitle=endTitle;
    notifyListeners();
  }
  void setPhilosophy(String philosophy){
    this.philosophy=philosophy;
    notifyListeners();
  }
  void setAddTodo(String addTodo){
    this.addTodo=addTodo;
    notifyListeners();
  }


  bool isUpdated(){
    return
        startTime!=null
        || startTitle!=null
        || endTime!=null
        || endTitle!=null
        || philosophy!=null
        || addTodo!=null;
  }

  Future updateList() async {


    this.startTime=startTimeCon.text;
    this.startTitle=startTitleCon.text;
    this.endTime=endTimeCon.text;
    this.endTitle=endTitleCon.text;
    this.philosophy=philoCon.text;
    this.addTodo=addTodoCon.text;

    //FireStoreに追加処理（Writing)かきこ
    await FirebaseFirestore.instance.collection("todo").doc(koutei.id).update({

      "startTime":startTime,
      "startTitle":startTitle,
      "endTime":endTime,
      "endTitle":endTitle,
      "philosophy":philosophy,
      "addTodo":addTodo,
      // "createdAt":Timestamp.now(),
    });
  }
}
