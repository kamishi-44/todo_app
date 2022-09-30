import 'package:flutter/material.dart';

import 'task.dart';

void main() {
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

  static List<Task> sampleTasks = generateSampleTasks();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: sampleTasks.length,
          itemBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: 50,
              child: TodoList(task: sampleTasks[index]),
            );
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Add task',
        child: const Icon(Icons.add_task),
      ),
    );
  }

  /// サンプル用のタスクを生成します。
  static List<Task> generateSampleTasks() {
    return [
      Task("診察", done, "○○整形外科で10時"),
      Task("買い出し", done, "スーパー△△で調味料の買い出し"),
      Task("晩御飯の準備", yet, "エビフライ"),
    ];
  }
}

/// ToDoリストに表示する1件のListTile(1件のタスク)を生成します。
///
/// フィールドのタスクを元に生成したListTile Widget を返します。
class TodoList extends StatelessWidget {
  /// ListTile に表示する1件のタスク
  final Task task;

  /// コンストラクタ
  const TodoList({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.title),
    );
  }
}
