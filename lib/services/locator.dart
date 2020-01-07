import 'package:coeops/services/api_service.dart';
import 'package:coeops/services/dialog_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<ApiService>(ApiService());
  locator.registerLazySingleton(() => DialogService());
}
