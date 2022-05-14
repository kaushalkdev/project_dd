import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:project_dd/src/core/services/firebase_service.dart';
import 'package:project_dd/src/features/form/apis/load_json_data.dart';

GetIt getIt = GetIt.instance;
void registerLocators() {
  getIt.registerSingleton<JsonLoader>(JsonLoader());
  getIt.registerSingleton<FirebaseService>(
      FirebaseService(FirebaseFirestore.instance));
}
