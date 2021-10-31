import 'package:flutter/material.dart';
import 'package:to_do_app_flutter/models/db_model.dart';
import 'package:to_do_app_flutter/models/todo_model.dart';
import '../widgets/user_input.dart';
import '../widgets/todo_list.dart';





class Homepage extends StatefulWidget {
  const Homepage ({ Key? key }) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  var db = DatabaseConnect();
  
  //function to add todo
  void addItem(Todo todo) async {
    await db.insertTodo(todo);
    setState(() {});
  }

  //function to delete todo
  void deleteItem(Todo todo) async {
    await db.deleteTodo(todo);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5EBFF),
      appBar: AppBar(
        title: const Text('Simple todo app'),
      ),
      body: Column(
        children: [
          Todolist(insertFunction: addItem, deleteFunction: deleteItem),
         UserInput(insertFunction: addItem,),
      ],
      ),
    );
  }
}