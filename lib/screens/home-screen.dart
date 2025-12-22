import 'package:flutter/material.dart';
import '../models/book_model.dart';
import '../widgets/book_card.dart';
import '../widgets/header.dart';
import '../widgets/footer.dart';
import 'book_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

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
      description: "Un classique de l’éducation financière pour changer sa vision de l’argent.",
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

  Color primaryColor = const Color(0xFF226D68);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      // ---------------- HEADER ----------------
      appBar: const AppHeader(title: "Accueil"),

      // ---------------- BODY ----------------
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // -------- RECHERCHE --------
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              margin: const EdgeInsets.only(bottom: 16),
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
              child: Row(
                children: const [
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
            ),

            // -------- LISTE DES LIVRES --------
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
                final book = books[index];
                return BookCard(
                  book: book,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BookDetailScreen(
                          book: book,
                          sameCategoryBooks: books.where((b) => b.category == book.category && b != book).toList(),
                        ),
                      ),
                    );
                  },
                );
              },
            ),

            const SizedBox(height: 25),

            // -------- BEST SELLERS --------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Livres les plus vendus",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    foregroundColor: primaryColor,
                  ),
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
                  final book = books[index];
                  return MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Container(
                      width: 150,
                      margin: const EdgeInsets.only(right: 12),
                      child: BookCard(
                        book: book,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BookDetailScreen(
                                book: book,
                                sameCategoryBooks: books.where((b) => b.category == book.category && b != book).toList(),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // ---------------- FOOTER ----------------
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
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
