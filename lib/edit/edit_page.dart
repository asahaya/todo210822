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
                TextFormField(
                  controller: model.titleCon,
                  decoration: InputDecoration(
                    labelText: "名前",
                  ),
                  onChanged: (text) {
                    model.setTitle(text);
                  },
                ),
                TextFormField(
                  controller: model.authorCon,
                  decoration: InputDecoration(
                    labelText: "Name",
                  ),
                  onChanged: (text) {
                    model.setAuthor(text);
                  },
                ),
                ElevatedButton(
                    onPressed: model.isUpdated()
                        ? () async {
                            //modelのメソッドに移動
                            try {
                              await model.updateList();

                              Navigator.of(context).pop(model.title);
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
