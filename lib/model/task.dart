import 'package:cloud_firestore/cloud_firestore.dart';

/// タスククラス
///
/// 登録された1件のタスクを保持します。
class Task {
  /// 並び順保持用のID
  late final int taskId;

  /// タスクのタイトル
  late final String title;

  /// タスクのステータス(0:未着手, 1:着手中, 2:完了)
  late final int status;

  /// タスクの詳細
  late final String detail;

  /// コンストラクタ
  Task(this.taskId, DocumentSnapshot  doc) {
    title = doc["title"];
    status = doc["status"];
    detail = doc["detail"];
  }
}
