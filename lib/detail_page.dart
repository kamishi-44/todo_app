import 'package:flutter/material.dart';

import 'add_task_page.dart';
import 'model/task.dart';

class DetailPage extends StatefulWidget {
  final Task task;

  const DetailPage({super.key, required this.task});

  @override
  State<DetailPage> createState() => _DetailPage();
}

class _DetailPage extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("タスク詳細"),
      ),
      body: Center(
        child: Column(
          children: <Widget> [
            const Text("詳細ページだよーー。"),
            Text(widget.task.title),
          ],
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
