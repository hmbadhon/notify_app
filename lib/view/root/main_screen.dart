import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hmb_app/utils/constants.dart';
import 'package:hmb_app/view/home_screen/home_screen.dart';
import 'package:hmb_app/view/profile/profile_screen.dart';

class MainScreen extends StatefulWidget {
  static const routeName = 'main_screen';
  const MainScreen({Key? key, this.index = 0}) : super(key: key);
  final int? index;

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int _selectedIndex;
  final List<Widget> _screen = [
    HomeScreen(),
    ProfileScreen(),
  ];
  Future<bool> _onBackPressed() {
    return Get.defaultDialog(
      title: 'Are you sure?',
      content: const Text('It will exit the app!'),
      actions: <Widget>[
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: kPrimaryColor,
          ),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: const Text("Confirm"),
        ),
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: const Text(
            "Cancel",
            style: TextStyle(color: kPrimaryColor),
          ),
        ),
      ],
    ).then((value) => value as bool);
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    _selectedIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_selectedIndex == 0) {
          return _onBackPressed();
        } else {
          setState(
            () {
              _selectedIndex = 0;
            },
          );
        }
        return false;
      },
      child: Scaffold(
        body: _screen[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          elevation: 5,
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: kPrimaryColor,
          unselectedItemColor: Colors.grey,
          onTap: _onPageChanged,
        ),
      ),
    );
  }
}
