import 'package:eventos_app/config/router/app_router.dart';
import 'package:eventos_app/presentation/screens/register_user_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eventos_app/config/config.dart';


void main() async {

  await Environment.initEnvironment();

  runApp(
    const ProviderScope(
      child: MainApp(), 
    )
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final appRouter = ref.watch(goRouterProvider);
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),      
      
      
    );
  }
}