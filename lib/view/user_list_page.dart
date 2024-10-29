import 'package:crud_usuarios/view/user_form_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../repository/user_provider.dart';
import '../database/db_helper.dart'; // Asegúrate de importar DBHelper

class UserListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Usuarios'),
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () async {
              String dbPath = await DBHelper().getDatabasePath();
              print('Ruta de la base de datos: $dbPath');
            },
          ),
        ],
      ),
      body: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          return ListView.builder(
            itemCount: userProvider.userList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(userProvider.userList[index].nombre),
                subtitle: Text(userProvider.userList[index].email),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    await userProvider.deleteUser (userProvider.userList[index].id!);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => UserFormPage()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}