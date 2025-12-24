import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pcfc_assignment/constants/common_widgets/custom_app_bar.dart';
import 'package:pcfc_assignment/core/di/injection_container.dart';
import 'package:pcfc_assignment/screens/users/data/model/users_model.dart';
import 'package:pcfc_assignment/screens/users/presentation/bloc/users_bloc.dart';
import 'package:pcfc_assignment/screens/users/presentation/user_details_screen.dart';
import 'package:pcfc_assignment/screens/users/presentation/widgets/user_fetch_error_widget.dart';
import 'package:pcfc_assignment/screens/users/presentation/widgets/user_list_item.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final bloc = serviceLocator<UsersBloc>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc..add(GetAllUsersEvent()),
      child: PopScope(
        canPop: false,
        child: Scaffold(
          appBar: CustomAppBar(title: 'Users'),
          body: BlocConsumer<UsersBloc, UsersState>(
            buildWhen: _buildWhen,
            listener: _listener,
            builder: _builder,
          ),
        ),
      ),
    );
  }

  bool _buildWhen(previous, current) => current is UsersLoaded;
  void _listener(BuildContext context, UsersState state) {}
  Widget _builder(BuildContext context, UsersState state) {
    if (state is UsersError) {
      return UserFetchErrorWidget();
    }
    if (state is UsersLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (state is UserUpdateSuccess) {
      bloc.add(GetAllUsersEvent());
    }
    if (state is UsersLoaded) {
      final usersList = state.symbols;
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Users:',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                    onPressed: () => _addUserDialog(context),
                    child: Text('Add User'),
                  ),
                ],
              ),

              usersList.isEmpty
                  ? EmptyUserWidget()
                  : Expanded(
                      child: ListView.builder(
                        itemCount: usersList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return UserListItem(
                            user: usersList[index],
                            onTap: () => _navigateToUserDetailsScreen(
                              usersList[index].id,
                            ),
                            onDelete: () => _deleteUser(usersList[index].id),
                            navigateToUserDetailsScreen: () =>
                                _navigateToUserDetailsScreen(
                                  state.symbols[index].id,
                                ),
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
      );
    }
    return SizedBox();
  }

  void _addUserDialog(BuildContext context) {
    showAddUserDialog(context, (name, address, placeOfBirth) {
      bloc.add(
        AddUserEvent(
          user: UsersModel(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            name: name,
            address: address,
            placeOfBirth: placeOfBirth,
          ),
        ),
      );
    });
  }

  void _updateUser(UsersModel updatedUser) {
    bloc.add(UpdateUserByIdEvent(user: updatedUser));
  }

  void _deleteUser(String userId) {
    bloc.add(DeleteUserEvent(userId: userId));
  }

  void _navigateToUserDetailsScreen(String userId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: bloc,
          child: UserDetailsScreen(
            userId: userId,
            onDeleteUser: _deleteUser,
            onSaveUserPressed: _updateUser,
          ),
        ),
      ),
    ).then((onValue) => bloc.add(GetAllUsersEvent()));
  }
}

class EmptyUserWidget extends StatelessWidget {
  const EmptyUserWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 48),
        child: Text('No users to show'),
      ),
    );
  }
}

void showAddUserDialog(
  BuildContext context,
  void Function(String name, String address, String placeOfBirth) onAdd,
) {
  final nameController = TextEditingController();
  final pobController = TextEditingController();
  final addressController = TextEditingController();
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: const Text('Add User'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: addressController,
              decoration: const InputDecoration(
                labelText: 'Address',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: pobController,
              decoration: const InputDecoration(
                labelText: 'Place of Birth',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final name = nameController.text.trim();
              final placeOfBirth = pobController.text.trim();
              final address = addressController.text.trim();

              if (name.isEmpty || placeOfBirth.isEmpty) return;

              onAdd(name, address, placeOfBirth);
              Navigator.pop(context);
            },
            child: const Text('Add User'),
          ),
        ],
      );
    },
  );
}
