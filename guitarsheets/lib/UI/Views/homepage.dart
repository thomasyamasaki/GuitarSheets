import 'package:flutter/material.dart';
import 'package:guitarsheets/DB/Database.dart';
import 'package:guitarsheets/DB/TaskModel.dart';
import 'package:guitarsheets/UI/Forms/taskform.dart';
import 'package:guitarsheets/UI/Views/taskdetailspage.dart';

class HomePage extends StatefulWidget{
  @override 
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Color> _colors = [
    Colors.grey,
    Colors.green
  ];

  int _colorsIndex = 0;

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[700],
      floatingActionButton: 
        FloatingActionButton(child: Icon(Icons.add),
          backgroundColor: Colors.black,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => TaskForm()));
          }
        ),
      body: FutureBuilder(
        future: DBprovider.db.getAllTasks(),
        builder: (BuildContext context, AsyncSnapshot<List<Task>> todoList) {
          if (todoList.hasData) {
            return new Column(
              children: <Widget>[
                Text('To-do List', 
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                /*new RaisedButton(
                  child: Text('Add new Task'),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => TaskForm()));
                  }),*/
                new Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                    itemCount: todoList.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      Task task = todoList.data[index];
                      return Card(
                        color: Colors.grey[100],
                        child: ListTile(
                          title: Text(task.taskTitle),
                          leading: Column(
                            children: <Widget> [
                              IconButton( 
                                icon: Icon(Icons.check_circle, ),
                                onPressed: (){
                                  setState(() {
                                    DBprovider.db.deleteTask(todoList.data[index].taskID);
                                    Scaffold.of(context).showSnackBar(
                                      SnackBar(content: Text('Marked task as complete'),)
                                    );
                                  });
                                },
                              )
                            ]
                          ),
                          onTap: () {
                            Navigator.push(context, 
                              MaterialPageRoute(
                                builder: (context) => TaskDetailsPage(task: todoList.data[index])
                              )
                            );
                          }
                        )
                      );
                    }
                  )
                ),
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