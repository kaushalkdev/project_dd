import 'dart:convert';
import 'package:flutter/services.dart';

class JsonLoader {
  static Future<Map<String, dynamic>> loadJsonFromPath(String path) async {
    try {
      var _loadedJson = (jsonDecode(await rootBundle.loadString(path))
          as Map<String, dynamic>);

      return (_loadedJson[_loadedJson.keys.first]);
    } catch (e) {
      rethrow;
    }
  }
}
