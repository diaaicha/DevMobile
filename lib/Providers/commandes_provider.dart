import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../models/commande_model.dart';

final commandesProvider = StateProvider<List<Commande>>((ref) {
  return [
    Commande(
      id: '1',
      numero: 'CMD-2024-001',
      date: DateTime(2024, 3, 15),
      montant: 8500,
      statut: 'Livrée',
      items: [
        CommandeItem(
          livreId: '1',
          titre: 'Atomic Habits',
          quantite: 1,
          prixUnitaire: 8500,
          image: 'assets/images/book1.jpg',
        ),
      ],
    ),
    Commande(
      id: '2',
      numero: 'CMD-2024-002',
      date: DateTime(2024, 3, 10),
      montant: 15500,
      statut: 'Expédiée',
      items: [
        CommandeItem(
          livreId: '2',
          titre: 'Rich Dad Poor Dad',
          quantite: 1,
          prixUnitaire: 6500,
          image: 'assets/images/book2.jpg',
        ),
        CommandeItem(
          livreId: '3',
          titre: 'Start With Why',
          quantite: 1,
          prixUnitaire: 7000,
          image: 'assets/images/book3.jpg',
        ),
      ],
    ),
    Commande(
      id: '3',
      numero: 'CMD-2024-003',
      date: DateTime(2024, 3, 5),
      montant: 9000,
      statut: 'Confirmée',
      items: [
        CommandeItem(
          livreId: '4',
          titre: 'Le pouvoir du moment présent',
          quantite: 1,
          prixUnitaire: 9000,
          image: 'assets/images/book4.jpg',
        ),
      ],
    ),
  ];
});

// Provider pour récupérer une commande par son ID
final commandeByIdProvider = Provider.family<Commande?, String>((ref, id) {
  final commandes = ref.watch(commandesProvider);
  try {
    return commandes.firstWhere((commande) => commande.id == id);
  } catch (e) {
    return null;
  }
});