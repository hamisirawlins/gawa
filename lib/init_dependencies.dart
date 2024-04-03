import 'package:gawa/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:gawa/modules/auth/domain/repository/auth_repo.dart';
import 'package:gawa/modules/auth/domain/usecases/user_login.dart';
import 'package:gawa/modules/auth/presentiation/bloc/auth_bloc.dart';
import 'package:gawa/modules/collection/data/datasources/collection_remote_data.dart';
import 'package:gawa/modules/collection/domain/repositories/blog_repository.dart';
import 'package:gawa/modules/collection/domain/usecases/upload_collection.dart';
import 'package:gawa/modules/collection/presentation/bloc/collections_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/secrets/app_secrets.dart';
import 'modules/auth/data/datasources/auth_remote_data.dart';
import 'modules/auth/data/repositories/auth_repo_impl.dart';
import 'modules/auth/domain/usecases/current_user.dart';
import 'modules/auth/domain/usecases/user_sign_up.dart';
import 'modules/collection/data/repositories/collection_repository_impl.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initCollection();
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

    //Data Source
    ..registerFactory<AuthRemoteDataSource>(
        () => AuthRemoteDataImpl(serviceLocator()))

    //Repository
    ..registerFactory<AuthRepository>(() => AuthRepoImpl(
          serviceLocator(),
        ))

    //UseCase
    ..registerFactory(() => UserSignUp(
          serviceLocator(),
        ))
    ..registerFactory(() => CurrentUser(
          serviceLocator(),
        ))
    ..registerFactory(() => UserLogin(
          serviceLocator(),
        ))

    //Bloc
    ..registerLazySingleton(() => AuthBloc(
        userSignUp: serviceLocator(),
        userLogin: serviceLocator(),
        currentUser: serviceLocator(),
        appUserCubit: serviceLocator()));
}

void _initCollection() {
  serviceLocator
    //Data Source
    ..registerFactory<CollectionRemoteDataSource>(
        () => CollectionRemoteDataSourceImpl(serviceLocator()))

    //Repository
    ..registerFactory<CollectionRepository>(
        () => CollectionRepoImpl(serviceLocator()))

    //UseCase
    ..registerFactory(() => UploadCollection(serviceLocator()))

    //Bloc
    ..registerLazySingleton(() => CollectionsBloc(serviceLocator()));
  ;
}
