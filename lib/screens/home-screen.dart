import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../widgets/book_card.dart';
import '../providers/books_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final booksState = ref.watch(booksProvider.notifier);
    final books = ref.watch(booksProvider);
    final bestSellingBooks = ref.watch(bestSellingBooksProvider);
    final topRatedBooks = ref.watch(topRatedBooksProvider);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            _buildSearchBar(),

            const SizedBox(height: 20),


            const Text(
              "Tous les livres",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

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
                  onTap: () => _navigateToBookDetail(context, book.id),
                );
              },
            ),

            const SizedBox(height: 25),


            _buildSectionHeader(
              title: "Les plus vendus",
              onSeeAll: () {},
            ),

            SizedBox(
              height: 220,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: bestSellingBooks.length,
                itemBuilder: (context, index) {
                  final book = bestSellingBooks[index];
                  return Container(
                    width: 150,
                    margin: const EdgeInsets.only(right: 12),
                    child: BookCard(
                      book: book,
                      onTap: () => _navigateToBookDetail(context, book.id),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 25),

            _buildSectionHeader(
              title: "Les mieux notés",
              onSeeAll: () {},
            ),

            SizedBox(
              height: 220,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: topRatedBooks.length,
                itemBuilder: (context, index) {
                  final book = topRatedBooks[index];
                  return Container(
                    width: 150,
                    margin: const EdgeInsets.only(right: 12),
                    child: BookCard(
                      book: book,
                      onTap: () => _navigateToBookDetail(context, book.id),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }


  void _navigateToBookDetail(BuildContext context, String bookId) {

    context.go('/book/$bookId');
  }

  Widget _buildSearchBar() {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: const Row(
        children: [
          Icon(Icons.search, color: Colors.grey),
          SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Rechercher un livre",
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader({
    required String title,
    required VoidCallback onSeeAll,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: onSeeAll,
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFF226D68),
          ),
          child: const Text("Voir tout"),
        ),
      ],
    );
  }
}