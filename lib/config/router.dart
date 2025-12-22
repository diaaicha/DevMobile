// ============================================================================
// FICHIER : lib/config/router.dart
// ============================================================================
//
// Ce fichier configure toute la navigation de votre application DakarConnect,
// et introduit un concept fondamental dans les applications modernes :
// la **navigation conditionnelle basée sur l’authentification**.
//
// Grâce à GoRouter + Riverpod :
//   - nous pouvons écouter l’état d’authentification,
//   - empêcher un utilisateur non connecté d’accéder à certaines pages,
//   - rediriger automatiquement selon les règles métier,
//   - protéger la navigation (guarding routes).
//
// Ce fichier est un cadre pédagogique idéal pour expliquer la navigation
// déclarative, le pattern redirect, et l’intégration avec un provider global.
//
// ============================================================================

import 'package:DevMobile/screens/HomeScreen.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 1. Importez votre provider d'authentification.
// Ce provider (StateProvider<bool>) permet de savoir si l’utilisateur
// est connecté (true) ou non (false).
import '../providers/auth_provider.dart';

import '../screens/HomeScreen.dart';
import '../screens/login_screen.dart';
import '../screens/report_screen.dart';
import '../screens/categorie_screen.dart';


// ============================================================================
// 2. Provider routerProvider — version avancée
// ============================================================================
//
// On transforme un simple Provider<GoRouter> en un provider "réactif"
// capable de lire l’état d’autres providers grâce à 'ref'.
//
// Avantage majeur :
//   - le router se met à jour automatiquement dès que l’état d’authentification
//     change, ce qui permet des redirections instantanées.
// ============================================================================
final routerProvider = Provider<GoRouter>((ref) {

  // --------------------------------------------------------------------------
  // 3. On lit l’état d’authentification en temps réel.
  // --------------------------------------------------------------------------
  //
  // ref.watch(authStateProvider) permet :
  //   - d’écouter la valeur actuelle (true / false),
  //   - de reconstruire automatiquement le router si la valeur change.
  //
  final authState = ref.watch(authStateProvider);


  // --------------------------------------------------------------------------
  // CONFIGURATION DU ROUTEUR GoRouter
  // --------------------------------------------------------------------------
  return GoRouter(

    // Page affichée par défaut à l’ouverture de l’application.
    // Ici : la page d’accueil — mais l’accès sera filtré par le redirect().
    initialLocation: '/categorie',

    // ------------------------------------------------------------------------
    // REDIRECTION AUTOMATIQUE SELON L’AUTHENTIFICATION
    // ------------------------------------------------------------------------
    //
    // Fonction clé du routage professionnel :
    // elle est appelée à CHAQUE navigation.
    //
    // Elle permet d’écrire des règles métier du type :
    //   - “si l’utilisateur n’est pas connecté → renvoyer vers /login”
    //   - “si l’utilisateur est connecté → empêcher d’aller sur /login”
    //
    redirect: (context, state) {
      // 'state.matchedLocation' = l’URL où l’utilisateur veut se rendre.
      final requestedLocation = state.matchedLocation;

      // Détection : l’utilisateur essaie-t-il d’aller sur /login ?
      final isGoingToLogin = requestedLocation == '/login';


      // ----------------------------------------------------------------------
      // CAS 1 : UTILISATEUR NON CONNECTÉ
      // ----------------------------------------------------------------------
      //
      // S’il n’est pas connecté ET qu’il ne va pas sur /login → interdiction.
      if (!authState && !isGoingToLogin) {
        return '/login';   // On l’envoie vers la page de login
      }

      // ----------------------------------------------------------------------
      // CAS 2 : UTILISATEUR DÉJÀ CONNECTÉ
      // ----------------------------------------------------------------------
      //
      // Si l’utilisateur est connecté et tente d'aller sur /login,
      // nous l’empêchons de revenir sur cette page inutile.
      if (authState && isGoingToLogin) {
        return '/home';    // On le redirige vers son tableau de bord
      }

      // ----------------------------------------------------------------------
      // CAS 3 : TOUT EST OK → aucune redirection
      // ----------------------------------------------------------------------
      return null;
    },


    // ------------------------------------------------------------------------
    // DÉFINITION DES ROUTES
    // ------------------------------------------------------------------------
    //
    // Pas de changement particulier ici : uniquement les écrans disponibles.
    routes: [
      GoRoute(
        path: '/categorie',
        name: 'categorie',
        builder: (context, state) => const CategorieScreen(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/report',
        name: 'report',
        builder: (context, state) => const ReportScreen(),
      ),
    ],
  );
});
