import 'package:flutter/material.dart';
import 'package:guitarsheets/DB/Database.dart';
import 'package:guitarsheets/DB/TaskModel.dart';
import 'package:guitarsheets/UI/Forms/taskform.dart';

class HomePage extends StatefulWidget{
  @override 
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: DBprovider.db.getAllTasks(),
        builder: (BuildContext context, AsyncSnapshot<List<Task>> todoList) {
          if (todoList.hasData) {
            return new Column(
              children: <Widget>[
                Text('To-do List', 
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                new RaisedButton(
                  child: Text('Add new Task'),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => TaskForm()));
                  }),
                new Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                    itemCount: todoList.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      Task task = todoList.data[index];
                      return new RaisedButton(
                        child: Text(task.taskTitle),
                        onPressed: () {}
                      );
                    }
                  )
                )
              ]
            );
          }
          else {
            return Center(child: CircularProgressIndicator());
          }
        },
      )
    );
  }
}