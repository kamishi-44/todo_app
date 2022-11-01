import 'package:flutter/material.dart';
import 'package:todo_app/model/main_model.dart';
import 'package:todo_app/util/view_util.dart';

import 'add_task_page.dart';
import 'data/data_manager.dart';
import 'model/task.dart';

class DetailPage extends StatefulWidget {
  final int index;
  final MainModel model;

  const DetailPage({super.key, required this.index, required this.model});

  @override
  State<DetailPage> createState() => _DetailPage();
}

class _DetailPage extends State<DetailPage> {
  late final Task _task;
  late RadioValue _selectedButton;
  late final TextEditingController _titleController;
  late final TextEditingController _detailController;
  late bool _textFieldEnabled;
  late bool _textFieldReadOnly;
  late bool _buttonEnabled;

  @override
  initState() {
    super.initState();
    _task = widget.model.tasks[widget.index];
    _selectedButton = RadioValueExtension.intToRadioValue(_task.status());
    _titleController = TextEditingController(text: _task.title());
    _detailController = TextEditingController(text: _task.detail());
    _textFieldEnabled = false;
    _textFieldReadOnly = true;
    _buttonEnabled = false;
  }

  void _onRadioSelected(RadioValue? selectedButton) => setState(() {
        _selectedButton = selectedButton!;
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("タスク詳細"),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              setState(() {
                _textFieldEnabled = true;
                _textFieldReadOnly = false;
                _buttonEnabled = true;
              });
            },
          ),
        ],
      ),
      body: Container(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextField(
                  enabled: _textFieldEnabled,
                  readOnly: _textFieldReadOnly,
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
                  enabled: _textFieldEnabled,
                  readOnly: _textFieldReadOnly,
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
                  child: Visibility(
                    visible: _buttonEnabled,
                    child: ElevatedButton(
                      onPressed: () {
                        // Firebase にアクセスしてデータを登録する。
                        var task = <String, dynamic>{
                          "title": _titleController.text,
                          "status": _selectedButton.statusInt,
                          "detail": _detailController.text,
                          "update_at": DateTime.now(),
                        };
                        widget.model.updateTask(
                            "admin", task, widget.index);
                        Navigator.of(context).pop();
                      },
                      child: const Text('更新'),
                    ),
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
              toggleable: false,
              value: RadioValue.yet,
              groupValue: _selectedButton,
              onChanged: _buttonEnabled
                  ? (selectedButton) => _onRadioSelected(selectedButton)
                  : null,
            ),
            Text(RadioValue.yet.statusValue),
          ],
        ),
        Row(
          children: [
            Radio<RadioValue>(
              toggleable: false,
              value: RadioValue.doing,
              groupValue: _selectedButton,
              onChanged: _buttonEnabled
                  ? (selectedButton) => _onRadioSelected(selectedButton)
                  : null,
            ),
            Text(RadioValue.doing.statusValue),
          ],
        ),
        Row(
          children: [
            Radio<RadioValue>(
              value: RadioValue.done,
              groupValue: _selectedButton,
              onChanged: _buttonEnabled
                  ? (selectedButton) => _onRadioSelected(selectedButton)
                  : null,
            ),
            Text(RadioValue.done.statusValue),
          ],
        ),
      ],
    );
  }
}
