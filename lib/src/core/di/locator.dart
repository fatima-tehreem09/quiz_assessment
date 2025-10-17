import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../data/quiz/quiz_api.dart';
import '../../data/quiz/quiz_repository.dart';
import '../network/dio_client.dart';
import '../session/user_session.dart';
import '../theme/theme_cubit.dart';

final GetIt serviceLocator = GetIt.instance;

Future<void> setupServiceLocator() async {
  serviceLocator.registerLazySingleton<Dio>(() => createDioClient());

  serviceLocator
      .registerLazySingleton<QuizApi>(() => QuizApi(serviceLocator<Dio>()));

  serviceLocator.registerLazySingleton<QuizRepository>(
      () => QuizRepositoryImpl(serviceLocator<QuizApi>()));

  serviceLocator.registerLazySingleton<UserSession>(() => UserSession());

  serviceLocator.registerLazySingleton<ThemeCubit>(() => ThemeCubit());
}
