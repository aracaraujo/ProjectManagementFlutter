import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';
import 'package:provider/provider.dart';
import 'main.dart';
import 'project_class.dart';
import 'task_class.dart';
import 'package:intl/date_symbol_data_local.dart';

class ProjectPage extends StatefulWidget {
  final Project project;

  const ProjectPage({super.key, required this.project});

  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  final taskController = TextEditingController();
  final dueDateController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  List<Widget> buildTaskCards(BuildContext context){
    var tasks = widget.project.tasks;
    if (tasks.isEmpty){
      return const <Card>[];
    }

    Color getColor(Task task){
      Color color = Colors.white;
      if (task.status == 'New'){
        color = Colors.lightBlue;
      }else if (task.status == 'Working'){
        color = Colors.yellow;
      }else{
        color = Colors.green;
      }
      return color;
    }

    return tasks.map((task){
      return Card(
          color: getColor(task),
          clipBehavior: Clip.hardEdge,
          child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: (){
              setState(() {
                task.changeStatus();
              });
            },
            child: Dismissible(
              key: Key(task.name),
              onDismissed: (direction){
                setState(() {
                  tasks.removeAt(tasks.indexOf(task));
                });

                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(task.name)));
              },

              background: Container(
                color: Colors.grey,
                alignment: Alignment.centerRight,
                child: const Icon(Icons.delete),
              ),

              child: ListTile(
                title: Text(task.name),
                subtitle: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text('Status: ${task.status}'),
                      ),
                      Expanded(
                        child: Text('Due Date: ${DateFormat.yMd().format(task.dueDate)}', textAlign: TextAlign.end),
                      ),

                      // Text(task.status),
                      // Text(task.dueDate)
                    ],
                )
              ),
            ),
          )
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: (){
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text(widget.project.name),
        actions: [
          TextButton(
              onPressed: (){
                showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.white,
                    builder: (context){
                      return SizedBox(
                        height: 500,
                        child: Center(
                          child: Column(
                            children: <Widget>[
                              const SizedBox(height: 50),
                              Padding(
                                padding: const EdgeInsets.all(20.0) ,
                                child: TextField(
                                  controller: taskController,
                                  decoration: const InputDecoration(
                                    hintText: 'Task Name',
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 150,
                                child: ScrollDatePicker(
                                    selectedDate: _selectedDate,
                                    minimumDate: DateTime(2020),
                                    maximumDate: DateTime(2030),
                                    locale: const Locale('en'),
                                    onDateTimeChanged: (DateTime value) {
                                      setState(() {
                                        _selectedDate = value;
                                      });
                                    }
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: ElevatedButton(
                                    onPressed: (){
                                    setState(() {
                                      widget.project.addTask(Task(taskController.text,_selectedDate));
                                      taskController.clear();
                                      dueDateController.clear();
                                      Navigator.pop(context);
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)
                                    )
                                  ),
                                  child: const Text('Save'),
                                ),
                              ),
                            ],
                          ),
                        )
                      );
                    }
                );
              },
              child: const Icon(Icons.add_circle_outline_rounded))
        ],
      ),
      body: GridView.count(
          crossAxisCount: 1,
          padding: const EdgeInsets.all(20.0),
          childAspectRatio: 4,
          children: buildTaskCards(context),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}