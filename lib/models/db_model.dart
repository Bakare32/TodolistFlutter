import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import './todo_model.dart';


class DatabaseConnect{
   Database? _database;

   Future<Database> get database async{
     final dbpath = await getDatabasesPath();

     const dbname = 'todo.db';

     final path = join(dbpath, dbname);
     //open connection
     _database = await openDatabase(path, version: 1, onCreate: _createDB);

     return _database!;
   }

   Future<void> _createDB(Database db, int version) async {
     //make sure the columns we create in our table matches the todo_model field.
     await db.execute('''
         CREATE TABLE todo (
           id INTEGER PRIMARY KEY AUTOINCREMENT,
           title TEXT,
           creationDate TEXT,
           isChecked INTEGER
         )
     ''');
   }

   //function to add data into the database
   Future<void> insertTodo(Todo todo) async {
     //get the connection to database
    final db = await database;
    //insert the todo
    await db.insert(
      'todo', // the name of the table
    todo.toMap(),  //the function we create on our todo_model
    conflictAlgorithm: ConflictAlgorithm.replace, //this will replace the duplicate entry.
    );
   }

   //function to delete data from the database
   Future<void> deleteTodo(Todo todo) async {
     final db = await database;
     //delete the todo from database based on its id.
     await db.delete(
       'todo', 
       where: 'id == ?', //this condition will check for id in the todo list
       whereArgs: [todo.id], 
       );
   }

   //function to fetch all the todo data from our database
   Future<List<Todo>> getTodo() async {
     final db = await database;
     //query the database and save the todo as list of maps
     List<Map<String, dynamic>> items = await db.query(
       'todo', 
     orderBy: 'id DESC', //this will order the list by id in descending order.

     //now convert the items from the list of maps to list of todo
     );
     return List.generate(items.length, (i) => Todo(
       id: items[i]['id'], 
     title: items[i]['title'], 
     creationDate: DateTime.parse(items[i]['creationDate']),
     isChecked: items[i]['isChecked'] == 1 ? true : false,
     ),
     );
   }
}