// Thomas Yamasaki
// Comp 499
// Model file for Task table

import 'dart:convert';

Task taskFromJson(String str) {
  final jsonData = json.decode(str);
  return Task.fromMap(jsonData);
}

String taskToJson(Task data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Task {
  int taskID;
  String taskTitle;
  String song;
  String taskDescription;

  Task({
    this.taskID,
    this.taskTitle,
    this.song,
    this.taskDescription
  });

  factory Task.fromMap(Map<String, dynamic> json) => new Task(
    taskID: json["Task_ID"],
    taskTitle: json["Task_Title"],
    song: json["Song"],
    taskDescription: json["Task_Description"],
  );

  Map<String, dynamic> toMap() =>{
    "Task_ID": taskID,
    "Task_Title": taskTitle,
    "Song": song,
    "Task_Description": taskDescription,
  };
}