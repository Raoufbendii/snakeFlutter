import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  @override
  _NavBar createState() => _NavBar();
}

class _NavBar extends State<NavBar> {
  int currentTab = 0; // to keep track of active tab index

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Image.asset('assets/icons/robotIconNotSelected.png'),
          backgroundColor: Colors.black,
          onPressed: () {
            print("pressed");
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 10,
          child: Container(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MaterialButton(
                  minWidth: 80,
                  onPressed: () {
                    setState(() {
                      currentTab = 0;
                    });
                    print("Home");
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Image.asset(
                          'assets/icons/homeIconNotSelected.png',
                          color: currentTab == 0 ? Colors.blue : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                MaterialButton(
                  minWidth: 80,
                  onPressed: () {
                    setState(() {
                      currentTab = 1;
                    });
                    print("Favorite");
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Image.asset(
                          'assets/icons/favoriteIconNotSelected.png',
                          color: currentTab == 1 ? Colors.blue : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                    width:
                        20), // Adjust the spacing between Favorite and Notification
                MaterialButton(
                  minWidth: 80,
                  onPressed: () {
                    setState(() {
                      currentTab = 2;
                    });
                    print("Notification");
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Image.asset(
                          'assets/icons/notificationIconSelected.png',
                          color: currentTab == 2 ? Colors.blue : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                MaterialButton(

                  minWidth: 80,
                  onPressed: () {
                    setState(() {
                      currentTab = 3;
                    });
                    print("Profile");
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Image.asset(
                          'assets/icons/profileIconNotSelected.png',
                          color: currentTab == 3 ? Colors.blue : Colors.grey,
                        ),
                      ),
                    ],
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
