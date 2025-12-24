import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:pcfc_assignment/screens/users/data/data_source/remote_users_data_source.dart';
import 'package:pcfc_assignment/screens/users/data/repository_impl/users_repository_impl.dart';
import 'package:pcfc_assignment/screens/users/presentation/bloc/users_bloc.dart';

import 'injection_container.config.dart';

final serviceLocator = GetIt.I;

@InjectableInit()
Future<void> configureDependencies() async {
  serviceLocator.init();
}

Future<void> initDi() async {
  serviceLocator.registerLazySingleton(
    () => UsersBloc(
      addUserUseCase: serviceLocator(),
      getAllUsersUseCase: serviceLocator(),
      deleteUserUseCase: serviceLocator(),
      getUserByIdUseCase: serviceLocator(),
      updateUserByIdUseCase: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton(
    () => GetAllUsersRepositoryImpl(remoteDataSource: serviceLocator()),
  );
}
