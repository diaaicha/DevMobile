import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CategorieScreen extends StatefulWidget {
  const CategorieScreen({super.key});

  @override
  State<CategorieScreen> createState() => _CategorieScreenState();
}

class _CategorieScreenState extends State<CategorieScreen> {

  final List<Map<String, dynamic>> categories = [
    {"name": "Histoire", "icon": Icons.menu_book},
    {"name": "Mathématique", "icon": Icons.calculate},
    {"name": "Sciences modernes", "icon": Icons.science},
    {"name": "Langues et littérature", "icon": Icons.history_edu},
    {"name": "Religions", "icon": Icons.business_center},
    {"name": "Philosophie", "icon": Icons.collections_bookmark},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Catégories"),
        elevation: 1,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),

            onPressed: () => context.go('/home'),
            tooltip: 'Retour à l’accueil',
          ),

        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),

      /// ================= BODY =================
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// Zone de recherche
            TextField(
              decoration: InputDecoration(
                hintText: "Rechercher une catégorie...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// Titre
            const Text(
              "Toutes les catégories",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            /// Grille
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.1,
                children: categories.map((cat) {
                  return CategoryCard(
                    name: cat["name"],
                    icon: cat["icon"],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),

      /// Floating button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go('/report');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

/// ===========================================================================
/// CLASSE CategoryCard DANS LE MÊME FICHIER
/// ===========================================================================

class CategoryCard extends StatelessWidget {
  final String name;
  final IconData icon;

  const CategoryCard({
    super.key,
    required this.name,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        debugPrint("Catégorie sélectionnée : $name");
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.blue.shade700),
            const SizedBox(height: 10),
            Text(
              name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}