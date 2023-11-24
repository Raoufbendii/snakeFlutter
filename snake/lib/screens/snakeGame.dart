import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:snake/elements/blankPixel.dart';
import 'package:snake/elements/bounesPixel.dart';
import 'package:snake/elements/foodPixel.dart';
import 'package:snake/elements/snakePixel.dart';

class SnakeApp extends StatefulWidget {
  const SnakeApp({Key? key});

  @override
  State<SnakeApp> createState() => _SnakeAppState();
}

enum SnakeDirection { UP, DOWN, LEFT, RIGHT }

class _SnakeAppState extends State<SnakeApp> {
  int numberOfRows = 10;
  int numberOfItems = 130;

  List<int> snakePos = [50, 51];

  int foodPos = Random().nextInt(130);
  int bonusFoodPos = -1;

  var currentDirection = SnakeDirection.RIGHT;

  int currentScore = 0;
  int bounsVariable = 0;
  bool gameIsStarted = false;

  bool gameIsPaused = false;
  late Timer gameTimer;

  int snakeSpeed = 250;

  bool bonusFoodActive = false;
  Timer? bonusFoodTimer;

  void toggleGame() {
    setState(() {
      if (gameIsStarted) {
        gameIsPaused = !gameIsPaused;
      } else {
        startGame();
      }
    });
  }

  void startBonusFoodTimer() {
    bonusFoodTimer = Timer(Duration(seconds: 10), () {
      setState(() {
        bonusFoodActive = false;
        bonusFoodPos = -1;
      });
    });
  }

  void startGame() {
    gameIsStarted = true;

    gameTimer = Timer.periodic(Duration(milliseconds: snakeSpeed), (timer) {
      setState(() {
        if (!gameIsPaused) {
          moveSnake();
          print(snakeSpeed);

          if (gameOver()) {
            timer.cancel();
            gameOverDialog(); // Show the game over dialog
          }
        }
      });
    });
  }

  void eatNormalFood() {
    currentScore += 1;
    foodPos = Random().nextInt(numberOfItems);

    if (bounsVariable % 5 == 0) {
      activateBonusFood();
    }
  }

  void activateBonusFood() {
    bonusFoodActive = true;
    bonusFoodPos = Random().nextInt(numberOfItems);
    startBonusFoodTimer();
  }

  void eatBonusFood() {
    currentScore += 5;
    bonusFoodTimer?.cancel();
    bonusFoodActive = false;
    bonusFoodPos = -1;
  }

  void eatFood() {
    if (bonusFoodActive && snakePos.last == bonusFoodPos) {
      eatBonusFood();
    } else {
      eatNormalFood();
    }

    snakeSpeed = snakeSpeed - 10;
    gameTimer.cancel();
    gameTimer = Timer.periodic(Duration(milliseconds: snakeSpeed), (timer) {
      setState(() {
        if (!gameIsPaused) {
          moveSnake();
          if (gameOver()) {
            timer.cancel();
            gameOverDialog();
          }
        }
      });
    });
  }

  void moveSnake() {
    bounsVariable = bounsVariable + 1;

    int head = snakePos.last;

    switch (currentDirection) {
      case SnakeDirection.RIGHT:
        {
          if ((head + 1) % numberOfRows == 0) {
            snakePos.add(head - numberOfRows + 1);
          } else {
            snakePos.add(head + 1);
          }
        }
        break;
      case SnakeDirection.LEFT:
        {
          if (head % numberOfRows == 0) {
            snakePos.add(head - 1 + numberOfRows);
          } else {
            snakePos.add(head - 1);
          }
        }
        break;
      case SnakeDirection.UP:
        {
          if (head < numberOfRows) {
            snakePos.add(head - numberOfRows + numberOfItems);
          } else {
            snakePos.add(head - numberOfRows);
          }
        }
        break;
      case SnakeDirection.DOWN:
        {
          if (head + numberOfRows >= numberOfItems) {
            snakePos.add(head + numberOfRows - numberOfItems);
          } else {
            snakePos.add(head + numberOfRows);
          }
        }
        break;
      default:
    }

    if (snakePos.last == foodPos ||
        (bonusFoodActive && snakePos.last == bonusFoodPos)) {
      eatFood();
    } else {
      snakePos.removeAt(0);
    }
  }

  bool gameOver() {
    List<int> bodySnake = snakePos.sublist(0, snakePos.length - 1);

    if (bodySnake.contains(snakePos.last)) {
      return true;
    }
    return false;
  }

  void gameOverDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: AlertDialog(
            title: Text("Game over"),
            content: Text(
                "Your current score is " + currentScore.toString() + "\nGG BG"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                  newGame(); // Start a new game
                },
                child: Text("Replay"),
              ),
            ],
          ),
        );
      },
    );
  }

  void newGame() {
    setState(() {
      snakePos = [50, 51];
      foodPos = Random().nextInt(130);
      bonusFoodPos = -1;
      currentDirection = SnakeDirection.RIGHT;
      gameIsStarted = false;
      snakeSpeed = 250;
      currentScore = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // high score
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Your Score",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 233, 199, 30),
                        fontSize: 30,
                      ),
                    ),
                    Text(
                      "<<" + currentScore.toString() + ">>",
                      style: TextStyle(
                        fontSize: 30,
                        color: const Color.fromARGB(255, 233, 199, 30),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),

          // grid game
          Expanded(
            flex: 4,
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                if (details.delta.dy > 0) {
                  print('move down');
                  currentDirection = SnakeDirection.DOWN;
                } else if (details.delta.dy < 0) {
                  print('move up');
                  currentDirection = SnakeDirection.UP;
                }
              },
              onHorizontalDragUpdate: (details) {
                if (details.delta.dx > 0) {
                  print('move right');
                  currentDirection = SnakeDirection.RIGHT;
                } else if (details.delta.dx < 0) {
                  print('move left');
                  currentDirection = SnakeDirection.LEFT;
                }
              },
              child: GridView.builder(
                itemCount: numberOfItems,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: numberOfRows,
                ),
                itemBuilder: (context, index) {
                  if (snakePos.contains(index)) {
                    return const SnakePixel();
                  } else if (foodPos == index) {
                    return const FoodPixel();
                  } else if (bonusFoodActive && bonusFoodPos == index) {
                    return const BounesPixel();
                  } else {
                    return const BlankPixel();
                  }
                },
              ),
            ),
          ),

          // play btn
          Expanded(
            child: Container(
              child: Center(
                child: MaterialButton(
                  height: 80,
                  minWidth: 80,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        50.0), // Adjust the radius as needed
                  ),
                  child:
                      Text(gameIsStarted && !gameIsPaused ? 'Pause' : 'Play'),
                  color: const Color.fromARGB(255, 233, 199, 30),
                  onPressed: toggleGame,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
