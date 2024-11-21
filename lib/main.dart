import 'package:eventos_app/core/themes/app_theme.dart';
import 'package:eventos_app/firebase/firebase_options.dart';
import 'package:eventos_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:eventos_app/core/config/config.dart';


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