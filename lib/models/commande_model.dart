class Commande {
  final String id;
  final String numero;
  final DateTime date;
  final double montant;
  final String statut; 
  final List<CommandeItem> items;

  Commande({
    required this.id,
    required this.numero,
    required this.date,
    required this.montant,
    required this.statut,
    required this.items,
  });
}

class CommandeItem {
  final String livreId;
  final String titre;
  final int quantite;
  final double prixUnitaire;
  final String image;

  CommandeItem({
    required this.livreId,
    required this.titre,
    required this.quantite,
    required this.prixUnitaire,
    required this.image,
  });

  double get total => quantite * prixUnitaire;
}