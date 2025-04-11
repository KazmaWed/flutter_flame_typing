import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'model/app_info.dart';
import 'model/game_score.dart';

class FirebaseHelper {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendGameScore({
    required AppInfo appInfo,
    required GameScore gameScore,
  }) async {
    try {
      await _firestore.collection('game_scores').add(gameScore.toJson(appInfo: appInfo));
      debugPrint('GameScore sent to Firestore successfully.');
    } catch (e) {
      debugPrint('Failed to send GameScore: $e');
    }
  }
}
