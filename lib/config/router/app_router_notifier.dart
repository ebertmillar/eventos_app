
import 'package:eventos_app/presentation/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final goRouterNotifierProvider = Provider((ref){
  final authNotifier = ref.read( authProvider.notifier);
  return AppGoRouterNotifier(authNotifier);
});

class AppGoRouterNotifier extends ChangeNotifier{

  final AuthNotifier _authNotifier;

  AuthStatus _authStatus = AuthStatus.checking;

  AppGoRouterNotifier(this._authNotifier){
    _authNotifier.addListener((state){
      authStatus = state.authStatus;
    });
  }

  AuthStatus get authStatus => _authStatus;

  set authStatus (AuthStatus value) {
    _authStatus = value;
    notifyListeners();
  }
}