import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:pcfc_assignment/core/di/injection_container.dart';
import 'package:pcfc_assignment/screens/users/data/model/users_model.dart';
import 'package:pcfc_assignment/screens/users/presentation/user_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  // Loading environment variables
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    // Handling error if the .env file cannot be loaded
    throw Exception('Error loading .env file: $e');
  }
  await Hive.initFlutter();
  Hive.registerAdapter(UsersModelAdapter());

  await Hive.openBox<UsersModel>('usersBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'User CRUD Assignment',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromRGBO(165, 214, 167, 1),
          secondary: Colors.green[500],
        ),
      ),

      // initialRoute: AppRoutes.users,

      // onGenerateRoute: AppRouter.onGenerateRoute,
      home: UserScreen(),
    );
  }
}
