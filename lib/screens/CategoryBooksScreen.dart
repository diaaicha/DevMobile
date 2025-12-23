import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../models/book_model.dart';
import '../providers/books_provider.dart';
import '../widgets/book_card.dart';

class CategoryBooksScreen extends ConsumerWidget {
  final String categoryName;

  const CategoryBooksScreen({
    super.key,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final books = ref.watch(booksProvider);


    final categoryBooks = books.where((book) => book.category == categoryName).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Livres : $categoryName"),
        backgroundColor: _getCategoryColor(categoryName),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.green),
          onPressed: () => context.go('/categorie'),
          tooltip: 'Retour à l’accueil',
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Recherche dans cette catégorie
            },
          ),
        ],
      ),

      body: categoryBooks.isEmpty
          ? _buildEmptyState(context)
          : _buildBookList(categoryBooks),
    );
  }

  Widget _buildBookList(List<Book> books) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // En-tête avec compteur
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${books.length} livre${books.length > 1 ? 's' : ''} trouvé${books.length > 1 ? 's' : ''}",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                // Option de tri (facultatif)
                PopupMenuButton<String>(
                  icon: const Icon(Icons.sort),
                  onSelected: (value) {
                    // TODO: Implémenter le tri
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'title',
                      child: Text('Trier par titre'),
                    ),
                    const PopupMenuItem(
                      value: 'price',
                      child: Text('Trier par prix'),
                    ),
                    const PopupMenuItem(
                      value: 'rating',
                      child: Text('Trier par note'),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Liste des livres
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: books.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.65,
            ),
            itemBuilder: (context, index) {
              final book = books[index];
              return BookCard(
                book: book,
                onTap: () {
                  // Navigation vers le détail du livre
                  context.go('/book/${book.id}');
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.category_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 20),
          Text(
            "Aucun livre dans cette catégorie",
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "Revenez plus tard !",
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () => context.go('/home'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF226D68),
            ),
            child: const Text("Retour à l'accueil"),
          ),
        ],
      ),
    );
  }

  // Même fonction de couleur que dans CategoryCard
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
}