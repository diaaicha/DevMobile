import 'package:flutter/material.dart';
import '../widgets/champ_support_widget.dart';
import '../models/message_support.dart';

class SupportClientScreen extends StatefulWidget {
  const SupportClientScreen({super.key});

  @override
  State<SupportClientScreen> createState() => _SupportClientScreenState();
}

class _SupportClientScreenState extends State<SupportClientScreen> {
  final TextEditingController _sujetController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  Future<void> _envoyerMessage() async {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      setState(() => _isLoading = true);

      // Simuler l'envoi
      await Future.delayed(const Duration(seconds: 2));

      if (!mounted) return;
      setState(() => _isLoading = false);

      // Créer le message SANS catégorie
      final nouveauMessage = MessageSupport(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        sujet: _sujetController.text.trim(),
        message: _messageController.text.trim(),
        dateEnvoi: DateTime.now(),
        userId: 'user_123',
      );

      // Message de succès
      _showSuccessDialog(nouveauMessage);

      // Nettoyer les champs
      _sujetController.clear();
      _messageController.clear();
    }
  }

  void _showSuccessDialog(MessageSupport message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green),
            SizedBox(width: 12),
            Text("Message envoyé !"),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Votre message a été envoyé avec succès",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Référence: ${message.id}",
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Text("Sujet: ${message.sujet}"),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Notre équipe vous répondra dans les 24 heures.",
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _sujetController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Support Client",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        elevation: 3,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ----------- SECTION EN-TÊTE -----------
              _buildEnTete(),
              const SizedBox(height: 30),

              // ----------- FORMULAIRE -----------
              _buildFormulaire(),

              // ----------- BOUTON ENVOYER -----------
              _buildBoutonEnvoyer(),
              const SizedBox(height: 40),

              // ----------- CONTACT DIRECT -----------
              _buildContactDirect(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEnTete() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.blue.shade100),
          ),
          child: Row(
            children: [
              const Icon(Icons.support_agent, color: Colors.blueAccent, size: 32),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Service Client Librairie",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.blueAccent,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Une question sur votre commande ? Notre équipe est à votre écoute.",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Icon(Icons.access_time, color: Colors.green.shade600, size: 20),
            const SizedBox(width: 8),
            Text(
              "Réponse sous 24h maximum",
              style: TextStyle(
                color: Colors.green.shade700,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFormulaire() {
    return Column(
      children: [
        ChampSupportWidget(
          controller: _sujetController,
          label: "Sujet",
          hintText: "Ex: Commande #CMD-2025-001 non reçue",
          icon: Icons.subject,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Veuillez saisir un sujet";
            }
            if (value.length < 10) {
              return "Le sujet est trop court (min. 10 caractères)";
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        ChampSupportWidget(
          controller: _messageController,
          label: "Description détaillée",
          hintText: "Décrivez votre problème ou question en détail...",
          icon: Icons.description,
          maxLines: 6,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Veuillez saisir un message";
            }
            if (value.length < 30) {
              return "Le message doit contenir au moins 30 caractères";
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildBoutonEnvoyer() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton.icon(
        onPressed: _isLoading ? null : _envoyerMessage,
        icon: Icon(_isLoading ? Icons.hourglass_empty : Icons.send, size: 22),
        label: _isLoading
            ? const Text("Envoi en cours...")
            : const Text("Envoyer mon message", style: TextStyle(fontWeight: FontWeight.w600)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 3,
        ),
      ),
    );
  }

  Widget _buildContactDirect() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Contact direct",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.blueAccent,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Vous pouvez aussi nous contacter directement :",
          style: TextStyle(color: Colors.grey.shade600),
        ),
        const SizedBox(height: 20),
        _buildContactCard(
          icon: Icons.email_outlined,
          title: "Email",
          subtitle: "support@librairie.sn",
          actionText: "Copier",
          onAction: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Email copié")),
            );
          },
        ),
        const SizedBox(height: 12),
        _buildContactCard(
          icon: Icons.phone_outlined,
          title: "Téléphone",
          subtitle: "+221 33 800 00 00",
          actionText: "Appeler",
          onAction: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Ouverture de l'appel...")),
            );
          },
        ),
        const SizedBox(height: 12),
        _buildContactCard(
          icon: Icons.location_on_outlined,
          title: "Notre librairie",
          subtitle: "123 Avenue des Livres, Dakar",
          actionText: "Itinéraire",
          onAction: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Ouverture de Google Maps...")),
            );
          },
        ),
      ],
    );
  }

  Widget _buildContactCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required String actionText,
    required VoidCallback onAction,
  }) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.blueAccent),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle),
        trailing: OutlinedButton(
          onPressed: onAction,
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.blueAccent,
            side: const BorderSide(color: Colors.blueAccent),
          ),
          child: Text(actionText),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }
}