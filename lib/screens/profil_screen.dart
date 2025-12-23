import 'package:flutter/material.dart';
import 'edit_profil_screen.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({super.key});

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {

  final Map<String, String> _informationsPersonnelles = {
    "Nom": "Diakhaté",
    "Prénom": "Yarame",
    "Email": "yarame@example.com",
    "Téléphone": "+221 77 000 00 00",
    "Adresse": "Saint-Louis, Sénégal",
  };

  final Map<String, String> _informationsConnexion = {
    "Rôle": "Administratrice",
    "Statut": "Actif",
    "Dernière connexion": "10 décembre 2025, 18h00",
  };

  final Map<String, String> _informationsProjet = {
    "Projet": "Gestion de Bibliothèque",
    "Équipe": "ING2_IPSL",
    "Année": "2025",
    "Version": "1.0.0",
  };

  void _ouvrirEdition(String champ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditP(
          titre: champ,
          valeurInitiale: _informationsPersonnelles[champ]!,
          onSave: (nouvelleValeur) {
            setState(() {
              _informationsPersonnelles[champ] = nouvelleValeur;
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mon Profil"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        elevation: 3,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildEnTeteProfil(),
            const SizedBox(height: 20),

            _buildSectionCard(
              titre: "Informations personnelles",
              icon: Icons.person_outline,
              donnees: _informationsPersonnelles,
              editable: true,
            ),
            const SizedBox(height: 20),

            _buildSectionCard(
              titre: "Informations de connexion",
              icon: Icons.security_outlined,
              donnees: _informationsConnexion,
              badge: _buildBadge("Actif", Colors.green),
            ),
            const SizedBox(height: 20),

            _buildSectionCard(
              titre: "À propos du projet",
              icon: Icons.code_outlined,
              donnees: _informationsProjet,
              isProjetInfo: true,
            ),
          ],
        ),
      ),
    );
  }

  // ================= EN-TÊTE =================

  Widget _buildEnTeteProfil() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CircleAvatar(
              radius: 48,
              backgroundColor: Colors.blue.shade100,
              child: const Icon(Icons.person, size: 48, color: Colors.blueAccent),
            ),
            const SizedBox(height: 12),
            const Text(
              "Yarame Diakhaté",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.blueAccent.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                "Administratrice",
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= SECTION CARD =================

  Widget _buildSectionCard({
    required String titre,
    required IconData icon,
    required Map<String, String> donnees,
    bool editable = false,
    bool isProjetInfo = false,
    Widget? badge,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.blueAccent),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    titre,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
                if (badge != null) badge,
              ],
            ),
            const SizedBox(height: 16),

            ...donnees.entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: InkWell(
                  onTap: editable ? () => _ouvrirEdition(entry.key) : null,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          entry.key,
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          entry.value,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: isProjetInfo
                                ? Colors.deepPurple
                                : Colors.grey.shade800,
                            fontWeight: isProjetInfo
                                ? FontWeight.w500
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                      if (editable)
                        const Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Icon(Icons.edit, size: 18, color: Colors.grey),
                        ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  // ================= BADGE =================

  Widget _buildBadge(String texte, Color couleur) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: couleur.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: couleur.withOpacity(0.3)),
      ),
      child: Text(
        texte,
        style: TextStyle(
          color: couleur,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
