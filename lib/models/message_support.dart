class MessageSupport {
  final String id;
  final String sujet;
  final String message;
  final DateTime dateEnvoi;
  final String? userId;
  final bool estLu;

  const MessageSupport({
    required this.id,
    required this.sujet,
    required this.message,
    required this.dateEnvoi,
    this.userId,
    this.estLu = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sujet': sujet,
      'message': message,
      'dateEnvoi': dateEnvoi.toIso8601String(),
      'userId': userId,
      'estLu': estLu,
    };
  }
}