import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../model/task.dart';
import 'data_manager.dart';

class TaskList extends ChangeNotifier{
  final String userId;
  late List<Task> list = [];

  TaskList(this.userId) {
    Future<QuerySnapshot<Map<String, dynamic>>> snapshot =
        DataManager.findTask(userId);
    snapshot.then((queryDocSnapshot) {
      int counter = 0;
      final taskList = queryDocSnapshot.docs.map((doc) => Task(counter++, doc)).toList();
      list = taskList;
      notifyListeners();
    });
  }
}
