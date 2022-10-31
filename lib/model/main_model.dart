import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo_app/model/task.dart';

class MainModel extends ChangeNotifier {
  /// users のコレクション名
  static const String _usersCollection = "users";

  /// task のコレクション名
  static const String _taskCollection = "task";

  List<Task> tasks = [];

  Future<void> fetchTasks(String userId) async {
    var db = FirebaseFirestore.instance;
    var docs  = await db.collection('users').doc(userId).collection('task').get();

    final tasks = docs.docs.map((doc) => Task(doc)).toList();
    this.tasks = tasks;
    notifyListeners();
  }

  void updateTask(String userId, Map<String, dynamic> task, int index) {
    var db = FirebaseFirestore.instance;
    db
        .collection(_usersCollection)
        .doc(userId)
        .collection(_taskCollection)
        .doc(tasks[index].docId())
        .update(task);

    tasks[index].setTitle(task['title']);
    tasks[index].setStatus(task['status']);
    tasks[index].setDetail(task['detail']);

    notifyListeners();
  }
  /// notifyListeners を実行します。
  void notify() {
    notifyListeners();
  }
}
