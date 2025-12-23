import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CommandeListScreen extends StatefulWidget {
  const CommandeListScreen({super.key});

  @override
  State<CommandeListScreen> createState() => _CommandeListScreenState();
}

class _CommandeListScreenState extends State<CommandeListScreen> {
  bool _isLoading = true;

  // Simulation de données
  final List<Map<String, dynamic>> _commandes = [];

  @override
  void initState() {
    super.initState();
    _loadCommandes();
  }

  Future<void> _loadCommandes() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _commandes.addAll([
        {
          "id": "CMD001",
          "date": "12/12/2025",
          "total": 25000,
          "status": "Livrée",
          "items": [
            {"titre": "Atomic Habits", "quantite": 1, "prix": 8500},
            {"titre": "Rich Dad Poor Dad", "quantite": 1, "prix": 6500},
          ],
          "adresse": "123 Rue Principale, Dakar",
          "modePaiement": "Wave",
        },
        {
          "id": "CMD002",
          "date": "14/12/2025",
          "total": 18000,
          "status": "En cours",
          "items": [
            {"titre": "Start With Why", "quantite": 2, "prix": 7000},
            {"titre": "Le pouvoir du moment présent", "quantite": 1, "prix": 9000},
          ],
          "adresse": "456 Avenue Liberté, Dakar",
          "modePaiement": "Orange Money",
        },
        {
          "id": "CMD003",
          "date": "16/12/2025",
          "total": 15500,
          "status": "Annulée",
          "items": [
            {"titre": "L'art de la guerre", "quantite": 1, "prix": 7500},
            {"titre": "Les 7 habitudes", "quantite": 1, "prix": 8000},
          ],
          "adresse": "789 Boulevard du Livre, Dakar",
          "modePaiement": "Carte bancaire",
        },
        {
          "id": "CMD004",
          "date": "18/12/2025",
          "total": 32500,
          "status": "Expédiée",
          "items": [
            {"titre": "Atomic Habits", "quantite": 2, "prix": 8500},
            {"titre": "Rich Dad Poor Dad", "quantite": 1, "prix": 6500},
            {"titre": "Start With Why", "quantite": 1, "prix": 7000},
          ],
          "adresse": "321 Avenue de la République, Dakar",
          "modePaiement": "Wave",
        },
      ]);
      _isLoading = false;
    });
  }

  Color _statusColor(String status) {
    switch (status) {
      case "Livrée":
        return Colors.green;
      case "Expédiée":
        return Colors.blue;
      case "En cours":
        return Colors.orange;
      case "Annulée":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _statusIcon(String status) {
    switch (status) {
      case "Livrée":
        return Icons.check_circle;
      case "Expédiée":
        return Icons.local_shipping;
      case "En cours":
        return Icons.hourglass_bottom;
      case "Annulée":
        return Icons.cancel;
      default:
        return Icons.shopping_bag;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mes commandes"),
        centerTitle: true,
        backgroundColor: const Color(0xFF226D68),
        elevation: 1,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              _showFilterDialog(context);
            },
            tooltip: 'Filtrer les commandes',
          ),
        ],
      ),

      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _commandes.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.shopping_bag_outlined,
              size: 80,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            const Text(
              "Aucune commande",
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Votre historique de commandes apparaîtra ici",
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                context.go('/home');
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Faire des achats'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF226D68),
              ),
            ),
          ],
        ),
      )
          : Column(
        children: [
          // Résumé des commandes
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey[50],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatCard(
                  title: 'Total',
                  value: '${_commandes.length}',
                  icon: Icons.receipt,
                  color: const Color(0xFF226D68),
                ),
                _buildStatCard(
                  title: 'En cours',
                  value: _commandes.where((c) => c["status"] == "En cours").length.toString(),
                  icon: Icons.hourglass_bottom,
                  color: Colors.orange,
                ),
                _buildStatCard(
                  title: 'Livrées',
                  value: _commandes.where((c) => c["status"] == "Livrée").length.toString(),
                  icon: Icons.check_circle,
                  color: Colors.green,
                ),
              ],
            ),
          ),

          // Liste des commandes
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _commandes.length,
              itemBuilder: (context, index) {
                final cmd = _commandes[index];
                final items = cmd["items"] as List;
                final itemCount = items.length;

                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                  margin: const EdgeInsets.only(bottom: 12),
                  child: InkWell(
                    onTap: () {
                      // REDIRECTION VERS LES DÉTAILS DE LA COMMANDE
                      context.go('/commande/${cmd["id"]}');
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Commande #${cmd["id"]}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Chip(
                                label: Text(
                                  cmd["status"],
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                                backgroundColor: _statusColor(cmd["status"]),
                                avatar: Icon(
                                  _statusIcon(cmd["status"]),
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Date : ${cmd["date"]}",
                            style: const TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "${itemCount} article${itemCount > 1 ? 's' : ''}",
                            style: const TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "${cmd["total"]} FCFA",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF226D68),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Paiement : ${cmd["modePaiement"]}",
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 8),
                          if (items.isNotEmpty)
                            SizedBox(
                              height: 60,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: items.length,
                                itemBuilder: (context, itemIndex) {
                                  final item = items[itemIndex];
                                  return Container(
                                    margin: const EdgeInsets.only(right: 8),
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.blue[50],
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          item["titre"],
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                        Text(
                                          "×${item["quantite"]}",
                                          style: const TextStyle(
                                            fontSize: 11,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: color.withOpacity(0.1),
          radius: 24,
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          title,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filtrer les commandes'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView(
            shrinkWrap: true,
            children: [
              _buildFilterOption(context, 'Toutes', null),
              _buildFilterOption(context, 'En cours', 'En cours'),
              _buildFilterOption(context, 'Livrées', 'Livrée'),
              _buildFilterOption(context, 'Expédiées', 'Expédiée'),
              _buildFilterOption(context, 'Annulées', 'Annulée'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterOption(BuildContext context, String label, String? status) {
    return ListTile(
      title: Text(label),
      leading: Icon(
        _statusIcon(status ?? ''),
        color: _statusColor(status ?? ''),
      ),
      onTap: () {
        Navigator.pop(context);
        // TODO: Implémenter le filtrage
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Filtre appliqué : $label'),
          ),
        );
      },
    );
  }
}