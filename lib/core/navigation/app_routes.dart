import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pcfc_assignment/core/di/injection_container.dart';
import 'package:pcfc_assignment/screens/users/presentation/user_screen.dart';
import 'package:pcfc_assignment/screens/users/presentation/user_details_screen.dart';
import 'package:pcfc_assignment/screens/users/presentation/bloc/users_bloc.dart';

class AppRoutes {
  static const String users = '/users';
  static const String userDetails = '/user-details';
}

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.users:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => serviceLocator<UsersBloc>()..add(GetAllUsersEvent()),
            child: const UserScreen(),
          ),
        );

      case AppRoutes.userDetails:
        final userId = settings.arguments as String;

        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: serviceLocator<UsersBloc>(),
            child: UserDetailsScreen(
              userId: userId,
              onDeleteUser: (id) {
                serviceLocator<UsersBloc>().add(DeleteUserEvent(userId: id));
              },
              onSaveUserPressed: (user) {
                serviceLocator<UsersBloc>().add(
                  UpdateUserByIdEvent(user: user),
                );
              },
            ),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Route not found'))),
        );
    }
  }
}
