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
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                          icon: Icon(Icons.access_time),
                          labelText: "startTime",
                        ),
                        onChanged: (text) {
                          model.startTime = text;
                        },
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: TextFormField(

                        decoration: InputDecoration(
                          icon: Icon(Icons.place),
                          labelText: "title",
                        ),
                        onChanged: (text) {
                          model.startTitle = text;
                        },
                      ),
                    ),
                  ],
                ),
                TextFormField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.directions_walk_rounded),
                    labelText: "tool",
                  ),
                  onChanged: (text) {
                    model.philosophy = text;
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                          icon: Icon(Icons.access_time),
                          labelText: "endTime",
                        ),
                        onChanged: (text) {
                          model.endTime = text;
                        },
                      ),
                    ),

                    Expanded(
                      flex: 2,
                      child: TextFormField(

                        decoration: InputDecoration(
                          icon: Icon(Icons.place),
                          labelText: "title",
                        ),
                        onChanged: (text) {
                          model.endTitle = text;
                        },
                      ),
                    ),
                  ],
                ),
                TextFormField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.plus_one),
                    labelText: "add",
                  ),
                  onChanged: (text) {
                    model.addTodo = text;
                  },
                ),
                ElevatedButton(
                    onPressed: () async {
                      //modelのメソッドに移動
                      try {
                        await model.addList();

                        Navigator.of(context).pop(true);
                      } catch (e) {
                        final snackBar = SnackBar(
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
