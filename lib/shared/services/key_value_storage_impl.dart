import 'package:eventos_app/shared/services/key_value_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KeyValueServiceImpl extends KeyValueStorage {

  Future<SharedPreferences> getSharedPrefs() async {
    return await SharedPreferences.getInstance();
    
  }

  @override
  Future<T?> getValue<T>(String key) async {
    final prefs = await getSharedPrefs();

    if (T == int) {
      return prefs.getInt(key) as T;
    } else if (T == String) {
      final value = prefs.getString(key);
      print('Valor recuperado para $key: $value');
      return value as T?;
      
    } else {
      throw UnimplementedError('No está implementado para el tipo de dato : ${T.runtimeType}');
    }
  }

  @override
  Future<bool> removeKey(String key) async {
    final prefs = await getSharedPrefs();
    return await prefs.remove(key);
  }

  @override
  Future<void> setKeyValue<T>(String key, T value) async {
    final prefs = await getSharedPrefs();

    if (T == int) {
      prefs.setInt(key, value as int);
    } else if (T == String) {
      prefs.setString(key, value as String);
    } else {
      throw UnimplementedError('No está implementado para el tipo de dato ${T.runtimeType}');
    }
    
  }
}
