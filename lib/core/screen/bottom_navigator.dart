import 'package:demo_ecom/core/screen/profile/profile.dart';
import 'package:demo_ecom/utils/services/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'cart.dart';
import 'home/home_page.dart';

class BottomNavBar extends StatefulWidget {
  final int navIndex;
  const BottomNavBar({this.navIndex = 0});
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    _selectedIndex = widget.navIndex;
    super.initState();
  }

  static final List<Widget> _children = <Widget>[
    const HomePage(),
    const CartDetailsPage(),
    const ProfilePage(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: CustomColors.primary,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.home,
              size: 20,
            ),
            title: Text(
              'Home',
              style: TextStyle(fontFamily: 'Poppins', fontSize: 14),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.shoppingCart, size: 20),
            title: Text(
              'Cart',
              style: TextStyle(fontFamily: 'Poppins', fontSize: 14),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.solidUser, size: 20),
            title: Text(
              'Profile',
              style: TextStyle(fontFamily: 'Poppins', fontSize: 14),
            ),
          ),
        ],
        currentIndex: _selectedIndex,
        showUnselectedLabels: true,
        selectedItemColor: Colors.pinkAccent,
        onTap: _onItemTapped,
      ),
      body: _children[_selectedIndex],
    );
  }
}
