import 'package:flutter/material.dart';
import '../widgets/header.dart';
import '../widgets/footer.dart';
import '../models/book_model.dart';
import '../widgets/book_card.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<Book> books = [
    Book(
      title: "Atomic Habits",
      price: 8500,
      image: "assets/images/book1.jpg",
      category: "Développement personnel",
      description: "Un guide pratique pour créer de bonnes habitudes et transformer sa vie.",
      author: "James Clear",
      rating: 4.5,
    ),
    Book(
      title: "Rich Dad Poor Dad",
      price: 6500,
      image: "assets/images/book2.jpg",
      category: "Finance",
      description: "Un classique de l’éducation financière.",
      author: "Robert Kiyosaki",
      rating: 4.3,
    ),
    Book(
      title: "Start With Why",
      price: 7000,
      image: "assets/images/book3.jpg",
      category: "Leadership",
      description: "Comprendre pourquoi les leaders inspirants réussissent.",
      author: "Simon Sinek",
      rating: 4.2,
    ),
    Book(
      title: "Le pouvoir du moment présent",
      price: 9000,
      image: "assets/images/book4.jpg",
      category: "Spiritualité",
      description: "Apprendre à vivre pleinement l’instant présent.",
      author: "Eckhart Tolle",
      rating: 4.6,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: const AppHeader(title: "Accueil"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Liste des livres
            const Text(
              "Liste des livres",
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
                return BookCard(book: books[index]);
              },
            ),

            const SizedBox(height: 25),

            // Best Sellers
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Livres les plus vendus",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: null, // statique pour l'instant
                  child: const Text("Voir tout"),
                ),
              ],
            ),

            const SizedBox(height: 10),

            SizedBox(
              height: 220,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: books.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: 150,
                    margin: const EdgeInsets.only(right: 12),
                    child: BookCard(book: books[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppFooter(currentIndex: 0),
    );
  }
}
