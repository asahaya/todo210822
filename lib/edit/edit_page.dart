import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo210822/domain/koutei.dart';
import 'package:todo210822/edit/edit_model.dart';

class EditPage extends StatelessWidget {
  final Koutei koutei;

  EditPage(this.koutei);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EditModel>(
      create: (_) => EditModel(koutei),
      child: Scaffold(
        appBar: AppBar(
          title: Text("edit"),
        ),
        body: Center(
          child: Consumer<EditModel>(builder: (context, model, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        keyboardType: TextInputType.datetime,
                        controller: model.startTimeCon,
                        decoration: InputDecoration(
                          icon: Icon(Icons.access_time),
                          labelText: "startTime",
                        ),
                        onChanged: (text) {
                          model.setStartTime(text) ;
                        },
                      ),
                    ),
                    // TextFormField(
                    //   controller: model.authorCon,
                    //   decoration: InputDecoration(
                    //     labelText: "Name",
                    //   ),
                    //   onChanged: (text) {
                    //     model.setAuthor(text);
                    //   },
                    // ),
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        controller: model.startTitleCon,
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
                  controller: model.philoCon,
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
                        controller: model.endTimeCon,
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
                        controller: model.endTitleCon,
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
                  controller: model.addTodoCon,
                  decoration: InputDecoration(
                    icon: Icon(Icons.plus_one),
                    labelText: "add",
                  ),
                  onChanged: (text) {
                    model.addTodo = text;
                  },
                ),
                ElevatedButton(
                    onPressed: model.isUpdated()
                        ? () async {
                            //modelのメソッドに移動
                            try {
                              await model.updateList();

                              Navigator.of(context).pop(model.startTitle);
                            } catch (e) {
                              final snackBar = SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(e.toString()),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          }
                        : null,
                    child: Text("更新する")),
              ]),
            );
          }),
        ),
      ),
    );
  }
}
