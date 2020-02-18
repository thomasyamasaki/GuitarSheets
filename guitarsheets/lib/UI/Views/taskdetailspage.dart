//Thomas Yamasaki
//Comp 499
//Dart file for view showing details of a task

import 'package:flutter/material.dart';
import 'package:guitarsheets/DB/Database.dart';
import 'package:guitarsheets/DB/TaskModel.dart';

class TaskDetailsPage extends StatefulWidget {
  final Task task;

  TaskDetailsPage({Key key, @required this.task}) : super(key: key);

  @override 
  _TaskDetailState createState() => _TaskDetailState(task);
}

class _TaskDetailState extends State<TaskDetailsPage> {
  Task task;

  _TaskDetailState(Task task) {
    this.task = task;
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Task Details')),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget> [
            Text(task.taskTitle + '\n',
              //textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            Text('Song:',
              //textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20)
            ),
            Text(task.song + '\n',
              style: TextStyle(fontSize: 20),
            ),
            Text('Description: ',
              //textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
            Text(task.taskDescription + '\n',
              style: TextStyle(fontSize: 20),
            ),
            RaisedButton(
              child: Text('Edit Task'),
              onPressed: (){},
            ),
            RaisedButton(
              child: Text('Mark as Complete'),
              onPressed: (){
                DBprovider.db.deleteTask(task.taskID);
                Navigator.pop(context);
              },
            )
          ]
        ),
      )
    );
  }
}