import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/add_task_page.dart';
import 'package:todo_app/model/main_model.dart';

import 'detail_page.dart';
import 'firebase_options.dart';

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

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  /// タスクの未着手を表すステータス
  static const int yet = 0;

  /// タスクの着手中を表すステータス
  static const int doing = 1;

  /// タスクの完了を表すステータス
  static const int done = 2;

  final String title;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MainModel>(
      create: (_) => MainModel()..fetchTasks('admin'),
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Consumer<MainModel>(
          builder: (context, model, child) {
            final tasks = model.tasks;
            return ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return Slidable(
                    key: ValueKey(index),
                    endActionPane: const ActionPane(
                      motion: ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: null,
                          flex: 2,
                          backgroundColor: Color(0xFFFE4A49),
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: '削除',
                        ),
                      ],
                    ),
                    child: ListTile(
                      title: Text(tasks[index].title),
                      onTap: () => {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                DetailPage(task: tasks[index]),
                          ),
                        ),
                      },
                    ),
                  );
                });
          },
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
      ),
    );
  }
}
