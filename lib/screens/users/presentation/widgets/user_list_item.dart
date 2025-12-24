import 'package:flutter/material.dart';
import 'package:pcfc_assignment/screens/users/data/model/users_model.dart';

class UserListItem extends StatelessWidget {
  final UsersModel user;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final VoidCallback navigateToUserDetailsScreen;

  const UserListItem({
    super.key,
    required this.user,
    required this.onTap,
    required this.onDelete,
    required this.navigateToUserDetailsScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: navigateToUserDetailsScreen,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            title: Text(user.name.toString()),
            trailing: IconButton(onPressed: onDelete, icon: Icon(Icons.delete)),
          ),
        ),
      ),
    );
  }
}
