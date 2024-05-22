import 'package:flutter/material.dart';
import 'package:responsid/hive_database.dart';
import 'package:responsid/models/user_model.dart';
import 'package:responsid/user_controller.dart';
import 'package:responsid/login_page.dart';
import 'package:hive/hive.dart';

class RegistrationPage extends StatefulWidget {

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  late UserController _userController;



  @override
  void initState() {
    super.initState();
    _userController = UserController(HiveDatabase.getUserBox());
  }

  void _register() async {
    if(_formKey.currentState?.validate() ?? false) {
      final username = _usernameController.text;
      final password = _passwordController.text;

      final user = User(username, password, []);
      await _userController.addUser(user);

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage())
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Username'),
                validator: (value){
                  if(value==null || value.isEmpty){
                    return null;
                  }
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value){
                  if(value==null || value.isEmpty){
                    return null;
                  }
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: _register, child: Text('Register'))
            ],
          ),
        ),
      ),
    );
  }
}
