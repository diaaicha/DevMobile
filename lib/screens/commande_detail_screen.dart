import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CommandeDetailScreen extends StatelessWidget {
  final String commandeId;

   CommandeDetailScreen({super.key, required this.commandeId});


  final Map<String, Map<String, dynamic>> commandeData = {
    "CMD001": {
      "id": "CMD001",
      "date": "12/12/2025",
      "total": 25000,
      "status": "Livrée",
      "items": [
        {"titre": "Atomic Habits", "quantite": 1, "prix": 8500, "image": "assets/images/book1.jpg"},
        {"titre": "Rich Dad Poor Dad", "quantite": 1, "prix": 6500, "image": "assets/images/book2.jpg"},
      ],
      "adresse": "123 Rue Principale, Dakar",
      "modePaiement": "Wave",
      "fraisLivraison": 1000,
      "reduction": 0,
    },
    "CMD002": {
      "id": "CMD002",
      "date": "14/12/2025",
      "total": 18000,
      "status": "En cours",
      "items": [
        {"titre": "Start With Why", "quantite": 2, "prix": 7000, "image": "assets/images/book3.jpg"},
        {"titre": "Le pouvoir du moment présent", "quantite": 1, "prix": 9000, "image": "assets/images/book4.jpg"},
      ],
      "adresse": "456 Avenue Liberté, Dakar",
      "modePaiement": "Orange Money",
      "fraisLivraison": 1000,
      "reduction": 0,
    },
    "CMD003": {
      "id": "CMD003",
      "date": "16/12/2025",
      "total": 15500,
      "status": "Annulée",
      "items": [
        {"titre": "L'art de la guerre", "quantite": 1, "prix": 7500, "image": "assets/images/book5.jpg"},
        {"titre": "Les 7 habitudes", "quantite": 1, "prix": 8000, "image": "assets/images/book6.jpg"},
      ],
      "adresse": "789 Boulevard du Livre, Dakar",
      "modePaiement": "Carte bancaire",
      "fraisLivraison": 1000,
      "reduction": 0,
    },
  };

  @override
  Widget build(BuildContext context) {
    final cmd = commandeData[commandeId];

    if (cmd == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Commande non trouvée'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.go('/commandes'),
            tooltip: 'Retour à l’accueil',
          ),
        ),
        body: const Center(child: Text('Commande non trouvée')),
      );
    }

    // Extraction des données avec des types sûrs
    final String id = cmd["id"] as String;
    final String date = cmd["date"] as String;
    final String status = cmd["status"] as String;
    final String adresse = cmd["adresse"] as String;
    final String modePaiement = cmd["modePaiement"] as String;
    final int fraisLivraison = cmd["fraisLivraison"] as int;
    final int reduction = cmd["reduction"] as int;
    final List<Map<String, dynamic>> items = (cmd["items"] as List).cast<Map<String, dynamic>>();

    // Calcul des totaux avec des types sûrs
    final int totalArticles = items.fold<int>(0, (sum, item) {
      final int prix = item["prix"] as int;
      final int quantite = item["quantite"] as int;
      return sum + (prix * quantite);
    });

    final int totalCommande = totalArticles + fraisLivraison - reduction;

    return Scaffold(
      appBar: AppBar(
        title: Text('Commande #$id'),
        backgroundColor: const Color(0xFF226D68),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/commandes'),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Statut de la commande
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text(
                      'Statut de la commande',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Chip(
                      label: Text(
                        status,
                        style: const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      backgroundColor: _getStatusColor(status),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Date : $date',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Articles
            const Text(
              'Articles',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            ...items.map<Widget>((item) {
              final String titre = item["titre"] as String;
              final int prix = item["prix"] as int;
              final int quantite = item["quantite"] as int;
              final int sousTotal = prix * quantite;

              return Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey[200],
                    child: const Icon(Icons.book, color: Colors.grey),
                  ),
                  title: Text(titre),
                  subtitle: Text('$prix FCFA × $quantite'),
                  trailing: Text(
                    '$sousTotal FCFA',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              );
            }).toList(),

            const SizedBox(height: 20),

            // Récapitulatif
            const Text(
              'Récapitulatif',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildPriceRow('Sous-total', totalArticles),
                    _buildPriceRow('Frais de livraison', fraisLivraison),
                    _buildPriceRow('Réduction', -reduction),
                    const Divider(),
                    _buildPriceRow(
                      'Total',
                      totalCommande,
                      isTotal: true,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Informations
            const Text(
              'Informations',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow(Icons.location_on, 'Adresse', adresse),
                    const SizedBox(height: 12),
                    _buildInfoRow(Icons.payment, 'Paiement', modePaiement),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),


            if (status == 'En cours')
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        _showAnnulationDialog(context, id);
                      },
                      icon: const Icon(Icons.cancel, color: Colors.red),
                      label: const Text(
                        'Annuler la commande',
                        style: TextStyle(color: Colors.red),
                      ),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: const BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        context.go('/support');
                      },
                      icon: const Icon(Icons.support_agent),
                      label: const Text('Contacter le support'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF226D68),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Livrée": return Colors.green;
      case "Expédiée": return Colors.blue;
      case "En cours": return Colors.orange;
      case "Annulée": return Colors.red;
      default: return Colors.grey;
    }
  }

  Widget _buildPriceRow(String label, int montant, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? 16 : 14,
            ),
          ),
          Text(
            '$montant FCFA',
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? 18 : 16,
              color: isTotal ? const Color(0xFF226D68) : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: const Color(0xFF226D68)),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showAnnulationDialog(BuildContext context, String commandeId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Annuler la commande'),
        content: const Text('Êtes-vous sûr de vouloir annuler cette commande ? Cette action est irréversible.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Non'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Commande #$commandeId annulée'),
                  backgroundColor: Colors.red,
                ),
              );

              context.go('/commande_list');
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Oui, annuler'),
          ),
        ],
      ),
    );
  }
}