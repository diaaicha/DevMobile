import 'package:flutter/material.dart';

// Importation du modèle Incident :
// indispensable pour accéder aux propriétés (titre, lieu, date, image…)
import '../models/incident_model.dart';


/// ===========================================================================
/// 1. DÉFINITION DU WIDGET IncidentCard
/// ===========================================================================
///
/// Ce widget stateless reçoit un objet Incident et construit une représentation
/// visuelle cohérente. Le choix d’un StatelessWidget est logique car cette carte
/// n’a pas d’état interne : elle ne change pas après son affichage.
///
class IncidentCard extends StatelessWidget {

  // --------------------------------------------------------------------------
  // PROPRIÉTÉ : Instance d’un incident
  // --------------------------------------------------------------------------
  //
  // Le widget a besoin de connaître les détails de l’incident qu’il doit afficher.
  // L'objet Incident donne accès à :
  //   - titre,
  //   - description,
  //   - imageUrl,
  //   - date,
  //   - lieu.
  //
  final Incident incident;

  // Constructeur : impose l’utilisation du paramètre required.
  const IncidentCard({super.key, required this.incident});

  @override
  Widget build(BuildContext context) {

    // ------------------------------------------------------------------------
    // STRUCTURE GLOBALE : UTILISATION DU WIDGET Card
    // ------------------------------------------------------------------------
    //
    // Card est un widget Material Design qui :
    //   - affiche une surface avec ombre (élévation),
    //   - possède des coins arrondis,
    //   - est idéal pour afficher des blocs d'information indépendants.
    //
    return Card(
      // Espace extérieur autour de la carte (marge horizontale + verticale).
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),

      // Hauteur de l'ombre. Plus la valeur est grande, plus la carte paraît "élevée".
      elevation: 4,

      // Empêche les enfants (l’image par exemple) de dépasser des coins arrondis.
      clipBehavior: Clip.antiAlias,

      // Column empile verticalement : image puis textes.
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Alignement à gauche

        children: [

          // ===================================================================
          // 1. IMAGE DE L’INCIDENT
          // ===================================================================
          //
          // Image provenant d’une URL. Flutter télécharge et affiche l’image.
          // fit: BoxFit.cover = remplit toute la largeur, rogne si nécessaire.
          //
          Image.network(
            incident.imageUrl,         // URL récupérée dans l’objet Incident
            height: 200,               // Hauteur fixe
            width: double.infinity,    // Occupe toute la largeur disponible
            fit: BoxFit.cover,         // Couvre l’espace sans déformation
          ),


          // ===================================================================
          // 2. CONTENU TEXTE (TITRE + LIEU)
          // ===================================================================
          //
          // Padding crée un espace intérieur autour du contenu.
          Padding(
            padding: const EdgeInsets.all(12.0),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                // --------------------------------------------------------------
                // TITRE DE L’INCIDENT
                // --------------------------------------------------------------
                Text(
                  incident.titre,
                  style: const TextStyle(
                    fontSize: 20,                  // Taille du texte
                    fontWeight: FontWeight.bold,   // Met en valeur le titre
                  ),
                ),

                const SizedBox(height: 8),


                // --------------------------------------------------------------
                // LIEU DE L’INCIDENT (ICÔNE + TEXTE)
                // --------------------------------------------------------------
                //
                // Row permet un alignement horizontal :
                //   [ICON] [ESPACE] [TEXTE]
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 16,
                      color: Colors.grey,
                    ),

                    const SizedBox(width: 4), // espace horizontal

                    // Lieu de l'incident
                    Text(
                      incident.lieu,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
