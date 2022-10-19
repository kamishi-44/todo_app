import 'package:cloud_firestore/cloud_firestore.dart';

/// データの管理クラス
/// FireStore とのデータのやり取りをするクラスです。
class DataManager {
  /// users のコレクション名
  static const String usersCollection = "users";

  /// task のコレクション名
  static const String taskCollection = "task";

  /// 引数のユーザーIDに紐づくタスクの一覧を取得します。
  /// ユーザーにタスクが登録されていない場合は空のリストを返します。
  static Future<QuerySnapshot<Map<String, dynamic>>> findTask(String userId) async {
    var db = FirebaseFirestore.instance;
    var collectionRef  = db.collection(usersCollection).doc(userId).collection(taskCollection);
    return await collectionRef.get();
  }

  /// タスク1件をFirestoreに登録します。
  static void addTask(String userId, Map<String, dynamic> task) {
    var db = FirebaseFirestore.instance;
    db
        .collection(usersCollection)
        .doc(userId)
        .collection(taskCollection)
        .add(task);
  }
}
