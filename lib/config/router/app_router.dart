import 'package:eventos_app/presentation/screens/check_auth_status_screen.dart';
import 'package:eventos_app/presentation/screens/home_screen.dart';
import 'package:eventos_app/presentation/screens/register_user_screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(

  initialLocation: '/checking',
  routes: [
    
    GoRoute(
      path: '/checking',
      builder: (context, state) => const CheckAuthStatusScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterUserScreen(),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),

  ]


);