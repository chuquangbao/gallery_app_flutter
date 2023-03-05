import 'package:flutter/material.dart';

class NotificationManager {
  static final NotificationManager center = NotificationManager();
  ValueNotifier<bool> bookmarksChanges = ValueNotifier(false);

  void notifyBookmarksListeners() {
    center.bookmarksChanges.value = !center.bookmarksChanges.value;
  }
}
