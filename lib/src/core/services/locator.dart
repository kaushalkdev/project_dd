import 'package:get_it/get_it.dart';
import 'package:project_dd/src/features/form/apis/load_json_data.dart';

GetIt getIt = GetIt.instance;
void registerLocators() {
  getIt.registerSingleton<JsonLoader>(JsonLoader());
}
