class UserSingleton {
  static final UserSingleton _instance = UserSingleton._internal();

  factory UserSingleton() {
    return _instance;
  }

  UserSingleton._internal();

  String _nombre = '';

  String get nombre => _nombre;

  void setNombre(String email) {
    _nombre = email;
  }
}
