import 'package:DevMobile/screens/header-footer.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/books_provider.dart';

import '../providers/auth_provider.dart';
import '../screens/commande_detail_screen.dart';
import '../screens/home-screen.dart';
import '../screens/login_screen.dart';

import '../screens/categorie_screen.dart';
import '../screens/parametres_screen.dart';
import '../screens/commande_list_screen.dart';
import '../screens/confirmation_support_screen.dart';
import '../screens/profil_screen.dart';
import '../screens/register_screen.dart';
import '../screens/resetPassword_screen.dart';
import '../screens/SupportClient_screen.dart';
import '../screens/book_detail_screen.dart';
import '../screens/CategoryBooksScreen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: '/home',


    redirect: (context, state) {
      final location = state.matchedLocation;
      final isLogin = location == '/login';
      final isRegister = location == '/register';
      final isReset = location == '/reset';
      final isSupport = location == '/support';


      final publicRoutes = [isLogin, isRegister, isReset, isSupport];


      if (!authState && !publicRoutes.contains(true)) {
        return '/login';
      }


      if (authState && (isLogin || isRegister)) {
        return '/home';
      }

      return null;
    },


    routes: [

      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/reset',
        name: 'reset',
        builder: (context, state) => const ResetPasswordScreen(),
      ),
      GoRoute(
        path: '/support',
        name: 'support',
        builder: (context, state) => const SupportClientScreen(),
      ),


      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return HeaderScreen(navigationShell: navigationShell);
        },
        branches: [

          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                name: 'home',
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/categorie',
                name: 'categorie',
                builder: (context, state) => const CategorieScreen(),
              ),
            ],
          ),




          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/messages',
                name: 'messages',
                builder: (context, state) => const SupportClientScreen(),
              ),
            ],
          ),


          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/commandes',
                name: 'commandes',
                builder: (context, state) => const CommandeListScreen(),
              ),
            ],
          ),


          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profil',
                name: 'profil',
                builder: (context, state) => const ProfilScreen(),
              ),
            ],
          ),
         StatefulShellBranch(
          routes: [
           GoRoute(
            path: '/parametres',
            name: 'parametres',
            builder: (context, state) => const ParametresScreen(),
            ),
           ],
          ),
        ],
      ),
          GoRoute(
        path: '/confirmation_support',
        name: 'confirmation_support',
        builder: (context, state) => const ConfirmationSupportScreen(),
      ),
      GoRoute(
        path: '/book/:id',
        name: 'book_detail',
        builder: (context, state) {
          final bookId = state.pathParameters['id'];
          final books = ref.read(booksProvider);
          final book = books.firstWhere((book) => book.id == bookId); // Suppose que Book a un champ id
          final sameCategoryBooks = books.where((b) => b.category == book.category && b.id != book.id).toList();
          return BookDetailScreen(
            book: book,
            sameCategoryBooks: sameCategoryBooks,
          );
        },
      ),
      GoRoute(
        path: '/category/:categoryName',
        name: 'category_books',
        builder: (context, state) {
          final categoryName = state.pathParameters['categoryName'] ?? '';
          return CategoryBooksScreen(
            categoryName: categoryName,
          );
        },
      ),

      GoRoute(
        path: '/commande/:id',
        name: 'commande_detail',
        builder: (context, state) {
          final commandeId = state.pathParameters['id'] ?? '';
          return CommandeDetailScreen(commandeId: commandeId);
        },
      ),
    ],


    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Erreur 404: Page non trouvée - ${state.uri}'),
      ),
    ),
  );
});