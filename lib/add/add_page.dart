import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo210822/list/list_model.dart';

import 'add_model.dart';

class Addpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddModel>(
      create: (_) => AddModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("一覧"),
        ),
        body: Center(
          child: Consumer<AddModel>(builder: (context, model, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "名前",
                  ),
                  onChanged: (text) {
                    model.title = text;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Name",
                  ),
                  onChanged: (text) {
                    model.author = text;
                  },
                ),
                ElevatedButton(
                    onPressed: ()async {
                      //modelのメソッドに移動
                      try {
                        await model.addList();
                        Navigator.of(context).pop(true);
                      } catch (e) {
                        final snackBar=SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(e.toString()));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    child: Text("追加する")),
              ]),
            );
          }),
        ),
      ),
    );
  }
}
