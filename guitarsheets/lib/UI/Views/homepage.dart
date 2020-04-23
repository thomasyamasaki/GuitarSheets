import 'package:flutter/material.dart';
import 'package:guitarsheets/DB/Database.dart';
import 'package:guitarsheets/DB/TaskModel.dart';
import 'package:guitarsheets/UI/Forms/edittaskform.dart';
import 'package:guitarsheets/UI/Forms/taskform.dart';
//import 'package:guitarsheets/UI/Views/taskdetailspage.dart';

class HomePage extends StatefulWidget{
  @override 
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /*List<Color> _colors = [
    Colors.grey,
    Colors.green
  ];

  int _colorsIndex = 0;*/

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Theme.of(context).backgroundColor,
      floatingActionButton: 
        FloatingActionButton(child: Icon(Icons.add),
          backgroundColor: Colors.teal[400],//Colors.lightGreen[400],
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => TaskForm()));
          }
        ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.teal[300], Color(0xfff88379)]
          ),
        ),
        child: FutureBuilder(
        future: DBprovider.db.getAllTasks(),
          builder: (BuildContext context, AsyncSnapshot<List<Task>> todoList) {
            if (todoList.hasData) {
              return new Column(
                children: <Widget>[
                  Text(""),
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
                        return Container( 
                          decoration: BoxDecoration( 
                            boxShadow: [
                              BoxShadow(color: Colors.grey, blurRadius: 20)
                            ]
                          ),
                          child: Card(
                            color: Colors.white,//Colors.pink[200],
                            child: ExpansionTile(
                              title: Text(task.taskTitle, 
                                textAlign: TextAlign.left,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                              ),

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
                                  ),
                                ]
                              ),
                              children: <Widget>[
                                Text('Song: ' + todoList.data[index].song, textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                Text('Description: ' + todoList.data[index].taskDescription, textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                                Row(mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                  Icon(Icons.edit),
                                  FlatButton( 
                                    child: Text('Edit Task', style: TextStyle(fontSize: 15),),
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => EditTaskForm(task: todoList.data[index],)));
                                    },
                                  )
                                ],)
                              ],
                              /*onTap: () {
                                Navigator.push(context, 
                                  MaterialPageRoute(
                                    builder: (context) => TaskDetailsPage(task: todoList.data[index])
                                  )
                                );
                              }*/
                            )
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
      )
      
    );
  }
}