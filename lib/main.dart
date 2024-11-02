import 'package:eventos_app/config/constants/environment.dart';
import 'package:eventos_app/config/themes/app_theme.dart';
import 'package:eventos_app/presentation/screens/register_user_screen.dart';
import 'package:flutter/material.dart';

void main() async{

  await Environment.initEnvironment();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {

    print(Environment.apiUrl);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),      
      home: const RegisterUserScreen(),
      
      
    );
  }
}