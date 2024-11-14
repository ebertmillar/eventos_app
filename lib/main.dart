import 'package:eventos_app/config/router/app_router.dart';
import 'package:eventos_app/firebase_options.dart';
import 'package:eventos_app/presentation/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:eventos_app/config/config.dart';


void main() async {

  await Environment.initEnvironment();
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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

    // Ejecutar checkAuthStatus al iniciar la app
    ref.read(authProvider.notifier).checkAuthStatus();
    
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),      
      
      
    );
  }
}