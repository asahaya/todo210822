import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddModel extends ChangeNotifier {

  String? startTime;
  String? endTime;
  String? startTitle;
  String? endTitle;
  String? philosophy;
  String? addTodo;
  DateTime?  createdAt;
  File? imageFile;

  final picker=ImagePicker();

  Future addList() async {
    // if (startTitle == null || startTitle!.isEmpty) {
    //   throw "タイトル記入なし";
    // }
    // if (endTitle == null|| endTitle!.isEmpty) {
    //   throw "タイトル記入なし";
    // }
    final doc = FirebaseFirestore.instance.collection("todo").doc();

     String? imgURL;

    if(imageFile!=null){
      //Storageにアップロード
     final task= await FirebaseStorage.instance
          .ref("books/${doc.id}")
          .putFile(imageFile!);
       imgURL=await task.ref.getDownloadURL();
    }

    //FireStoreに追加処理（Writing)かきこ
    await doc.set({

      "startTime":startTime,
      "startTitle":startTitle,
      "endTime":endTime,
      "endTitle":endTitle,
      "philosophy":philosophy,
      "addTodo":addTodo,
      "imageURL":imgURL,
      "createdAt":Timestamp.now(),

    });
  }

  Future pickImage() async{
    final pickedFile=await picker.pickImage(source: ImageSource.gallery);
    if(pickedFile==null) {
      imageFile = File(pickedFile!.path);
      notifyListeners();
    }
  }
}
