import 'package:flutter/material.dart';
import 'package:todo_app/data/data_manager.dart';

import 'main.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPage();
}

enum RadioValue { yet, doing, done }

extension RadioValueExtension on RadioValue {
  static final values = {
    RadioValue.yet: '未着手',
    RadioValue.doing: '着手中',
    RadioValue.done: '完了',
  };

  static final intValues = {
    RadioValue.yet: 0,
    RadioValue.doing: 1,
    RadioValue.done: 2,
  };

  String get statusValue => values[this]!;

  int get statusInt => intValues[this]!;

  static RadioValue intToRadioValue(int statusInt) {
    for (RadioValue radio in RadioValue.values) {
      if(radio.statusInt == statusInt) return radio;
    }
    return RadioValue.yet;
  }
}

class _AddTaskPage extends State<AddTaskPage> {
  RadioValue _selectedButton = RadioValue.yet;
  final _titleController = TextEditingController();
  final _detailController = TextEditingController();

  void _onRadioSelected(RadioValue? selectedButton) => setState(() {
        _selectedButton = selectedButton!;
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // キーボード表示時に自動でサイズを調整されないようにする設定
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("タスク登録"),
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
                    child: const Text('登録'),
                    onPressed: () {
                      // Firebase にアクセスしてデータを登録する。
                      var task = <String, dynamic>{
                        "title": _titleController.text,
                        "status": _selectedButton.statusInt,
                        "detail": _detailController.text,
                        "insert_at": DateTime.now(),
                      };
                      DataManager.addTask("admin", task);

                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          )),
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
