import 'package:flutter/material.dart';

class UserFetchErrorWidget extends StatelessWidget {
  const UserFetchErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Something went wrong', style: TextStyle(fontSize: 20)),
    );
  }
}