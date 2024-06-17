import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui_text/conponents/my_button.dart';
import 'package:flutter_ui_text/helper/help_func.dart';

class RegisterScreen extends StatefulWidget {
  final void Function()? onTap;
  const RegisterScreen({super.key, this.onTap});
  
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  Future<void> _registerUser() async {
      showDialog(context: context,
          builder: (context) => const Center(
                child: CircularProgressIndicator(),
            )); 
            
    if (_passwordController.text != _confirmPasswordController.text) {
      Navigator.pop(context);
      displayMessageToUser("Password does not match", context);
    }
    try {
      // Create a new user
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );


      // create a new user document and add to the firestore
      createUserDocumen(userCredential);


      // Successfully registered
      if (context.mounted) {
        Navigator.pop(context); // Pop loading indicator
        // Navigator.pushNamed(context, '/home'); // Navigate to home screen
        // displayMessageToUser("User Registered", context);
      }

    } on FirebaseAuthException catch (e) {
      Navigator.pop(context); // Pop loading indicator
      displayMessageToUser(e.message ?? "An error occurred", context);
    } catch (e) {
      Navigator.pop(context); // Pop loading indicator
      displayMessageToUser("An error occurred", context);
      print(e); // Handle error here
    }
  }

  Future<void> createUserDocumen(UserCredential userCredential) async {
    if(userCredential != null && userCredential.user != null) {
        await FirebaseFirestore.instance
         .collection('users')
         .doc(userCredential.user!.uid)
         .set({
        'username': _usernameController.text,
        'email': userCredential.user!.email,
      });
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0))),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
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
              const SizedBox(height: 20),
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
              const SizedBox(height: 20),
              TextFormField(
                controller: _confirmPasswordController,
                // decoration: const InputDecoration(labelText: 'Confirm Password'),
                decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0))),
                obscureText: true,
                validator: (value) {
                  if (value != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 5),
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [Text("Forgot password")],
              ),
              const SizedBox(height: 20),
              MyButton(
                text: 'Register',
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    // Navigator.pushNamed(context, '/home');
                    _registerUser();
                  }
                },
              ),
              // ElevatedButton(
              //   onPressed: () {
              //     if (_formKey.currentState!.validate()) {
              //       // Perform registration action
              //       Navigator.pushNamed(context, '/home');
              //     }
              //   },
              //   child: const Text('Register'),
              // ),
              // TextButton(
              //   onPressed: () {
              //     Navigator.pushNamed(context, '/login');
              //   },
              //   child: const Text('Already have an account? Login'),
              // ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary)),
                  TextButton(
                    onPressed: widget.onTap!,
                    // onPressed: () {
                    //   Navigator.pushNamed(context, '/login');
                    // },
                    child: const Text('Login Here',
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
