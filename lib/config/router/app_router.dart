import 'package:eventos_app/config/router/app_router_notifier.dart';
import 'package:eventos_app/presentation/providers/auth_provider.dart';
import 'package:eventos_app/presentation/screens/check_auth_status_screen.dart';
import 'package:eventos_app/presentation/screens/home_screen.dart';
import 'package:eventos_app/presentation/screens/register_user_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final goRouterProvider = Provider((ref) {

  final goRouterNotifier = ref.read(goRouterNotifierProvider);
  
  return GoRouter(
    initialLocation: '/register',
    refreshListenable: goRouterNotifier ,
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
    ],
    redirect: (context, state) {
      final isGoingTo= state.matchedLocation;
      final authStatus = goRouterNotifier.authStatus;
      
      print('gorouter  authstatus: $authStatus, isgointo: $isGoingTo');
      if( isGoingTo == '/checking' && authStatus == AuthStatus.checking) return '/';

      if( authStatus == AuthStatus.notAuthenticated){
        if(isGoingTo == '/register') return null;

        return '/register';
      }

      if( authStatus == AuthStatus.authenticated){
        if(isGoingTo == '/register' || isGoingTo == '/checking') return '/';

      }
      return null;
    },

  );
});
