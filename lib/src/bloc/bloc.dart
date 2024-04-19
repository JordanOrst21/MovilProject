import 'package:flutter_application_11/src/bloc/usersingleton.dart';
import 'package:flutter_application_11/src/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

class Bloc with Validators {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  Stream<String> get email => _emailController.stream.transform(validaEmail);
  Stream<String> get password =>
      _passwordController.stream.transform(validaPassword);

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  String get emailValue => _emailController.value;
  String get passwordValue => _passwordController.value;
  String nombre = "";

  Bloc() {
    _emailController.stream.listen((email) {
      UserSingleton().setNombre(email);
    });
  }

  bool login(String email, String password) {
    if (email == 'jordan@jordan.com') {
      nombre = "JORDAN";
    } else if (email == 'admin@admin.com') {
      nombre = "ADMIN";
    } else if (email == 'jair@jair.com') {
      nombre = "JAIR";
    }
    UserSingleton().setNombre(nombre);
    return (email == 'jordan@jordan.com' && password == 'jordan') ||
        (email == 'admin@admin.com' && password == 'admin') ||
        (email == 'jair@jair.com' && password == 'docente');
  }

  dispose() {
    _emailController.close();
    _passwordController.close();
  }
}

final bloc = Bloc();
