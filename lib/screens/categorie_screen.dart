import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategorieScreen extends ConsumerWidget {
  const CategorieScreen({super.key});

  // Liste des catégories avec des icônes appropriées
  final List<Map<String, dynamic>> categories = const [
    {"name": "Histoire", "icon": Icons.history, "key": "Histoire"},
    {"name": "Spiritualité", "icon": Icons.spa, "key": "Spiritualité"},
    {"name": "Leadership", "icon": Icons.leaderboard, "key": "Leadership"},
    {"name": "Langues et littérature", "icon": Icons.menu_book, "key": "Langues et littérature"},
    {"name": "Finance", "icon": Icons.attach_money, "key": "Finance"},
    {"name": "Développement personnel", "icon": Icons.self_improvement, "key": "Développement personnel"},
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Catégories"),
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/home'),
          tooltip: 'Retour à l\'accueil',
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Implémenter la recherche
            },
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
              onChanged: (value) {
                // TODO: Filtrer les catégories en fonction de la recherche
              },
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

            /// Grille des catégories
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.1,
                children: categories.map((cat) {
                  return CategoryCard(
                    name: cat["name"] as String,
                    icon: cat["icon"] as IconData,
                    categoryKey: cat["key"] as String,
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),

      /// Floating Action Button pour signaler/ajouter
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go('/report');
        },
        backgroundColor: const Color(0xFF226D68),
        child: const Icon(Icons.add),
      ),
    );
  }
}

/// ===========================================================================
/// WIDGET CategoryCard
/// ===========================================================================

class CategoryCard extends StatelessWidget {
  final String name;
  final IconData icon;
  final String categoryKey;

  const CategoryCard({
    super.key,
    required this.name,
    required this.icon,
    required this.categoryKey,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Redirection vers la page des livres de cette catégorie
        context.go('/category/$categoryKey');
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _getCategoryColor(categoryKey).withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _getCategoryColor(categoryKey).withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
              color: _getCategoryColor(categoryKey),
            ),
            const SizedBox(height: 10),
            Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: _getCategoryColor(categoryKey),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              _getBookCountText(categoryKey),
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Méthode pour obtenir une couleur spécifique à chaque catégorie
  Color _getCategoryColor(String category) {
    switch (category) {
      case "Histoire":
        return Colors.blue;
      case "Spiritualité":
        return Colors.purple;
      case "Leadership":
        return Colors.orange;
      case "Langues et littérature":
        return Colors.green;
      case "Finance":
        return Colors.red;
      case "Développement personnel":
        return Colors.teal;
      default:
        return const Color(0xFF226D68);
    }
  }

  // Texte indiquant le nombre de livres (à adapter avec vos données)
  String _getBookCountText(String category) {
    // TODO: Remplacer par le vrai compte de livres depuis votre provider
    final fakeCounts = {
      "Histoire": 12,
      "Spiritualité": 8,
      "Leadership": 15,
      "Langues et littérature": 20,
      "Finance": 10,
      "Développement personnel": 18,
    };

    final count = fakeCounts[category] ?? 0;
    return "$count livre${count > 1 ? 's' : ''}";
  }
}