import 'package:flutter/material.dart';


class GameTutorialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: AppBar(
        title: Text('Game Tutorial'),
        backgroundColor: const Color.fromARGB(255, 243, 79, 33),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                "images/tutorial.jpg"), // Replace with your image path
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 150),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8), // Adjust opacity
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Choose Your Bet:\n\n'
                  'Select the amount you want to bet on the game.',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8), // Adjust opacity
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Pick a Color:\n\n'
                  'Choose a color from the available options. The game provides six different colors.',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8), // Adjust opacity
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Borrowing Coins:\n\n'
                  'If you need more coins to bet, you can borrow from the banker.',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8), // Adjust opacity
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Game Rules:\n\n'
                  'If you run out of coins, you will lose the game. Be strategic with your bets!',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
