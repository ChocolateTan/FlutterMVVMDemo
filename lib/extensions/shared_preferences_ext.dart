import 'dart:async';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

extension SharedPreferencesExtension on Future<SharedPreferences> {
  String get SP_EXPIRE => "SP_EXPIRE";

  int get EXPIRE_TIME => 1000 * 60 * 60 * 6;

  // Future<SharedPreferences> withExpire() async {
  //   int? expire = getInt(SP_EXPIRE);
  //   if (null != expire) {
  //     int now = DateTime.now().millisecond;
  //     if (now - expire > EXPIRE_TIME) {
  //       await clear();
  //     }
  //   }
  //
  //   return this;
  // }
  Future<String> getString(String key) {
    return then((onValue) {
      int now = DateTime.now().millisecondsSinceEpoch;
      if (onValue.containsKey(SP_EXPIRE)) {
        int? expire = onValue.getInt(SP_EXPIRE);
        if (null != expire && 0 != expire) {
          if (now - expire > EXPIRE_TIME) {
            onValue.setInt(SP_EXPIRE, now);
            return Future.value("");
          }

          return Future.value(onValue.getString(key)??"");
        }
      } else {
        onValue.setInt(SP_EXPIRE, now);
      }

      return Future.value("");
    });
  }
  Future<void> setString(String key, String jsonStr) {
    return then((onValue) {
      onValue.setString(key, jsonStr);
      return Future.value();
    });
  }
}
