// ============================================================================
// FICHIER : lib/screens/report_screen.dart
// ============================================================================
//
// Cet écran représente la page de création d’un nouveau signalement
// dans l’application DakarConnect.
//
// Notions clés illustrées :
//   - StatefulWidget (formulaire interactif),
//   - GlobalKey<FormState> pour la validation globale,
//   - TextFormField + validator pour la validation champ par champ,
//   - SingleChildScrollView pour éviter les débordements avec le clavier,
//   - GoRouter (context.go) pour la navigation vers /home,
//   - SnackBar pour le feedback utilisateur.
//
// Ce fichier peut être utilisé comme support de cours pour aborder
// la conception de formulaires professionnels dans Flutter.
//
// ============================================================================

// Fichier : lib/screens/report_screen.dart
import 'package:flutter/material.dart';
// 1) Importez GoRouter pour utiliser context.go()
import 'package:go_router/go_router.dart';

/// Écran de création de signalement (formulaire).
/// On utilise un StatefulWidget car un formulaire :
//// - doit réagir aux interactions utilisateur,
//// - pourra mémoriser des valeurs (controllers, états, erreurs),
//// - doit gérer proprement son cycle de vie.
class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});
  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  // Clé du formulaire
  //
  // GlobalKey<FormState> permet de :
  //   - récupérer l’état du formulaire (_formKey.currentState),
  //   - lancer la validation globale (validate()),
  //   - déclencher éventuellement save() pour sauvegarder les valeurs.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ----------------------------------------------------------------------
      // BARRE SUPÉRIEURE (AppBar)
      // ----------------------------------------------------------------------
      appBar: AppBar(
        title: const Text("Faire un nouveau signalement"),
        // 2) Ajoutez un bouton retour vers l’accueil avec GoRouter
        //
        // 'leading' permet de définir l’icône affichée à gauche de l’AppBar.
        // Ici, un bouton retour qui ramène l’utilisateur à la page d’accueil.
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          // context.go('/home') demande à GoRouter de naviguer vers la route /home.
          onPressed: () => context.go('/home'),
          tooltip: 'Retour à l’accueil',
        ),
      ),

      // ----------------------------------------------------------------------
      // CORPS DE LA PAGE : FORMULAIRE DANS UN SCROLL
      // ----------------------------------------------------------------------
      //
      // 3) Conservez SingleChildScrollView pour éviter les overflow avec le clavier
      //
      // SingleChildScrollView permet :
      //   - de faire défiler la page si le clavier recouvre les champs,
      //   - d’éviter les erreurs de type "Bottom overflowed by X pixels".
      body: SingleChildScrollView(
        child: Padding(
          // Padding : marges internes autour du formulaire pour une meilleure UX.
          padding: const EdgeInsets.all(20.0),

          // 4) Le formulaire regroupe et valide les champs
          //
          // Le widget Form :
          //   - centralise la validation des champs grâce à _formKey,
          //   - permet d’appeler validate() pour tous les TextFormField enfants.
          child: Form(
            key: _formKey,
            child: Column(
              // crossAxisAlignment.stretch :
              //   - les widgets "prennent" toute la largeur disponible,
              //   - pratique pour les boutons pleine largeur.
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // --------------------------------------------------------------
                // --- CHAMP TITRE ---
                // --------------------------------------------------------------
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Titre du signalement',
                    hintText: 'Ex: Nid de poule dangereux',
                    border: OutlineInputBorder(),
                  ),
                  // validator : fonction appelée lors de validate()
                  // Elle retourne :
                  //   - un message d’erreur (String) → champ invalide,
                  //   - null → tout va bien pour ce champ.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer un titre.';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // --------------------------------------------------------------
                // --- CHAMP DESCRIPTION ---
                // --------------------------------------------------------------
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Description détaillée',
                    hintText: 'Donnez plus de détails sur le problème...',
                    border: OutlineInputBorder(),
                  ),
                  // maxLines : on transforme le champ en zone de texte multi-lignes,
                  // plus adapté à une description détaillée.
                  maxLines: 4,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer une description.';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // --------------------------------------------------------------
                // --- BOUTON AJOUTER UNE PHOTO ---
                // --------------------------------------------------------------
                //
                // OutlinedButton.icon :
                //   - bouton avec uniquement une bordure,
                //   - bien adapté pour les actions secondaires (ici : ajouter une photo).
                OutlinedButton.icon(
                  onPressed: () {
                    // La logique caméra/galerie sera ajoutée plus tard.
                    // 5) Rien à changer ici pour GoRouter.
                    debugPrint('Ajouter une photo cliqué');
                  },
                  icon: const Icon(Icons.camera_alt),
                  label: const Text("Ajouter une photo"),
                  style: OutlinedButton.styleFrom(
                    // minimumSize : hauteur minimale du bouton
                    minimumSize: const Size.fromHeight(50),
                    // alignment : place l’icône + texte vers la gauche
                    alignment: Alignment.centerLeft,
                    // padding interne : espace entre le contenu et les bords
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),

                const SizedBox(height: 30),

                // --------------------------------------------------------------
                // --- BOUTON DE SOUMISSION ---
                // --------------------------------------------------------------
                ElevatedButton(
                  onPressed: () {
                    // 6) Validez le formulaire puis redirigez vers /home
                    //
                    // _formKey.currentState!.validate() :
                    //   - appelle tous les validator des TextFormField,
                    //   - retourne true si tous les validators retournent null,
                    //   - sinon false et affiche les messages d’erreur.
                    if (_formKey.currentState!.validate()) {
                      // Si tous les champs sont valides :
                      // - Option A : feedback immédiat + navigation
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Signalement envoyé !')),
                      );
                      // Navigation vers la page d’accueil après l’envoi.
                      context.go('/home');

                      // Option B (commentée) : attendre un court délai avant la navigation
                      // pour laisser le temps au SnackBar d’être vu.
                      // Future.delayed(const Duration(milliseconds: 400), () {
                      //   context.go('/home');
                      // });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                  child: const Text('Envoyer le Signalement'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
