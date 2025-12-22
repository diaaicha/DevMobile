class Incident {
  // --- PROPRIÉTÉS ---
  // Chaque signalement AURA ces informations.
  // On utilise 'final' car une fois qu'un signalement est créé, ses informations de base ne changeront pas.
  /// Le titre du signalement (ex: "Nid de poule dangereux").
  final String titre;
  /// Une description plus détaillée du problème.
  final String description;
  /// L'URL de l'image qui illustre le signalement.
  /// Pour l'instant, ce sera une URL de placeholder.
  final String imageUrl;
  /// La date à laquelle le signalement a été créé.
  final DateTime date;
  /// Le lieu où le signalement a été fait (ex: "Yoff, près de la boulangerie").
  final String lieu;
  // --- CONSTRUCTEUR ---
  // Le constructeur est la "porte d'entrée" pour créer un nouvel objet Incident.
  // Il nous oblige à fournir toutes les informations nécessaires.
  Incident({
    required this.titre,
    required this.description,
    required this.imageUrl,
    required this.date,
    required this.lieu,
  });
}
