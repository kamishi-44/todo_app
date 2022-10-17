import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/add_task_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:todo_app/data/task_list.dart';

import 'detail_page.dart';
import 'firebase_options.dart';
import 'model/task.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'kamishi_todo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale("ja", "JP"),
      ],
      home: const MyHomePage(title: 'Todo リスト'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /// タスクの未着手を表すステータス
  static const int yet = 0;

  /// タスクの着手中を表すステータス
  static const int doing = 1;

  /// タスクの完了を表すステータス
  static const int done = 2;

  static final TaskList _taskList = TaskList("admin");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ReorderableListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: _taskList.list.length,
          onReorder: (int oldIndex, int newIndex) {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }

            Task moveTask = _taskList.list.removeAt(oldIndex);
            _taskList.list.insert(newIndex, moveTask);
          },
          itemBuilder: (BuildContext context, int index) {
            return Container(
              key: Key(_taskList.list[index].taskId.toString()),
              child: TodoList(task: _taskList.list[index]),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => const AddTaskPage(),
            ),
          )
        },
        tooltip: 'Add task',
        child: const Icon(Icons.add_task),
      ),
    );
  }
}

/// ToDoリストに表示する1件のListTile(1件のタスク)を生成します。
///
/// フィールドのタスクを元に生成したListTile Widget を返します。
class TodoList extends StatefulWidget {
  /// ListTile に表示する1件のタスク
  final Task task;

  /// コンストラクタ
  const TodoList({super.key, required this.task});

  @override
  State<TodoList> createState() => _TodoList();
}

class _TodoList extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.task.title),
      trailing: const Icon(Icons.sort),
      onTap: () => {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => DetailPage(task: widget.task),
          ),
        ),
      },
    );
  }
}
