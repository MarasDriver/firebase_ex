import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_exmle/screens/auth/data/providers/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _signUp = false;
  bool _showPassword = false;
// String emailCheck = "^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^`{|}~]+@[a-zA-Z0-9]+.[a-zA-Z]+";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: ListView(
              shrinkWrap: true,
              children: [
                FlutterLogo(size: 150),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration:
                        InputDecoration(labelText: "Emailen Gibben Bitte"),
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Bitte enteren deine emailionen";
                      } else if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^`{|}~]+@[a-zA-Z0-9]+.[a-zA-Z]+")
                          .hasMatch(_emailController.text)) {
                        return "Bitte insertieren ein gutten mailenaddresieren";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "PassenSieWorden Bitte",
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _showPassword = !_showPassword;
                          });
                        },
                        icon: Icon(_showPassword
                            ? Icons.visibility_off
                            : Icons.visibility),
                      ),
                    ),
                    controller: _passwordController,
                    obscureText: !_showPassword,
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Bitte enteren deine passWordieren";
                      } else if (value.length < 8) {
                        return "Deine passworden machen mussen ACHT literen haben sie!";
                      }
                      return null;
                    },
                  ),
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: _signUp
                        ? () {
                            if (_formKey.currentState!.validate()) {
                              Provider.of<AuthState>(context, listen: false)
                                  .signOnWithEmail(
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim(),
                              );
                            }
                          }
                        : () {
                            if (_formKey.currentState!.validate()) {
                              Provider.of<AuthState>(context, listen: false)
                                  .signInWithEmail(
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim(),
                              );
                            }
                          },
                    child: Text(_signUp ? "Sign Up" : "Log In"),
                  ),
                ),
                Center(
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        _signUp = !_signUp;
                      });
                    },
                    child: Text(!_signUp ? "Sign Up" : "Log In"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
