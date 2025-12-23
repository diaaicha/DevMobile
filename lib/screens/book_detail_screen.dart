import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/book_model.dart';
import '../widgets/book_card.dart';

class BookDetailScreen extends StatelessWidget {
  final Book book;
  final List<Book> sameCategoryBooks;

  const BookDetailScreen({
    super.key,
    required this.book,
    required this.sameCategoryBooks,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.green),
          onPressed: () => context.go('/home'),
          tooltip: 'Retour à l’accueil',
        ),
        title: Text(
          book.title,
          style: const TextStyle(color: Colors.green),
        ),
      ),


      body: SingleChildScrollView(

        padding: const EdgeInsets.all(16),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            ClipRRect(

              borderRadius: BorderRadius.circular(12),

              child: Image.asset(
                book.image,
                height: 600,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 16),

            Text(
              book.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Par ${book.author}",
              style: const TextStyle(color: Colors.green),
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                const Icon(Icons.star, color: Colors.orange),
                const SizedBox(width: 5),
                Text(book.rating.toString()),
              ],
            ),

            const SizedBox(height: 15),

            Text(
              book.description,
              style: const TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
