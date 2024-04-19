import 'dart:async';
import 'package:flutter/material.dart';

mixin Validators {
  final validaEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (email.contains('@')) {
      sink.add(email);
    } else {
      sink.addError('Email Invalido');
    }
  });

  final validaPassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length >= 5) {
      sink.add(password);
    } else {
      sink.addError('Password Invalido');
    }
  });

  final validateNotEmpty =
      StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {
    if (value.trim().isNotEmpty) {
      sink.add(value);
    } else {
      sink.addError('Este campo es requerido');
    }
  });

  final validateImageUrl = StreamTransformer<String, String>.fromHandlers(
      handleData: (imageUrl, sink) {
    if (imageUrl.trim().toLowerCase().startsWith('http')) {
      sink.add(imageUrl);
    } else {
      sink.addError('La URL de la imagen debe comenzar con http(s)');
    }
  });
}
