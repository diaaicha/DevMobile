// ============================================================================
// FICHIER : lib/screens/login_screen.dart  (Version ConsumerWidget + Riverpod)
// ============================================================================
//
// Cet écran représente la page de connexion de DakarConnect.
// Il est conçu pour être *hautement pédagogique* et illustrer des concepts
// fondamentaux en Flutter moderne :
//
//  - ConsumerWidget (lecture des providers avec Riverpod),
//  - gestion de l’authentification via authStateProvider,
//  - navigation automatique via GoRouter et logique de redirection,
//  - structure Material Design (Scaffold, AppBar, TextField…),
//  - bonnes pratiques ergonomiques (SingleChildScrollView, padding, icons…).
//
// Cet exemple constitue un support de cours idéal pour expliquer comment
// connecter un formulaire simple à un système d’authentification réactif.
//
// ============================================================================


// Importation du package principal de Flutter pour les widgets Material.
import 'package:flutter/material.dart';

// Importation de GoRouter pour avoir accès aux fonctionnalités de navigation
// comme context.go() si on voulait ajouter un lien vers une page d'inscription par exemple.
import 'package:go_router/go_router.dart';

// Importation de Riverpod pour pouvoir interagir avec nos providers.
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Importation du provider d'authentification que nous avons créé.
// C'est lui qui contient l'état "connecté / déconnecté".
import '../providers/auth_provider.dart';


/// ===========================================================================
/// LoginScreen : un ConsumerWidget
/// ===========================================================================
///
/// Pourquoi ConsumerWidget ?
///
///   - Au lieu d’être un StatelessWidget, il reçoit un paramètre supplémentaire :
///         WidgetRef ref
///     qui permet d’interagir avec Riverpod.
///
///   - Cela permet de :
///       * lire un provider,
///       * modifier un provider,
///       * déclencher des actions basées sur des états globaux.
///
/// ConsumerWidget est la version “stateless + réactive” du StatefulWidget.
/// ===========================================================================
class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  // La méthode build prend maintenant un deuxième paramètre : WidgetRef ref.
  // ref = la télécommande qui nous donne accès à TOUS les providers.
  Widget build(BuildContext context, WidgetRef ref) {
    // Scaffold est la structure de base de notre page.
    return Scaffold(
      appBar: AppBar(
        // On rend le titre un peu plus centré et stylé.
        title: const Text("Bienvenue sur DakarConnect"),
        centerTitle: true,
      ),

      // Le corps de la page. On ajoute du Padding pour aérer les éléments.
      body: Padding(
        padding: const EdgeInsets.all(24.0),

        // SingleChildScrollView : indispensable pour éviter les overflow
        // lorsque le clavier couvre les champs.
        child: SingleChildScrollView(
          child: Column(
            // Aligne les enfants au centre verticalement.
            mainAxisAlignment: MainAxisAlignment.center,

            // Étire les enfants horizontalement.
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Un petit espace en haut pour centrer visuellement le formulaire.
              const SizedBox(height: 80),

              // ----------------------------------------------------------------
              // CHAMP EMAIL
              // ----------------------------------------------------------------
              const TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Adresse e-mail',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email_outlined),
                ),
              ),

              const SizedBox(height: 20),

              // ----------------------------------------------------------------
              // CHAMP MOT DE PASSE
              // ----------------------------------------------------------------
              const TextField(
                obscureText: true, // Cache le texte saisi.
                decoration: InputDecoration(
                  labelText: 'Mot de passe',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock_outline),
                ),
              ),

              const SizedBox(height: 40),

              // ----------------------------------------------------------------
              // BOUTON DE CONNEXION (SIMULATION)
              // ----------------------------------------------------------------
              //
              // Ce bouton illustre parfaitement :
              //   - comment modifier l’état d’un provider,
              //   - comment déclencher une redirection automatique via GoRouter,
              //   - comment connecter UI → Providers → Router.
              ElevatedButton(
                onPressed: () {
                  // Voici le cœur du mécanisme :
                  //
                  // 1) ref.read() permet de lire un provider sans écouter les changements.
                  //    (Parfait ici car on ne veut pas “observer” authStateProvider,
                  //     on veut simplement le modifier une fois.)
                  //
                  // 2) .notifier donne accès au contrôleur du StateProvider.
                  //
                  // 3) .state = true modifie réellement la valeur du provider.
                  //
                  // Dès que cette valeur change :
                  //   - GoRouter détecte la modification,
                  //   - relance sa logique de redirection,
                  //   - l’utilisateur est automatiquement renvoyé vers /home
                  //     s’il est considéré comme connecté.
                  ref.read(authStateProvider.notifier).state = true;
                },

                // Style du bouton
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // Texte du bouton
                child: const Text('Se Connecter (Simulation)'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
