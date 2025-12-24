// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:http/http.dart' as _i519;
import 'package:injectable/injectable.dart' as _i526;
import 'package:pcfc_assignment/core/di/register_module.dart' as _i575;
import 'package:pcfc_assignment/screens/users/data/data_source/remote_users_data_source.dart'
    as _i464;
import 'package:pcfc_assignment/screens/users/data/repository_impl/users_repository_impl.dart'
    as _i192;
import 'package:pcfc_assignment/screens/users/domain/repository/users_repository.dart'
    as _i22;
import 'package:pcfc_assignment/screens/users/domain/use_case/add_user_use_case.dart'
    as _i490;
import 'package:pcfc_assignment/screens/users/domain/use_case/delete_user_use_case.dart'
    as _i557;
import 'package:pcfc_assignment/screens/users/domain/use_case/get_all_users_use_case.dart'
    as _i166;
import 'package:pcfc_assignment/screens/users/domain/use_case/get_user_by_id_use_case.dart'
    as _i299;
import 'package:pcfc_assignment/screens/users/domain/use_case/update_user_by_id_use_case.dart'
    as _i122;
import 'package:pcfc_assignment/screens/users/presentation/bloc/users_bloc.dart'
    as _i464;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i519.Client>(() => registerModule.httpClient);
    gh.lazySingleton<_i464.RemoteUsersDataSource>(
        () => _i464.RemoteUsersDataSourceImpl(client: gh<_i519.Client>()));
    gh.lazySingleton<_i22.GetAllUsersRepository>(() =>
        _i192.GetAllUsersRepositoryImpl(
            remoteDataSource: gh<_i464.RemoteUsersDataSource>()));
    gh.factory<_i166.GetAllUsersUseCase>(
        () => _i166.GetAllUsersUseCase(gh<_i22.GetAllUsersRepository>()));
    gh.factory<_i490.AddUserUseCase>(
        () => _i490.AddUserUseCase(gh<_i22.GetAllUsersRepository>()));
    gh.factory<_i557.DeleteUserUseCase>(
        () => _i557.DeleteUserUseCase(gh<_i22.GetAllUsersRepository>()));
    gh.factory<_i122.UpdateUserByIdUseCase>(
        () => _i122.UpdateUserByIdUseCase(gh<_i22.GetAllUsersRepository>()));
    gh.factory<_i299.GetUserByIdUseCase>(
        () => _i299.GetUserByIdUseCase(gh<_i22.GetAllUsersRepository>()));
    gh.factory<_i464.UsersBloc>(() => _i464.UsersBloc(
          addUserUseCase: gh<_i490.AddUserUseCase>(),
          getAllUsersUseCase: gh<_i166.GetAllUsersUseCase>(),
          deleteUserUseCase: gh<_i557.DeleteUserUseCase>(),
          getUserByIdUseCase: gh<_i299.GetUserByIdUseCase>(),
          updateUserByIdUseCase: gh<_i122.UpdateUserByIdUseCase>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i575.RegisterModule {}
