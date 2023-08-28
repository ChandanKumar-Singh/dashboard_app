import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:my_dashboard/controllers/MenuProvider.dart';
import 'package:my_dashboard/controllers/auth_provider.dart';
import 'package:my_dashboard/database/dio/dio/dio_client.dart';
import 'package:my_dashboard/database/repositories/auth_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constants/app_constants.dart';
import '../../../dio/dio/logging_interceptor.dart';

final sl = GetIt.instance;
Future<void> initRepos() async {
  if (!sl.isRegistered<DioClient>()) {
    sl.registerLazySingleton(() => DioClient(AppConst.baseUrl, sl(),
        loggingInterceptor: sl(), sharedPreferences: sl()));
  }

  //repositories
  sl.registerLazySingleton<AuthRepo>(
      () => AuthRepo(sharedPreferences: sl(), dioClient: sl()));

  //providers
  sl.registerLazySingleton<MenuProvider>(() => MenuProvider());
  sl.registerLazySingleton<AuthProvider>(() => AuthProvider(authRepo: sl()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  if (!sl.isRegistered<SharedPreferences>()) {
    sl.registerLazySingleton(() => sharedPreferences);
  }
  if (!sl.isRegistered<Dio>()) {
    sl.registerLazySingleton(() => Dio());
  }
  if (!sl.isRegistered<LoggingInterceptor>()) {
    sl.registerLazySingleton(() => LoggingInterceptor());
  }
  if (!sl.isRegistered<Connectivity>()) {
    sl.registerLazySingleton(() => Connectivity());
  }
}
