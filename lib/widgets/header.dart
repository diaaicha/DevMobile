import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const AppHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Container(
        height: 45,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Row(
          children: [
            Icon(Icons.search, color: Colors.grey),
            SizedBox(width: 8),
            Expanded(
              child: TextField(
                enabled: false, // champ statique pour l'instant
                decoration: InputDecoration(
                  hintText: "Rechercher",
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
