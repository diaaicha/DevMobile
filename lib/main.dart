// ============================================================================
// FICHIER : lib/main.dart (version complète avec Riverpod + GoRouter)
// ============================================================================
//
// Ce fichier est le point d’entrée de l’application Flutter.
// Il montre comment combiner :
//   - ProviderScope (Riverpod) : gestion d’état globale,
//   - ConsumerWidget : lecture des providers dans l’arbre,
//   - GoRouter : navigation professionnelle et déclarative,
//   - MaterialApp.router : nouvelle façon moderne de gérer les routes.
//
// Ce fichier est un excellent exemple d’architecture Flutter moderne.
//
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 1. Importez votre nouvelle configuration de routeur.
// Ce fichier expose le provider "routerProvider" contenant l’instance GoRouter.
import 'config/router.dart';

void main() {
  // ProviderScope est la racine de tous les providers Riverpod.
  // Sans lui, aucun provider ne peut fonctionner.
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

// ===========================================================================
// 2. MyApp devient un ConsumerWidget
// ===========================================================================
//
// Pourquoi ConsumerWidget ?
//  - Il nous permet d’utiliser "ref" pour lire les providers.
//  - Contrairement à StatelessWidget, il peut réagir automatiquement si
//    un provider change (ex : changement d’état d’authentification).
//  - C’est la version recommandée avec Riverpod si l’on doit consommer un provider.
//
// ===========================================================================
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  // 'ref' est l’objet fourni par ConsumerWidget permettant d’accéder aux providers.
  // Il joue un rôle central dans Riverpod :
  //   - ref.watch() : écoute un provider (UI mise à jour automatiquement)
  //   - ref.read()  : lit un provider sans écouter
  //   - ref.listen(): réagit aux changements d’un provider (side effects)
  Widget build(BuildContext context, WidgetRef ref) {

    // 3. On lit notre routerProvider pour obtenir l'instance de GoRouter.
    //    Grâce à ref.watch(routerProvider), si le router change un jour
    //    (ex : redirection selon l'authentification), l’UI se mettra à jour.
    final router = ref.watch(routerProvider);

    // ------------------------------------------------------------------------
    // 4. MaterialApp.router : version moderne de la configuration d’app Flutter
    // ------------------------------------------------------------------------
    //
    // Pourquoi MaterialApp.router ?
    // - Approche déclarative alignée avec GoRouter.
    // - Gestion native du deep linking.
    // - Navigation centralisée et propre.
    //
    return MaterialApp.router(
      // Le router configuré dans router.dart
      routerConfig: router,

      debugShowCheckedModeBanner: false,

      // Définition d’un thème global (couleurs, composants, styles…)
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
    );
  }
}
