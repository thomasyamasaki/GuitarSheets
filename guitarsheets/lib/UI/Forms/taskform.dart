//Thomas Yamasaki
//Comp 499
//Form for adding a task to the To-do list

import 'package:flutter/material.dart';
import 'package:guitarsheets/DB/TaskModel.dart';
import 'package:guitarsheets/DB/Database.dart';

class TaskForm extends StatefulWidget {
  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final _formKey = GlobalKey<FormState>();
  final _task = Task();

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Task')),
      body: Container(
        padding: 
          const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Builder(
          builder: (context) => Form(
            key:_formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Task Form'),
                TextFormField(decoration: 
                  InputDecoration(labelText: 'Task Title'),
                  onSaved: (val) => setState(() => _task.taskTitle = val)),
                TextFormField(decoration: 
                  InputDecoration(labelText: 'Song'),
                  onSaved: (val) => setState(() => _task.song = val)),
                TextFormField(decoration: 
                  InputDecoration(labelText: 'Description'),
                  onSaved: (val) => setState(() => _task.taskDescription = val)),
                Container(padding: const EdgeInsets.symmetric(
                  vertical: 16.0, horizontal: 16.0),
                  child: RaisedButton(
                    child: Text('Save'),
                    onPressed: () {
                      final form = _formKey.currentState;
                      form.save();
                      DBprovider.db.insertTask(_task);
                      Navigator.pop(context);
                    }),
                ),
                Container(padding: const EdgeInsets.symmetric(
                  vertical: 16.0, horizontal: 16.0),
                  child: RaisedButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                )
              ]
            )
          )
        )
      )
    );
  }
}