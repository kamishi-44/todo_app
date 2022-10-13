import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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

  String get statusValue => values[this]!;
}

class _AddTaskPage extends State<AddTaskPage> {
  RadioValue _selectedButton = RadioValue.yet;

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
                const TextField(
                  decoration: InputDecoration(
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
                const TextField(
                  maxLines: 5,
                  decoration: InputDecoration(
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
                      var db = FirebaseFirestore.instance;
                      var task = <String, dynamic> {
                        "title": "画面のタイトル",
                        "status": _selectedButton,
                        "detail": "画面の詳細",
                        "insert_at": "",
                        "update_at": "",
                      };
                      db.collection("users").add(task);
                      showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              title: const Text('データを登録してもいいですか？'),
                              actions: <Widget>[
                                GestureDetector(
                                  child: const Text('いいえ'),
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                GestureDetector(
                                  child: const Text('はい'),
                                  onTap: () {},
                                )
                              ],
                            );
                          });
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
