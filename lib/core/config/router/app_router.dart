import 'package:eventos_app/core/config/router/app_router_notifier.dart';
import 'package:eventos_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:eventos_app/features/auth/presentation/screens/check_auth_status_screen.dart';
import 'package:eventos_app/features/events/presentation/screens/create_event_screen.dart';
import 'package:eventos_app/features/auth/presentation/screens/home_screen.dart';
import 'package:eventos_app/features/auth/presentation/screens/register_user_screen.dart';
import 'package:eventos_app/features/auth/presentation/screens/splash_screen.dart';
import 'package:eventos_app/features/events/presentation/screens/event_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final goRouterProvider = Provider((ref) {

  final goRouterNotifier = ref.read(goRouterNotifierProvider);
  
  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: goRouterNotifier ,
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
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
      // GoRoute(
      //   path: '/create-event',
      //   builder: (context, state) => const CreateEventScreen(
          
      //   ), 
      // ),
      GoRoute(
        path: '/create-event/:id',
        builder: (context, state) => CreateEventScreen(
          eventId: state.pathParameters['id'] ?? 'no-id',
        ), 
      ),
      GoRoute(
        path: '/event/:id',
        builder: (context, state) => EventScreen(
          eventId: state.pathParameters['id'] ?? 'no-id',
          
        ), 
      ),
    ],
    redirect: (context, state) {
      final isGoingTo= state.matchedLocation;
      final authStatus = goRouterNotifier.authStatus;
      
      print('gorouter  authstatus: $authStatus, isgointo: $isGoingTo');
      if( isGoingTo == '/checking' && authStatus == AuthStatus.checking) return '/';
      if( isGoingTo == '/create-event' && authStatus == AuthStatus.checking) return '/register';

      if (authStatus == AuthStatus.notAuthenticated) {
        if (isGoingTo == '/checking') return '/';
        if (isGoingTo == '/create-event' ) return '/register';
      }

      if( authStatus == AuthStatus.authenticated){
        if(isGoingTo == '/register' || isGoingTo == '/checking') return '/';
        if(isGoingTo == '/create-event' || isGoingTo == '/checking') return null;
      }
      return null;
    },

  );
});
