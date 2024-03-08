import 'package:shared_preferences/shared_preferences.dart';

// A singleton class to manage the local cache using SharedPreferences.
class Cache{

  // An instance of SharedPreferences used to perform storage operations.
  SharedPreferences? prefs;
  // A static instance of Cache, to implement the singleton pattern.
  static Cache? _instance;

  // Private constructor for the singleton pattern.
  Cache._(){
    init();
  }

  // Named constructor to create a Cache instance with existing SharedPreferences.
  Cache._pre(this.prefs);

  static Future<Cache> preInit() async {
    if(_instance == null) {
      var prefs = await SharedPreferences.getInstance();
      _instance = Cache._pre(prefs);
    }
    return _instance!;
  }

  // Provides access to the singleton instance of Cache, creating it if doesn't exist.
  static Cache getInstance() {
    _instance ??= Cache._();
    return _instance!;
  }

  void init() async{
    prefs ??= await SharedPreferences.getInstance();
  }

  // Stores a string value in the cache associated with the given key.
  void setString(String key, String value) {
    prefs?.setString(key, value);
  }

  // Removes the value associated with the given key from the cache.
  void remove(String key) {
    prefs?.remove(key);
  }

  // Retrieves a value of type T from the cache associated with the given key.
  T? get<T>(String key) {
    var result = prefs?.get(key);
    if(result != null) {
      return result as T;
    }
    return null;
  }
}