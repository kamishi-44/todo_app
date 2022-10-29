import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo_app/model/task.dart';

class MainModel extends ChangeNotifier {
  List<Task> tasks = [];

  Future<void> fetchTasks(String userId) async {
    var db = FirebaseFirestore.instance;
    var docs  = await db.collection('users').doc(userId).collection('task').get();

    int counter = 0;
    final tasks = docs.docs.map((doc) => Task(counter++, doc)).toList();
    this.tasks = tasks;
    notifyListeners();
  }

  /// notifyListeners を実行します。
  void notify() {
    notifyListeners();
  }
}
