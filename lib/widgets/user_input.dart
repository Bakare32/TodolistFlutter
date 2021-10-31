import 'package:flutter/material.dart';
import '../models/todo_model.dart';

class UserInput extends StatelessWidget {
  final textController = TextEditingController();
  final Function insertFunction;  //this will receive the additem function
  UserInput({ required this.insertFunction, Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      // color: const Color(0xFFDAB5FF),
      child: Row(
        children: [
          Expanded(child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
             border: Border.all(color: Colors.black45),
             borderRadius: BorderRadius.circular(15),
            ),
            child: TextField(
              controller: textController,
              decoration: const InputDecoration(
                hintText: 'add new todo',
                border: InputBorder.none,
              ),
            ),
            ),
            ),
          SizedBox(width: 10),
          //this will be button
          GestureDetector(onTap: (){
            //create a todo
            var myTodo = Todo(
              title: textController.text,
              creationDate: DateTime.now(),
              isChecked: false);
              insertFunction(myTodo);
          }, 
          child: Container(
            decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(15),
            ),
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 18),
            child: const Text('Add',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),),
            ),
            ),
        ],
      ),
    );
  }
}