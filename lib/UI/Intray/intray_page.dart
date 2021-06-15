import 'package:flutter/material.dart';
import 'package:todoapp/bloc/blocs/user_bloc_provider.dart';
import 'package:todoapp/models/Widgets/intray_todo_widget.dart';
import 'package:todoapp/models/classes/task.dart';
import 'package:todoapp/models/global.dart';

class IntrayPage extends StatefulWidget {
  final String apiKey;
  IntrayPage({this.apiKey});
  @override
  _IntrayPageState createState() => _IntrayPageState();
}

class _IntrayPageState extends State<IntrayPage> {
  List<Task> taskList = [];
  TaskBloc tasksBloc;

  @override
  void initState() {
    tasksBloc = TaskBloc(widget.apiKey);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: darkGrey,
      child: StreamBuilder(
        stream: tasksBloc.getTasks,
        initialData: [],
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot != null) {
            if (snapshot.data.length > 0) {
              return _buildReorderableListSimple(context, snapshot.data);
            } else if (snapshot.data.length == 0) {
              return Center(child: Text("No data"));
            } else if (snapshot.hasError) {
              return Container();
            }
            return CircularProgressIndicator();
          }
        },
      ),
      // child: FutureBuilder(
      //   future: getList(),
      //   builder: (BuildContext context, AsyncSnapshot snapshot) {
      //     if (snapshot.hasData) {
      //       return _buildReorderableListSimple(context, taskList);
      //     }

      // if (snapshot.connectionState == ConnectionState.none &&
      //     snapshot.hasData == null) {
      //   return Container();
      // }
      // return ListView.builder(
      //     itemBuilder: (context, index) {
      //       taskList = snapshot.data;
      //       return _buildReorderableListSimple(context, taskList);
      //     },
      //     itemCount: snapshot.data.length);
    );
  }

  Widget _buildListTile(BuildContext context, Task item) {
    return ListTile(
      key: Key(item.taskId.toString()),
      title: IntrayTodo(title: item.title),
    );
  }

  Widget _buildReorderableListSimple(
      BuildContext context, List<Task> taskList) {
    return Theme(
      data: ThemeData(canvasColor: Colors.transparent),
      child: ReorderableListView(
        // handleSide: ReorderableListSimpleSide.Right,
        // handleIcon: Icon(Icons.access_alarm),

        padding: EdgeInsets.only(top: 300.0),
        children:
            taskList.map((Task item) => _buildListTile(context, item)).toList(),

        onReorder: (oldIndex, newIndex) {
          setState(() {
            Task item = taskList[oldIndex];
            taskList.remove(item);
            taskList.insert(newIndex, item);
          });
        },
      ),
    );
  }

  // void _onReorder(int oldIndex, int newIndex) {
  //   setState(() {
  //     if (newIndex > oldIndex) {
  //       newIndex -= 1;
  //     }
  //     final IntrayTodo item = todoItems.removeAt(oldIndex);
  //     todoItems.insert(newIndex, item);
  //   });
  // }

  // Future<List<Task>> getList() async {
  //   List<Task> tasks = await tasksBloc.getUserTasks(widget.apiKey);
  //   return tasks;
  // }
}
