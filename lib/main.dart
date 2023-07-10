import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/project_page.dart';
import 'project_class.dart';
import 'add_project_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const HomePage(),
        ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  List<Project> projects = [];

  void addProject(Project project){
    projects.add(project);
    notifyListeners();
  }

}

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  List<Widget> buildProjectsCards(BuildContext context){
    var appState = context.watch<MyAppState>();
    var projects = appState.projects;
    if (projects.isEmpty){
      return const <Card>[];
    }

    return projects.map((project){
      return Card(
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: (){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProjectPage(project: project))
            );
          },
          child: ListTile(
            title: Text(project.name),
            subtitle: Text(project.description),
          ),
        )
      );
    }).toList();
  }

  @override
  void dispose(){
    textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){

    var appState = context.watch<MyAppState>();

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu_rounded),
        title: const Text('Projects'),
        actions: [
          TextButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddProjectPage())
                );
              },
              child: const Icon(Icons.add_circle_outline_rounded)
          ),
        ],
      ),
      body: GridView.count(
          crossAxisCount: 1,
          padding: const EdgeInsets.all(20.0),
          childAspectRatio: 4,
          children: buildProjectsCards(context),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}


// Next steps:
// Change card background color according to task status.