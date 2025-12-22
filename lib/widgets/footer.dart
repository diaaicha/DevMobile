import 'package:flutter/material.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16), // padding pour le contenu
      color: Colors.grey[200],           // fond gris clair
      child: const Center(
        child: Text(
          '© 2025 DakarConnect',
          style: TextStyle(
            color: Colors.black54,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
