import 'package:flutter/material.dart';
import '../database/db_helper.dart';
import '../entity/user.dart';

class UserProvider extends ChangeNotifier {
  List<User> _userList = [];
  List<User> get userList => _userList;

  Future<void> addUser (String nombre, String? apellidos, String email) async {
    User user = User(nombre: nombre, apellidos: apellidos, email: email);
    await DBHelper().createUser (user);
    await listUsers();
  }

  Future<void> updateUser (User user) async {
    await DBHelper(). updateUser (user);
    await listUsers();
  }

  Future<void> deleteUser (int id) async {
    await DBHelper().deleteUser (id);
    await listUsers();
  }

  Future<void> listUsers() async {
    _userList = await DBHelper().listUsers();
    notifyListeners();
  }
}