// ============================================================================
// FICHIER : lib/screens/home_screen.dart
// ============================================================================
//
// Cet écran représente la page d’accueil de DakarConnect.
// Il présente :
//   - une liste d’incidents (dummy data pour le moment),
//   - un widget personnalisé IncidentCard pour l’affichage,
//   - un FloatingActionButton permettant d’ajouter un nouveau signalement,
//   - l’utilisation de GoRouter pour naviguer vers /report.
//
// Ce fichier constitue un excellent support de cours pour comprendre :
//   • la construction de listes dynamiques,
//   • l’architecture widgetisée (séparation UI/logiciel),
//   • la navigation Flutter moderne,
//   • l’usage d’un FAB (FloatingActionButton).
//
// ============================================================================

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Import modèle et widget de carte
import '../models/incident_model.dart';
import '../widgets/incident_card.dart';

/// Page d’accueil affichant la liste des signalements.
/// Ajout d’un bouton “+” pour créer un nouveau signalement (route /report).
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    // ------------------------------------------------------------------------
    // 1. LISTE FACTICE D’INCIDENTS (dummyIncidents)
    // ------------------------------------------------------------------------
    //
    // Pour le moment, on utilise des données codées en dur afin de tester
    // l’affichage. Cela prépare l’intégration future d’une base de données,
    // d’une API REST, ou de Firebase.
    //
    // Chaque élément est une instance du modèle Incident.
    final List<Incident> dummyIncidents = [
      Incident(
        titre: 'Nid de poule dangereux',
        description: 'Un grand trou sur la VDN en face de la station Shell.',
        imageUrl: 'https://picsum.photos/seed/picsum/400/200',
        date: DateTime.now().subtract(const Duration(days: 2)),
        lieu: 'VDN, Dakar',
      ),
      Incident(
        titre: 'Lampadaire en panne',
        description: "L’éclairage public ne fonctionne plus dans toute la rue.",
        imageUrl: 'https://picsum.photos/seed/picsum2/400/200',
        date: DateTime.now().subtract(const Duration(hours: 12)),
        lieu: 'Rue 10, Médina',
      ),
      Incident(
        titre: 'Amassement d’ordures',
        description: 'Les poubelles débordent depuis plusieurs jours.',
        imageUrl: 'https://picsum.photos/seed/picsum3/400/200',
        date: DateTime.now().subtract(const Duration(days: 5)),
        lieu: 'Parcelles Assainies, Unité 15',
      ),
    ];

    // ------------------------------------------------------------------------
    // 2. SCAFFOLD → STRUCTURE VISUELLE D'UNE PAGE MATERIAL
    // ------------------------------------------------------------------------
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signalements récents'),
      ),

      // ----------------------------------------------------------------------
      // 3. LISTE DES INCIDENTS : ListView.builder
      // ----------------------------------------------------------------------
      //
      // Méthode la plus performante pour afficher des listes longues :
      //   - construit uniquement les éléments visibles dans le viewport,
      //   - permet un scroll fluide,
      //   - s’adapte automatiquement à de futures données dynamiques.
      //
      body: ListView.builder(
        itemCount: dummyIncidents.length, // Taille de la liste

        // itemBuilder : fonction responsable de construire chaque élément.
        itemBuilder: (context, index) {
          final incident = dummyIncidents[index];

          // On retourne un widget IncidentCard pour chaque élément.
          // C’est une bonne pratique : séparer l’affichage dans un widget dédié.
          return IncidentCard(incident: incident);
        },
      ),

      // ----------------------------------------------------------------------
      // 4. FloatingActionButton → Bouton d'action principal (FAB)
      // ----------------------------------------------------------------------
      //
      // Le FAB sert à lancer l’action principale d’une page.
      // Ici : créer un nouveau signalement.
      //
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigation déclarative moderne via GoRouter
          // Très lisible, très simple.
          context.go('/report');
        },

        tooltip: 'Créer un signalement',

        // Icône "plus" intuitive pour ajouter un nouvel élément
        child: const Icon(Icons.add),
      ),
    );
  }
}
