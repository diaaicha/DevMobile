import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/header.dart';
class HeaderScreen extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const HeaderScreen({
    super.key,
    required this.navigationShell,
  });

  @override
  State<HeaderScreen> createState() => _HeaderScreenState();
}

class _HeaderScreenState extends State<HeaderScreen> {
  Color primaryColor = const Color(0xFF226D68);


  final List<String> _appBarTitles = [
    "Accueil",
    "Catégories",
    "Messages",
    "Panier",
    "Profil"
  ];

  void _onItemTapped(int index) {

    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],


      appBar: AppHeader(title: _appBarTitles[widget.navigationShell.currentIndex]),


      body: widget.navigationShell,


      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.navigationShell.currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Accueil",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: "Catégories",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: "Messages",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Panier",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profil",
          ),
        ],
      ),
    );
  }
}