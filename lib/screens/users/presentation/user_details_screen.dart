import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pcfc_assignment/constants/common_widgets/common_text_form_field.dart';
import 'package:pcfc_assignment/constants/common_widgets/custom_app_bar.dart';
import 'package:pcfc_assignment/screens/users/data/model/users_model.dart';
import 'package:pcfc_assignment/screens/users/presentation/bloc/users_bloc.dart';
import 'package:pcfc_assignment/screens/users/presentation/widgets/user_fetch_error_widget.dart';

class UserDetailsScreen extends StatefulWidget {
  final String userId;
  final Function(String) onDeleteUser;
  final Function(UsersModel) onSaveUserPressed;
  const UserDetailsScreen({
    super.key,
    required this.userId,
    required this.onDeleteUser,
    required this.onSaveUserPressed,
  });

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  late final UsersBloc usersBloc;
  late TextEditingController nameController;
  late TextEditingController addressController;
  late TextEditingController pobController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    addressController = TextEditingController();
    pobController = TextEditingController();
    usersBloc = context.read<UsersBloc>();
    usersBloc.add(GetUserByIdEvent(userId: widget.userId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'User Details'),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: BlocConsumer<UsersBloc, UsersState>(
          buildWhen: _buildWhen,
          listener: _listenWhen,
          builder: _builder,
        ),
      ),
    );
  }

  void _listenWhen(BuildContext context, UsersState state) {
    if (state is UserUpdateSuccess) {
      Navigator.of(context).pop();
    }
  }

  bool _buildWhen(previous, current) =>
      current is UserDetailsLoaded ||
      current is UsersLoaded ||
      current is UserUpdateSuccess;

  Widget _builder(BuildContext context, UsersState state) {
    if (state is UsersError) {
      return UserFetchErrorWidget();
    }
    if (state is UserDetailsLoaded) {
      final user = state.user;

      nameController.text = user.name;
      addressController.text = user.address;
      pobController.text = user.placeOfBirth;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Personal Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                child: Icon(Icons.delete_forever_rounded, size: 25),
                onPressed: () => widget.onDeleteUser(user.id),
              ),
            ],
          ),
          const SizedBox(height: 16),

          CommonUserTextFormField(controller: nameController, hintText: 'Name'),
          const SizedBox(height: 12),

          CommonUserTextFormField(
            controller: addressController,
            hintText: 'Address',
          ),
          const SizedBox(height: 12),

          CommonUserTextFormField(
            controller: pobController,
            hintText: 'Place of Birth',
          ),
          const SizedBox(height: 48),
          Center(
            child: ElevatedButton(
              onPressed: () => widget.onSaveUserPressed(
                UsersModel(
                  id: widget.userId,
                  name: nameController.text,
                  address: addressController.text,
                  placeOfBirth: pobController.text,
                ),
              ),
              child: Text('Save'),
            ),
          ),
        ],
      );
    }
    return SizedBox();
  }
}
