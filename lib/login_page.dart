import 'package:flutter/material.dart';
import 'package:responsid/home.dart';
import 'package:responsid/user_controller.dart';
import 'hive_database.dart';
import 'package:responsid/models/user_model.dart';

class LoginPage extends StatefulWidget {

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  late UserController _userController;

  void _login() async {
    if(_formKey.currentState?.validate() ?? false) {
      final username = _usernameController.text;
      final password = _passwordController.text;

      try{
        final user = _userController.getUserByUsername(username);
        if(user != null && user.password == password) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage(username: username))
          );
        } else {
          //_showErrorDialog('invalid username or password');
        }
      } catch(e) {
        //_showErrorDialog('User not found');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _userController = UserController(HiveDatabase.getUserBox());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
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
              ElevatedButton(onPressed: _login, child: Text('Login'))
            ],
          ),
        ),
      ),
    );
  }
}
