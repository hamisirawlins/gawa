import 'package:gawa/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:gawa/modules/auth/domain/repository/auth_repo.dart';
import 'package:gawa/modules/auth/domain/usecases/user_login.dart';
import 'package:gawa/modules/auth/presentiation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/secrets/app_secrets.dart';
import 'modules/auth/data/datasources/auth_remote_data.dart';
import 'modules/auth/data/repositories/auth_repo_impl.dart';
import 'modules/auth/domain/usecases/current_user.dart';
import 'modules/auth/domain/usecases/user_sign_up.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
    debug: true,
  );
  serviceLocator.registerLazySingleton(() => supabase.client);
  serviceLocator.registerLazySingleton(() => AppUserCubit());
}

void _initAuth() {
  serviceLocator
    ..registerFactory<AuthRemoteData>(
        () => AuthRemoteDataImpl(serviceLocator()))
    ..registerFactory<AuthRepository>(() => AuthRepoImpl(
          serviceLocator(),
        ))
    ..registerFactory(() => UserSignUp(
          serviceLocator(),
        ))
    ..registerFactory(() => CurrentUser(
          serviceLocator(),
        ))
    ..registerFactory(() => UserLogin(
          serviceLocator(),
        ))
    ..registerLazySingleton(() => AuthBloc(
        userSignUp: serviceLocator(),
        userLogin: serviceLocator(),
        currentUser: serviceLocator(),
        appUserCubit: serviceLocator()));
}
