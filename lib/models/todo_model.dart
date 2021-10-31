class Todo {
  int? id;
  final String title;
  DateTime creationDate;
  bool isChecked;

//create a constructor
Todo(
  {
     this.id,
    required this.title,
    required this.creationDate,
    required this.isChecked,
  }
);
 

 //to save this data to the database we need to convert it to map
 //lets create a function for that.

 Map<String, dynamic> toMap() {
   return {
    'id': id,
    'title': title,
    'creationDate': creationDate.toString(), //sqflite database doesnt support the datetime type so we will save it as Text
    'isChecked': isChecked ? 1 : 0,
   };
 }

 //this function is for debugging only
  @override
  String toString() {
    return 'Todo(id : $id, title : $title, creationDate : $creationDate, isChecked : $isChecked)';
  }

}