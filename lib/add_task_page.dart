import 'package:flutter/material.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPage();
}

enum RadioValue { yet, doing, done }

class _AddTaskPage extends State<AddTaskPage> {
  RadioValue _selectedButton = RadioValue.yet;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("タスク登録"),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            const TextField(
              // maxLines: 1,
              autofocus: true,
              decoration: InputDecoration(
                labelText: 'タイトルを入力',
              ),
            ),
            Row(
              children: <Widget>[
                Radio(
                  value: RadioValue.yet,
                  groupValue: _selectedButton,
                  onChanged: (selectedButton) => _onRadioSelected,
                ),
                const Text('未着手'),
                Radio(
                  value: RadioValue.doing,
                  groupValue: _selectedButton,
                  onChanged: (selectedButton) => _onRadioSelected,
                ),
                const Text('着手中'),
                Radio(
                  value: RadioValue.done,
                  groupValue: _selectedButton,
                  onChanged: (selectedButton) => _onRadioSelected,
                ),
                const Text('完了'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onRadioSelected(RadioValue selectedButton) => setState(() {
        _selectedButton = selectedButton;
      });
}
