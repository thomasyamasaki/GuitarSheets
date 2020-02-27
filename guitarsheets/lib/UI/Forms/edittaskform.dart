//Thomas Yamasaki
//Comp 499

import 'package:flutter/material.dart';
import 'package:guitarsheets/DB/Database.dart';
import 'package:guitarsheets/DB/TaskModel.dart';

class EditTaskForm extends StatefulWidget {
  final Task task;

  EditTaskForm({Key key, @required this.task}) : super(key: key);

  @override 
  _EditTaskState createState() => _EditTaskState(task);
}

class _EditTaskState extends State<EditTaskForm> {
  final _formKey = GlobalKey<FormState>();
  //final _formController = TextEditingController();
  Task _task;

  _EditTaskState(Task task) {
    this._task = task;
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[700],
      appBar: AppBar(title: Text('Edit Task'),
        backgroundColor: Colors.black,
      ),
      body: Container(
        padding: 
          const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Builder(
          builder: (context) => Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                Text('Edit Task Form'),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Task Title'),
                  //controller: _formController,
                  initialValue: _task.taskTitle,
                  onSaved: (val) => setState(() => _task.taskTitle = val),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Song'),
                  initialValue: _task.song,
                  onSaved: (val) => setState(() => _task.song = val),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Description'),
                  initialValue: _task.taskDescription,
                  onSaved: (val) => setState(() => _task.taskDescription = val),
                ),
                Container(padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: RaisedButton(
                    color: Colors.white,
                    child: Text('Save'),
                    onPressed: () {
                      final form = _formKey.currentState;
                      form.save();
                      DBprovider.db.updateTask(_task);
                      Navigator.pop(context);
                    },
                  ),
                ),
                Container(padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: RaisedButton( 
                    color: Colors.white,
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                )
              ],
            )
          ),
        ),
      )
    );
  }

  /*@override 
  void dispose() {
    _formController.dispose();
    super.dispose();
  }*/
}