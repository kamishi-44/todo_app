import 'package:flutter/material.dart';

import 'task.dart';

class AddTaskPage extends StatefulWidget {

  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPage();
}

class _AddTaskPage extends State<AddTaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("タスク登録"),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: const <Widget> [
              Text("登録ページだよーー。"),
            ],
          ),
        ),
      ),
    );
  }
}
