import 'package:flutter/material.dart';
import 'package:flutter_application_11/src/bloc/bloc.dart';
import 'package:flutter_application_11/src/bloc/usersingleton.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_application_11/src/screens/post.dart';

class LoginScreen extends StatelessWidget {
  final UserSingleton _userSingleton = UserSingleton();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('ORSTBOOK'),
          backgroundColor: Color(0xFF004173),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Image.asset(
                    'assets/img/logo.png',
                    height: 80.0,
                  ),
                ),
                Card(
                  color: Color(0xFF7cdaf9),
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        SizedBox(height: 10.0),
                        emailField(),
                        SizedBox(height: 10.0),
                        passwordField(),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                submitButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget emailField() {
    return StreamBuilder(
      stream: bloc.email,
      builder: (context, snapshot) {
        return TextField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: "hola@hola.com",
            labelText: "Email",
            errorText:
                snapshot.error != null ? snapshot.error.toString() : null,
          ),
          onChanged: (value) {
            bloc.changeEmail(value);
            _userSingleton.setNombre(value);
          },
        );
      },
    );
  }

  Widget passwordField() {
    return StreamBuilder(
      stream: bloc.password,
      builder: (context, snapshot) {
        return TextField(
          decoration: InputDecoration(
            hintText: "Contraseña",
            labelText: "Contraseña",
            errorText:
                snapshot.error != null ? snapshot.error.toString() : null,
          ),
          onChanged: bloc.changePassword,
        );
      },
    );
  }

  Widget submitButton(BuildContext context) {
    return StreamBuilder<bool>(
      stream: Rx.combineLatest2(bloc.email, bloc.password, (a, b) => true),
      builder: (context, snapshot) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Color(0xFFb6ffff),
          ),
          child: Text("Entrar"),
          onPressed: snapshot.hasData
              ? () {
                  if (bloc.login(bloc.emailValue, bloc.passwordValue)) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Post()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Usuario o contraseña incorrectos"),
                      ),
                    );
                  }
                }
              : null,
        );
      },
    );
  }
}
