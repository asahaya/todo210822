import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo210822/add/add_page.dart';
import 'package:todo210822/domain/koutei.dart';
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
                .map((koutei) => ListTile(
                      title: Text(koutei.title),
                      subtitle: Text(koutei.author),
                    ))
                .toList();
            return ListView(
              children: widget,
            );
          }),
        ),
        floatingActionButton: Consumer<HomeListModel>(builder: (context, model, child) {
            return FloatingActionButton(
              onPressed: () async{
                //画面遷移
                final bool? added=await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Addpage(),
                    fullscreenDialog: true,
                  ),
                );
                if(added!=null  && added){
                  final snackBar=SnackBar(
                      backgroundColor: Colors.green,
                      content: Text("本を追加しました"));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }

                //void なのでawaitはいらない
               model.tsuikaList();
              },
              tooltip: "+",
              child: Icon(Icons.add),
            );
          }
        ),
      ),
    );
  }
}
