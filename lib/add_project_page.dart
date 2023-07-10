import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main.dart';
import 'project_class.dart';

class AddProjectPage extends StatelessWidget{

  final projectNameController = TextEditingController();
  final projectDescriptionController = TextEditingController();

  AddProjectPage({super.key});

  @override
  Widget build(BuildContext context) {

    var appState = context.watch<MyAppState>();

    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: (){
            Navigator.pop(context);
          },
          child: const Text(
            'Cancel',
            style: TextStyle(
                fontSize: 15
            ),
          ),
        ),
        title: const Text(
          "New Project",
          style: TextStyle(
              fontSize: 20
          ),
        ),
        leadingWidth: 100,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 80.0),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: TextField(
                controller: projectNameController,
                decoration: const InputDecoration(
                  hintText: 'Project Name',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: TextField(
                controller: projectDescriptionController,
                decoration: const InputDecoration(
                  hintText: 'Project Description',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: TextButton(
                onPressed: (){
                  Project project = Project(projectNameController.text, projectDescriptionController.text);
                  appState.addProject(project);
                  Navigator.pop(context);
                },
                child: const Text(
                  'Save',
                  style: TextStyle(
                      fontSize: 20.0
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


