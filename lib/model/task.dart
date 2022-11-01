import 'package:cloud_firestore/cloud_firestore.dart';

/// タスククラス
///
/// 登録された1件のタスクを保持します。
class Task {
  /// 並び順保持用のID
  // late final int taskId;

  /// タスクのタイトル
  late String _title;

  /// タスクのステータス(0:未着手, 1:着手中, 2:完了)
  late int _status;

  /// タスクの詳細
  late String _detail;

  /// FirestoreのドキュメントID
  late final String _docId;

  /// コンストラクタ
  Task(DocumentSnapshot doc) {
    _title = doc["title"];
    _status = doc["status"];
    _detail = doc["detail"];
    _docId = doc.id;
  }

  /// タイトルを設定
  void setTitle(String title) => _title = title;

  /// ステータスを設定
  void setStatus(int status) => _status = status;

  /// タスク詳細を設定
  void setDetail(String detail) => _detail = detail;

  /// タイトル取得
  String title() => _title;

  /// ステータス取得
  int status() => _status;

  /// タスク詳細取得
  String detail() => _detail;

  /// docId取得
  String docId() => _docId;
}
