import 'package:flutter/material.dart';

import '../add_task_page.dart';
import '../model/main_model.dart';

/// View の Util クラス
///
/// View での共通処理を実装
class ViewUtil {
  static void transitionAddTaskPage(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => const AddTaskPage(),
        ),
    );
  }
}
