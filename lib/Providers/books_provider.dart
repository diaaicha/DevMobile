import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../models/book_model.dart';


final booksProvider = StateProvider<List<Book>>((ref) {
  return [
    Book(
      id: '1',
      title: "Atomic Habits",
      price: 8500,
      image: "assets/images/book1.jpg",
      category: "Développement personnel",
      description: "Un guide pratique pour créer de bonnes habitudes et transformer sa vie.",
      author: "James Clear",
      rating: 4.5,
    ),
    Book(
      id: '2',
      title: "Rich Dad Poor Dad",
      price: 6500,
      image: "assets/images/book2.jpg",
      category: "Finance",
      description: "Un classique de l'éducation financière pour changer sa vision de l'argent.",
      author: "Robert Kiyosaki",
      rating: 4.3,
    ),
    Book(
      id: '3',
      title: "Start With Why",
      price: 7000,
      image: "assets/images/book3.jpg",
      category: "Leadership",
      description: "Comprendre pourquoi les leaders inspirants réussissent.",
      author: "Simon Sinek",
      rating: 4.2,
    ),
    Book(
      id: '4',
      title: "Le pouvoir du moment présent",
      price: 9000,
      image: "assets/images/book4.jpg",
      category: "Spiritualité",
      description: "Apprendre à vivre pleinement l'instant présent.",
      author: "Eckhart Tolle",
      rating: 4.6,
    ),


  ];
});


final bookByIdProvider = Provider.family<Book?, String>((ref, id) {
  final books = ref.watch(booksProvider);
  try {
    return books.firstWhere((book) => book.id == id);
  } catch (e) {
    return null;
  }
});


final booksByCategoryProvider = Provider.family<List<Book>, String>((ref, category) {
  final books = ref.watch(booksProvider);
  return books.where((book) => book.category == category).toList();
});


final topRatedBooksProvider = Provider<List<Book>>((ref) {
  final books = ref.watch(booksProvider);
  return books.where((book) => book.rating >= 4.0).toList();
});


final bestSellingBooksProvider = Provider<List<Book>>((ref) {
  final books = ref.watch(booksProvider);

  return books.take(4).toList();
});