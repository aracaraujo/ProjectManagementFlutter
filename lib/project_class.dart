import 'package:task_app/task_class.dart';

class Project{
  final String name;
  final String description;
  List<Task> tasks = [];

  Project(this.name,this.description);

  void addTask(Task task){
    tasks.add(task);
  }
}