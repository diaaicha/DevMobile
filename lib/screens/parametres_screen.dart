import 'package:flutter/material.dart';

class ParametresScreen extends StatefulWidget {
  const ParametresScreen({super.key});

  @override
  State<ParametresScreen> createState() => _ParametresScreenState();
}

class _ParametresScreenState extends State<ParametresScreen> {
  // États des paramètres
  bool _notifications = true;
  bool _modeSombre = false;
  String _langue = "Français";

  // Données utilisateur (en attendant un vrai Provider)
  String _nom = "Yarame Diakhaté";
  String _email = "yarame@example.com";
  String _telephone = "77 000 00 00";

  // Groupes de paramètres pour une meilleure organisation
  final List<Map<String, dynamic>> _parametresCompte = [
    {"titre": "Nom", "valeur": "nom", "icon": Icons.person},
    {"titre": "Email", "valeur": "email", "icon": Icons.email},
    {"titre": "Téléphone", "valeur": "telephone", "icon": Icons.phone},
  ];

  final List<Map<String, dynamic>> _parametresApplication = [
    {"titre": "Notifications", "type": "switch", "icon": Icons.notifications},
    {"titre": "Mode sombre", "type": "switch", "icon": Icons.dark_mode},
    {"titre": "Langue", "type": "select", "icon": Icons.language},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Paramètres"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 2,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Section : Informations personnelles
          _buildSection(
            title: "Compte",
            icon: Icons.account_circle,
            children: [
              ..._parametresCompte.map((info) => _buildInfoTile(info)),
              const SizedBox(height: 8),
              // Bouton modifier le profil
              OutlinedButton.icon(
                onPressed: () => _navigateToEditProfile(),
                icon: const Icon(Icons.edit, size: 18),
                label: const Text("Modifier le profil complet"),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.blueAccent,
                  side: BorderSide(color: Colors.blueAccent.withOpacity(0.3)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Section : Préférences
          _buildSection(
            title: "Préférences",
            icon: Icons.settings,
            children: [
              // Notifications
              SwitchListTile(
                title: const Text("Notifications"),
                subtitle: const Text("Recevoir des alertes et rappels"),
                secondary: Icon(
                  Icons.notifications_active,
                  color: _notifications ? Colors.blueAccent : Colors.grey,
                ),
                value: _notifications,
                onChanged: (value) => _toggleNotifications(value),
                activeColor: Colors.blueAccent,
                contentPadding: const EdgeInsets.symmetric(horizontal: 4),
              ),
              const Divider(height: 1, indent: 60),

              // Mode sombre
              SwitchListTile(
                title: const Text("Mode sombre"),
                subtitle: const Text("Activer le thème sombre"),
                secondary: Icon(
                  _modeSombre ? Icons.dark_mode : Icons.light_mode,
                  color: _modeSombre ? Colors.deepPurple : Colors.amber,
                ),
                value: _modeSombre,
                onChanged: (value) => _toggleModeSombre(value),
                activeColor: Colors.deepPurple,
                contentPadding: const EdgeInsets.symmetric(horizontal: 4),
              ),
              const Divider(height: 1, indent: 60),

              // Langue
              ListTile(
                leading: const Icon(Icons.language, color: Colors.blueAccent),
                title: const Text("Langue"),
                subtitle: Text(_langue),
                trailing: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    _langue.substring(0, 2).toUpperCase(),
                    style: const TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                onTap: () => _choisirLangue(context),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Section : Support
          _buildSection(
            title: "Support",
            icon: Icons.help_outline,
            children: [
              ListTile(
                leading: const Icon(Icons.help, color: Colors.blueAccent),
                title: const Text("Centre d'aide"),
                trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                onTap: () => _showSnackBar("Centre d'aide"),
              ),
              const Divider(height: 1, indent: 60),
              ListTile(
                leading: const Icon(Icons.description, color: Colors.blueAccent),
                title: const Text("Conditions d'utilisation"),
                trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                onTap: () => _showSnackBar("Conditions d'utilisation"),
              ),
              const Divider(height: 1, indent: 60),
              ListTile(
                leading: const Icon(Icons.shield, color: Colors.blueAccent),
                title: const Text("Politique de confidentialité"),
                trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                onTap: () => _showSnackBar("Politique de confidentialité"),
              ),
            ],
          ),
          const SizedBox(height: 32),

          // Bouton déconnexion
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton.icon(
              onPressed: () => _confirmerDeconnexion(context),
              icon: const Icon(Icons.logout, size: 20),
              label: const Text("Déconnexion"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade50,
                foregroundColor: Colors.red,
                elevation: 0,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Colors.red.shade200),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Version de l'app
          Center(
            child: Text(
              "Version 1.0.0",
              style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Méthode pour construire une section
  Widget _buildSection({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // En-tête de section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Icon(icon, color: Colors.blueAccent, size: 20),
                  const SizedBox(width: 12),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.blueAccent,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 20),
            ...children,
          ],
        ),
      ),
    );
  }

  // Méthode pour construire un élément d'information
  Widget _buildInfoTile(Map<String, dynamic> info) {
    String valeur;
    switch (info["valeur"]) {
      case "nom": valeur = _nom;
      case "email": valeur = _email;
      case "telephone": valeur = _telephone;
      default: valeur = "";
    }

    return ListTile(
      leading: Icon(info["icon"] as IconData, color: Colors.blueAccent),
      title: Text(
        info["titre"] as String,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        valeur,
        style: TextStyle(color: Colors.grey.shade600),
      ),
      trailing: const Icon(Icons.edit, color: Colors.blueAccent, size: 20),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      onTap: () => _editerInfo(info["titre"] as String, valeur),
    );
  }

  // Méthodes d'édition
  void _editerInfo(String titre, String valeur) {
    final Map<String, Function(String)> actions = {
      "Nom": (value) => setState(() => _nom = value),
      "Email": (value) => setState(() => _email = value),
      "Téléphone": (value) => setState(() => _telephone = value),
    };

    if (actions.containsKey(titre)) {
      _montrerDialogEdition(titre, valeur, actions[titre]!);
    }
  }

  void _montrerDialogEdition(String titre, String valeurInitiale, Function(String) onSave) {
    final controller = TextEditingController(text: valeurInitiale);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Modifier $titre"),
        content: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: "Entrez votre $titre",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Annuler"),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                onSave(controller.text.trim());
                Navigator.pop(context);
                _showSnackBar("$titre mis à jour");
              }
            },
            child: const Text("Enregistrer"),
          ),
        ],
      ),
    );
  }

  // Méthodes de basculement
  void _toggleNotifications(bool value) {
    setState(() => _notifications = value);
    _showSnackBar(
      value ? "Notifications activées" : "Notifications désactivées",
    );
  }

  void _toggleModeSombre(bool value) {
    setState(() => _modeSombre = value);
    // Ici tu pourrais ajouter la logique pour changer le thème
    _showSnackBar(
      value ? "Mode sombre activé" : "Mode clair activé",
    );
  }

  // Sélection de langue
  void _choisirLangue(BuildContext context) {
    final languages = ["Français", "English", "Español", "العربية"];

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Choisir la langue",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...languages.map((langue) => RadioListTile(
              title: Text(langue),
              value: langue,
              groupValue: _langue,
              onChanged: (value) {
                if (value != null) {
                  setState(() => _langue = value);
                  Navigator.pop(context);
                  _showSnackBar("Langue changée en $value");
                }
              },
            )).toList(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Navigation vers l'écran d'édition complet
  void _navigateToEditProfile() {
    _showSnackBar("Redirection vers l'édition du profil");
    // Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfilScreen()));
  }

  // Confirmation de déconnexion
  void _confirmerDeconnexion(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Déconnexion"),
        content: const Text("Voulez-vous vraiment vous déconnecter ?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Annuler"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showSnackBar("Déconnexion réussie");
              // Ici : Logique de déconnexion réelle
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text("Déconnexion"),
          ),
        ],
      ),
    );
  }

  // Méthode utilitaire pour les feedbacks
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}