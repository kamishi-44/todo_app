import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/add_task_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'detail_page.dart';
import 'firebase_options.dart';
import 'task.dart';

Future<void> main() async {
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

  static List<Task> sampleTasks = generateSampleTasks();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ReorderableListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: sampleTasks.length,
          onReorder: (int oldIndex, int newIndex) {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            Task moveTask = sampleTasks.removeAt(oldIndex);
            sampleTasks.insert(newIndex, moveTask);
          },
          itemBuilder: (BuildContext context, int index) {
            return Container(
              key: Key(sampleTasks[index].taskId),
              child: TodoList(task: sampleTasks[index]),
            );
          },
          // separatorBuilder: (BuildContext context, int index) => const Divider(),
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

  /// サンプル用のタスクを生成します。
  static List<Task> generateSampleTasks() {
    return [
      Task("0", "診察", done, "○○整形外科で10時"),
      Task("1", "買い出し", done, "スーパー△△で調味料の買い出し"),
      Task("2", "晩御飯の準備", yet, "エビフライ"),
      Task("3", "診察", done, "○○整形外科で10時"),
      Task("4", "買い出し", done, "スーパー△△で調味料の買い出し"),
      Task("5", "晩御飯の準備", yet, "エビフライ"),
      Task("6", "診察", done, "○○整形外科で10時"),
      Task("7", "買い出し", done, "スーパー△△で調味料の買い出し"),
      Task("8", "晩御飯の準備", yet, "エビフライ"),
      Task("9", "診察", done, "○○整形外科で10時"),
      Task("10", "買い出し", done, "スーパー△△で調味料の買い出し"),
      Task("11", "晩御飯の準備", yet, "エビフライ"),
      Task("12", "診察", done, "○○整形外科で10時"),
      Task("13", "買い出し", done, "スーパー△△で調味料の買い出し"),
      Task("14", "晩御飯の準備", yet, "エビフライ"),
    ];
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
