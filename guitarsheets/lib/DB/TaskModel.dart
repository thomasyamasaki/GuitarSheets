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
  int id;
  String taskTitle;
  String song;
  String taskDescription;

  Task({
    this.id,
    this.taskTitle,
    this.song,
    this.taskDescription
  });

  factory Task.fromMap(Map<String, dynamic> json) => new Task(
    id: json["id"],
    taskTitle: json["task_title"],
    song: json["song"],
    taskDescription: json["task_description"],
  );

  Map<String, dynamic> toMap() =>{
    "id": id,
    "task_title": taskTitle,
    "song": song,
    "task_description": taskDescription,
  };
}