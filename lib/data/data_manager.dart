import 'package:cloud_firestore/cloud_firestore.dart';

/// データの管理クラス
/// FireStore とのデータのやり取りをするクラスです。
class DataManager {
  /// users のコレクション名
  static const String usersCollection = "users";

  /// task のコレクション名
  static const String taskCollection = "task";

  /// タスク1件をFirestoreに登録します。
  static void addTask(String userId, Map<String, dynamic> task) {
    var db = FirebaseFirestore.instance;
    db
        .collection(usersCollection)
        .doc(userId)
        .collection(taskCollection)
        .add(task);
  }

  /// 指定タスク1件を更新します。
  static void updateTask(String userId, String docId, Map<String, dynamic> task) {
    var db = FirebaseFirestore.instance;
    db
        .collection(usersCollection)
        .doc(userId)
        .collection(taskCollection)
        .doc(docId)
        .update(task);
  }

  /// 指定のユーザーが持つ指定のタスクを削除します。
  static void deleteTask(String userId, String docId) {
    var db = FirebaseFirestore.instance;
    db
        .collection(usersCollection)
        .doc(userId)
        .collection(taskCollection)
        .doc(docId)
        .delete();
  }
}
