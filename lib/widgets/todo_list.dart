import 'package:flutter/material.dart';
import 'package:path/path.dart';
import '../models/db_model.dart';
import './todo_cards.dart';


class Todolist extends StatelessWidget {
  //create an object of databae connect
  final Function insertFunction;
  final Function deleteFunction;

  final db = DatabaseConnect();
  Todolist({ required this.insertFunction,required this.deleteFunction,Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
        future: db.getTodo(),
        initialData: const [],
        builder: (BuildContext context, AsyncSnapshot<List> snapshot){
          var data = snapshot.data;
          var dataLength = data!.length;

          return dataLength == 0 
          ? const Center(
            child: Text('no data found'),
          ) 
          : ListView.builder(itemCount: dataLength, itemBuilder: (context, i) => Todocard(
            id: data[i].id, 
            title: data[i].title, 
            creationDate: data[i].creationDate, 
            isChecked: data[i].isChecked, 
            insertFunction: insertFunction, 
            deleteFunction: deleteFunction,
            ),
            );
        },
      ),
    );
  }
}