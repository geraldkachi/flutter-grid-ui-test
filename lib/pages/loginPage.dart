// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_ui_text/conponents/my_button.dart';
import 'package:flutter_ui_text/conponents/my_textfield.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      // appBar: AppBar(
      //   title: Text('Login'),
      // ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.person,
                size: 80,
                color: Theme.of(context).colorScheme.inverseSurface,
              ),
              // MyTextField(
              //   hintText: "Email",
              //   obscureText: false,
              //   controller: _emailController,
              //   decoration: InputDecoration(
              //       hintText: "Password",
              //       border: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(12.0))),
              // ),
              // SizedBox(height: 20),
              // MyTextField(
              //   hintText: "Password", obscureText: true,
              //   controller: _passwordController,
              //   decoration: InputDecoration(
              //       hintText: "Password",
              //       border: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(12.0))),

              //   validator: (value) {
              //       if (value!.isEmpty) {
              //         return 'Please enter your password';
              //       }
              //       return null;
              //     },
              // ),
              SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0))),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0))),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [Text("Forgot password")],
              ),
              SizedBox(height: 20),
              MyButton(
                text: 'Login',
                onTap: () {
                  if (_formKey.currentState!.validate())
                    Navigator.pushNamed(context, '/home');
                },
              ),
              // ElevatedButton(
              //   onPressed: () {
              //     if (_formKey.currentState!.validate()) {
              //       // Perform login action
              //       Navigator.pushNamed(context, '/home');
              //     }
              //   },
              //   child: Text('Login'),
              // ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: Text('Don\'t have an account? Register'),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary)),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    child: Text('Register',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
