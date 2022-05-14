import 'dart:convert';
import 'package:flutter/services.dart';

class JsonLoader {
  static Future<Map<String, dynamic>> loadJsonFromPath(String path) async {
    try {
      var loadedJson = (jsonDecode(await rootBundle.loadString(path))
          as Map<String, dynamic>);

      return (loadedJson[loadedJson.keys.first]);
    } catch (e) {
      rethrow;
    }
  }
}
