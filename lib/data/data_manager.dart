import 'package:cloud_firestore/cloud_firestore.dart';

/// データの管理クラス
/// FireStore とのデータのやり取りをするクラスです。
class DataManager {
  /// users のコレクション名
  static const String usersCollection = "users";

  /// task のコレクション名
  static const String taskCollection = "task";

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
