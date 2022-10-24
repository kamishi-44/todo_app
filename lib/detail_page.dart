import 'package:flutter/material.dart';
import 'package:todo_app/util/view_util.dart';

import 'add_task_page.dart';
import 'data/data_manager.dart';
import 'main.dart';
import 'model/task.dart';

class DetailPage extends StatefulWidget {
  final Task task;

  const DetailPage({super.key, required this.task});

  @override
  State<DetailPage> createState() => _DetailPage();
}

class _DetailPage extends State<DetailPage> {
  // RadioValue? _selectedButton = RadioValue.intToRadioValue(widget.task.status);
  late RadioValue _selectedButton;
  late final TextEditingController _titleController;
  late final TextEditingController _detailController;

  @override
  initState() {
    super.initState();
    _selectedButton = RadioValueExtension.intToRadioValue(widget.task.status);
    _titleController = TextEditingController(text: widget.task.title);
    _detailController = TextEditingController(text: widget.task.detail);
  }

  void _onRadioSelected(RadioValue? selectedButton) => setState(() {
    _selectedButton = selectedButton!;
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("タスク詳細"),
      ),
      body: Container(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextField(

                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'タイトルを入力',
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                generateStatusRadio(),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: _detailController,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    labelText: 'タスクの詳細',
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: ElevatedButton(
                    child: const Text('更新'),
                    onPressed: () {
                      // Firebase にアクセスしてデータを登録する。
                      var task = <String, dynamic>{
                        "title": _titleController.text,
                        "status": _selectedButton.statusInt,
                        "detail": _detailController.text,
                        "insert_at": DateTime.now(),
                      };
                      DataManager.addTask("admin", task);

                      // Navigator.of(context).pop();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                          const MyHomePage(title: 'Todo リスト'),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ViewUtil.transitionAddTaskPage(context),
        tooltip: 'Add task',
        child: const Icon(Icons.add_task),
      ),
    );
  }

  Widget generateStatusRadio() {
    return Row(
      children: <Widget>[
        Row(
          children: [
            Radio<RadioValue>(
              value: RadioValue.yet,
              groupValue: _selectedButton,
              onChanged: (selectedButton) => _onRadioSelected(selectedButton),
            ),
            Text(RadioValue.yet.statusValue),
          ],
        ),
        Row(
          children: [
            Radio<RadioValue>(
              value: RadioValue.doing,
              groupValue: _selectedButton,
              onChanged: (selectedButton) => _onRadioSelected(selectedButton),
            ),
            Text(RadioValue.doing.statusValue),
          ],
        ),
        Row(
          children: [
            Radio<RadioValue>(
              value: RadioValue.done,
              groupValue: _selectedButton,
              onChanged: (selectedButton) => _onRadioSelected(selectedButton),
            ),
            Text(RadioValue.done.statusValue),
          ],
        ),
      ],
    );
  }
}
