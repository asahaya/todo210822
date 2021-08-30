import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo210822/add/add_page.dart';
import 'package:todo210822/domain/koutei.dart';
import 'package:todo210822/edit/edit_page.dart';
import 'package:todo210822/list/domain/koutei.dart';
import 'package:todo210822/list/list_model.dart';

class HomeList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeListModel>(
      create: (_) => HomeListModel()..tsuikaList(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("一覧"),
        ),
        body: Center(
          child: Consumer<HomeListModel>(builder: (context, model, child) {
            final List<Koutei>? koutei = model.koutei;

            if (koutei == null) {
              return CircularProgressIndicator();
            }

            final List<Widget> widget = koutei
                .map((koutei) => Slidable(
                      actionPane: SlidableDrawerActionPane(),
                      child: Card(
                        child: Container(
                          color: Colors.grey,
                          child: SizedBox(
                            height: 100,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      Container(
                                        color: Colors.deepPurpleAccent,
                                        child: Expanded(
                                          flex: 1,
                                          child: Text(
                                            koutei.startTime,
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                          flex: 2, child: Text(koutei.startTime)),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    children: [
                                      Container(
                                        color: Colors.deepPurpleAccent,
                                        child: Expanded(
                                          flex: 1,
                                          child: Text(
                                            koutei.startTime,
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                          flex: 2, child: Text(koutei.startTime)),
                                    ],
                                  ),
                                ),
                                Expanded(flex:1,child: Text(koutei.addTodo)),
                              ],
                            ),
                          ),
                        ),
                        //Text(koutei.title),
                      ),
                      secondaryActions: <Widget>[
                        IconSlideAction(
                          caption: 'edit',
                          color: Colors.blue,
                          icon: Icons.edit,
                          onTap: () async {
                            //編集画面に遷移
                            //画面遷移
                            final String? title = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditPage(koutei),
                              ),
                            );
                            if (title != null) {
                              final snackBar = SnackBar(
                                  backgroundColor: Colors.purpleAccent,
                                  content: Text(" を編集しました"));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                            //void なのでawaitはいらない
                            model.tsuikaList();
                            model.irekae();
                          },
                        ),
                        IconSlideAction(
                          caption: 'Delete',
                          color: Colors.red,
                          icon: Icons.delete,
                          onTap: () async {
                            //削除
                            await showConfirmDialog(context, koutei, model);
                          },
                        ),
                      ],
                    ))
                .toList();
            return ListView(
              children: widget,
            );
          }),
        ),
        floatingActionButton:
            Consumer<HomeListModel>(builder: (context, model, child) {
          return FloatingActionButton(
            onPressed: () async {
              //画面遷移
              final bool? added = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Addpage(),
                  fullscreenDialog: true,
                ),
              );
              if (added != null && added) {
                final snackBar = SnackBar(
                    backgroundColor: Colors.green, content: Text("本を追加しました"));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }

              //void なのでawaitはいらない
              model.tsuikaList();
              model.irekae();
            },
            tooltip: "+",
            child: Icon(Icons.add),
          );
        }),
      ),
    );
  }

  Future showConfirmDialog(
    BuildContext context,
    Koutei koutei,
    HomeListModel model,
  ) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return AlertDialog(
            title: Text("${koutei.startTitle} を削除しますか"),
            content: Text("--"),
            actions: [
              TextButton(
                child: Text("No"),
                onPressed: () => Navigator.pop(context),
              ),
              TextButton(
                child: Text("Yes"),
                onPressed: () async {
                  //modelで削除
                  await model.delete(koutei);

                  Navigator.pop(context);

                  final snackBar = SnackBar(
                      backgroundColor: Colors.deepPurpleAccent,
                      content: Text("${koutei.startTitle} を編集しました"));
                  model.tsuikaList();
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
              ),
            ],
          );
        });
  }
}
