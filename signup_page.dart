import 'package:flutter/material.dart';
import 'authentication_service.dart';
import 'login_page.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String usernameErrorText = '';
  String passwordErrorText = '';

  void validateUsername(String value) {
    if (value.isEmpty) {
      setState(() {
        usernameErrorText = 'Enter a valid username';
      });
    } else {
      setState(() {
        usernameErrorText = '';
      });
    }
  }

  void validatePassword(String value) {
    if (value.isEmpty) {
      setState(() {
        passwordErrorText = 'Password is required';
      });
    } else {
      setState(() {
        passwordErrorText = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
        backgroundColor: const Color.fromARGB(255, 243, 79, 33),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double statusBarHeight = MediaQuery.of(context).padding.top;
          double screenHeight = constraints.maxHeight;

          return SingleChildScrollView(
            child: Container(
              height: screenHeight,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/log.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    16,
                    statusBarHeight + screenHeight * 0.15,
                    16,
                    16,
                  ),
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: 300,
                      maxHeight: 300,
                    ),
                    color: Colors.white.withOpacity(0.8),
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Username TextField with icon
                        TextField(
                          controller: usernameController,
                          onChanged: validateUsername,
                          decoration: InputDecoration(
                            labelText: 'Username',
                            errorText: usernameErrorText,
                            helperText: 'Add a valid username',
                            filled: true,
                            fillColor: Color(0xfffb962a),
                            labelStyle: TextStyle(color: Colors.white),
                            hintStyle: TextStyle(color: Colors.white),
                            prefixIcon: Icon(Icons.person, color: Colors.white),
                          ),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 20),
                        // Password TextField with icon
                        TextField(
                          controller: passwordController,
                          onChanged: validatePassword,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            errorText: passwordErrorText,
                            helperText: 'Password is required',
                            filled: true,
                            fillColor: Color(0xfffb962a),
                            labelStyle: TextStyle(color: Colors.white),
                            hintStyle: TextStyle(color: Colors.white),
                            prefixIcon: Icon(Icons.lock, color: Colors.white),
                          ),
                          obscureText: true,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () async {
                            if (usernameErrorText.isEmpty &&
                                passwordErrorText.isEmpty) {
                              bool signUpSuccess =
                                  await AuthenticationService.signUp(
                                usernameController.text,
                                passwordController.text,
                              );

                              if (signUpSuccess) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Success'),
                                      content:
                                          Text('Account created successfully!'),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      LoginPage()),
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            primary: Color(0xfffb962a),
                                            onPrimary: Colors.white,
                                          ),
                                          child: Text('OK'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Error'),
                                      content:
                                          Text('Invalid username or password.'),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          style: ElevatedButton.styleFrom(
                                            primary: Color(0xfffb962a),
                                            onPrimary: Colors.white,
                                          ),
                                          child: Text('OK'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xffd15a00),
                            onPrimary: Colors.white,
                            minimumSize: Size(200, 60),
                          ),
                          child: Text('Sign Up'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
