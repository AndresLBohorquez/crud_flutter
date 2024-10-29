import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../repository/user_provider.dart';

class UserFormPage extends StatefulWidget {
  const UserFormPage({Key? key}) : super(key: key);

  @override
  _UserFormPageState createState() => _UserFormPageState();
}

class _UserFormPageState extends State<UserFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _inputNameController = TextEditingController();
  final _inputLastNameController = TextEditingController();
  final _inputEmailController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _inputNameController.dispose();
    _inputLastNameController.dispose();
    _inputEmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear usuario'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _inputNameController,
                decoration: InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'El nombre es obligatorio';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _inputLastNameController,
                decoration: InputDecoration(
                  labelText: 'Apellidos',
                  border: OutlineInputBorder(),
                ),
              ),
              TextFormField(
                controller: _inputEmailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'El email es obligatorio';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final userProvider = Provider.of<UserProvider>(context, listen: false);
                    userProvider.addUser(
                      _inputNameController.text,
                      _inputLastNameController.text,
                      _inputEmailController.text,
                    );
                    Navigator.of(context).pop();
                  }
                },
                child: Text('Crear'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}