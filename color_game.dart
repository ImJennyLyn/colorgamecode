import 'dart:math';
import 'package:flutter/material.dart';
import 'menu_page.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

Set<Color> selectedColors = {};

class _MyHomePageState extends State<MyHomePage> {
  int userCoins = 100;
  int bankerCoins = 1000;
  List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.purple,
    Colors.orange
  ];
  List<Color> resultColors = [Colors.white, Colors.white, Colors.white];

  Set<int> selectedWithdrawalAmounts = {};
  Map<Color, int> _betAmounts = {};

  void _roll() {
    if (selectedColors.isEmpty || _calculateTotalBetAmount() == 0) {
      _showAlert("Please select a color and place a bet before rolling.");
      return;
    }

    resultColors =
        List.generate(3, (index) => colors[Random().nextInt(colors.length)]);

    // Check if any of the chosen colors appear in the result
    Set<Color> winningColors =
        selectedColors.intersection(resultColors.toSet());

    int totalBetAmount = _calculateTotalBetAmount();

    if (winningColors.isNotEmpty) {
      // Double the bet amount for the winner colors
      int doubledBetAmount = winningColors
              .map((color) => _betAmounts[color] ?? 0)
              .fold(0, (sum, amount) => sum + amount) *
          2;

      setState(() {
        userCoins += doubledBetAmount;
      });

      _showResultDialog("Congratulations! You won $doubledBetAmount coins.");
    } else {
      int remainingCoins = userCoins - totalBetAmount;
      // Ensure that remainingCoins does not go negative
      userCoins = remainingCoins >= 0 ? remainingCoins : 0;

      _showResultDialog("Oops! You lost $totalBetAmount coins.");
    }
  }

  int _calculateTotalBetAmount() {
    return _betAmounts.values.fold(0, (sum, amount) => sum + amount);
  }

  void _withdrawCoins() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Withdraw Coins'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Select Withdrawal Amount:'),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildWithdrawButton(50),
                  _buildWithdrawButton(100),
                  _buildWithdrawButton(200),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildWithdrawButton(300),
                  _buildWithdrawButton(400),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _withdrawAmount();
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xfffb962a),
                  onPrimary: Colors.white,
                  minimumSize: Size(140, 50),
                  side: BorderSide(
                    color: Colors.orange,
                    width: 4.0,
                  ),
                ),
                child: Text('Withdraw'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _withdrawAmount() {
    setState(() {
      int totalWithdrawal =
          selectedWithdrawalAmounts.fold(0, (sum, amount) => sum + amount);

      if (bankerCoins >= totalWithdrawal) {
        userCoins += totalWithdrawal;
        bankerCoins -= totalWithdrawal;
        selectedWithdrawalAmounts.clear();
      } else {
        _showResultDialog("Banker does not have enough coins.");
      }
    });
  }

  void _showResultDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Result'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(message),
              SizedBox(height: 10),
              Text(
                "Your Coins: $userCoins",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Reset color choices and bet amounts
                  selectedColors.clear();
                  _betAmounts.clear();

                  // Check if the player has run out of coins
                  if (userCoins <= 0) {
                    // If the player has run out of coins, set userCoins to 0
                    userCoins = 0;
                    // Show "Game Over" message
                    Navigator.of(context).pop(); // Close the current dialog
                    _showGameOverDialog(); // Show "Game Over" dialog
                  } else {
                    // If the player still has coins, just pop the dialog
                    Navigator.of(context).pop();
                  }
                  setState(() {});
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xffea6e21),
                  onPrimary: Colors.white,
                  side: BorderSide(
                    color: Colors.orange,
                    width: 4.0,
                  ),
                ),
                child: Text('Retry'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAlert(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Invalid'),
          content: Text(message),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.orange, // Set the button color to orange
              ),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showGameOverDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Game Over'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('You have run out of coins. Play again!'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Reset the game when the player chooses to play again
                  userCoins = 100; // You can set the initial coins as needed
                  bankerCoins = 1000;
                  selectedColors.clear();
                  _betAmounts.clear();
                  Navigator.of(context).pop(); // Close the "Game Over" dialog
                  setState(() {});
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xffea6e21),
                  onPrimary: Colors.white,
                  side: BorderSide(
                    color: Colors.orange,
                    width: 4.0,
                  ),
                ),
                child: Text('Play Again'),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildWithdrawButton(int amount) {
    bool isSelected = selectedWithdrawalAmounts.contains(amount);

    return ElevatedButton(
      onPressed: () {
        setState(() {
          if (isSelected) {
            selectedWithdrawalAmounts.remove(amount);
          } else {
            selectedWithdrawalAmounts.add(amount);
          }
        });
      },
      style: ElevatedButton.styleFrom(
        primary: isSelected ? Color(0xffff5e19) : null,
        minimumSize: Size(70, 70),
      ),
      child: Text('$amount'),
    );
  }

  Widget _buildCoinBox(
      String label, int amount, IconData icon, Color color, Color fillColor) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: color, width: 5),
              borderRadius: BorderRadius.circular(8),
              color: fillColor,
            ),
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: color),
                SizedBox(width: 8),
                Text(
                  '$amount',
                  style: TextStyle(
                    color: color,
                    fontSize: 25,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _selectColor(Color color) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        int betAmount = _betAmounts[color] ?? 0;

        return AlertDialog(
          title: Text('Enter Bet Amount'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Selected Color:'),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color,
                ),
              ),
              SizedBox(height: 10),
              Text('Current Bet Amount: $betAmount'),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  betAmount = int.tryParse(value) ?? 0;
                },
                decoration: InputDecoration(
                  labelText: 'Bet Amount',
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (betAmount > 0 && betAmount <= userCoins) {
                        setState(() {
                          selectedColors.add(color);
                          _betAmounts[color] = betAmount;
                          userCoins -= betAmount;
                        });
                        Navigator.of(context).pop();
                      } else {
                        // Show an error message
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Invalid Bet Amount'),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xfffb962a),
                      onPrimary: Colors.white,
                      side: BorderSide(
                        color: Colors.orange,
                        width: 4.0,
                      ),
                    ),
                    child: Text('Submit Bet'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        // Remove the color from the selected colors
                        selectedColors.remove(color);
                        // Undo the bet amount for the color
                        userCoins += betAmount;
                        _betAmounts.remove(color);
                      });
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      onPrimary: Colors.white,
                      side: BorderSide(
                        color: Colors.orange,
                        width: 4.0,
                      ),
                    ),
                    child: Text('Undo Bet'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Color Game'),
        backgroundColor: const Color.fromARGB(255, 243, 79, 33),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.menu, color: Color(0xffffad2f)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MenuPage()),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xffffa300), Color(0xffffa300), Color(0xffffad2f)],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildCoinBox('Your Coins', userCoins, Icons.attach_money,
                      Color(0xffe24f00), Color(0xffffcc80)),
                  _buildCoinBox('Banker Coins', bankerCoins,
                      Icons.account_balance, Colors.green, Color(0xffb2dfdb)),
                ],
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xfff6b95c),
                  border: Border.all(
                    color: Color(0xffffffff),
                    width: 4.0,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: resultColors.map((color) {
                    return Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Container(
                        width: 90,
                        height: 80,
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 70),
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 20.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: colors.length,
                itemBuilder: (BuildContext context, int index) {
                  return ElevatedButton(
                    onPressed: () {
                      _selectColor(colors[index]);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: selectedColors.contains(colors[index])
                          ? Color(0xffff6512)
                          : Color(0xffffead1),
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(10.0),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: colors[index],
                      ),
                      child: Center(
                        child: Text(
                          _betAmounts[colors[index]] != null
                              ? _betAmounts[colors[index]].toString()
                              : '',
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 30),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _roll,
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xffff6512),
                      onPrimary: Color(0xfff8f8f8),
                      minimumSize: Size(200, 60),
                      side: BorderSide(
                        color: Color(0xfff6f6f6),
                        width: 2.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13.0),
                      ),
                    ),
                    child: Text(
                      'Roll',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: _withdrawCoins,
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xffe2841f),
                      onPrimary: Color(0xffffffff),
                      minimumSize: Size(100, 50),
                      side: BorderSide(
                        color: Color(0xffffffff),
                        width: 2.0,
                      ),
                    ),
                    child: Text(
                      'Withdraw Coins',
                      style: TextStyle(fontSize: 20),
                    ),
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
