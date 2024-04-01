import 'package:flutter/material.dart';
import 'authentication_service.dart';
import 'color_game.dart';
import 'signup_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String usernameErrorText = '';
  String passwordErrorText = '';

  void validateUsername(String value) {
    if (value.isEmpty) {
      setState(() {
        usernameErrorText = 'Username is required';
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
        title: Text('Login'),
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
                      maxHeight: 350,
                    ),
                    color: Colors.white.withOpacity(0.8),
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextField(
                          controller: usernameController,
                          onChanged: validateUsername,
                          decoration: InputDecoration(
                            labelText: 'Username',
                            prefixIcon: Icon(Icons.person,
                                size: 30, color: Colors.white),
                            filled: true,
                            fillColor: Color(0xfffb962a),
                            errorText: usernameErrorText,
                            helperText: 'Add a valid username',
                            labelStyle: TextStyle(
                              color: Colors.white,
                            ),
                            hintStyle: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 20),
                        TextField(
                          controller: passwordController,
                          onChanged: validatePassword,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon:
                                Icon(Icons.lock, size: 30, color: Colors.white),
                            filled: true,
                            fillColor: Color(0xfffb962a),
                            errorText: passwordErrorText,
                            helperText: 'Password is required',
                            labelStyle: TextStyle(
                              color: Colors.white,
                            ),
                            hintStyle: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          obscureText: true,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () async {
                            if (usernameErrorText.isEmpty &&
                                passwordErrorText.isEmpty) {
                              bool loginSuccess =
                                  await AuthenticationService.logIn(
                                usernameController.text,
                                passwordController.text,
                              );

                              if (loginSuccess) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MyHomePage(),
                                  ),
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
                                            foregroundColor: Colors.white,
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
                            foregroundColor: Colors.white,
                            minimumSize: Size(200, 60),
                          ),
                          child: Text('Login'),
                        ),
                        SizedBox(height: 20),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUpPage(),
                              ),
                            );
                          },
                          child: Text(
                            'Don\'t have an account? Sign Up',
                            style: TextStyle(
                              color: Color(0xffd15a00),
                            ),
                          ),
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
