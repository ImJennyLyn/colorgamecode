import 'package:flutter/material.dart';
import 'home_page.dart';
import 'game_tutorial_page.dart';

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color buttonColor = Color(0xfffffffe); // Common button color
    Color textColor = Color(0xffee5402); // Common text color

    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
        backgroundColor: const Color.fromARGB(255, 243, 79, 33),
      ),
      body: Container(
        color: Color(0xffffa300), // Set the background color of the menu
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            _buildMenuItem(
              icon: Icons.info,
              text: 'Game Tutorial',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GameTutorialPage()),
                );
              },
              buttonColor: buttonColor,
              textColor: textColor,
            ),
            _buildMenuItem(
              icon: Icons.exit_to_app,
              text: 'Log Out',
              onTap: () {
                _logOut(context);
              },
              buttonColor: buttonColor,
              textColor: textColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    required Color buttonColor, // Common button color
    required Color textColor, // Common text color
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Material(
        color: buttonColor,
        borderRadius: BorderRadius.circular(8.0),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8.0),
          child: ListTile(
            leading: Icon(
              icon,
              color: textColor,
            ),
            title: Text(
              text,
              style: TextStyle(color: textColor),
            ),
          ),
        ),
      ),
    );
  }

  void _logOut(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
      (route) => false,
    );
  }
}
