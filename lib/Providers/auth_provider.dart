// ============================================================================
// FICHIER : lib/providers/auth_provider.dart
// ============================================================================
//
// Ce fichier définit un provider Riverpod chargé de stocker l’état
// d’authentification de l’utilisateur.
//
// Il constitue la base d’un système d’authentification réactif :
//   - si l’utilisateur se connecte  → authStateProvider passe à true,
//   - si l’utilisateur se déconnecte → authStateProvider redevient false,
//   - les écrans qui écoutent ce provider seront automatiquement mis à jour.
//
// C’est un exemple parfait pour expliquer Riverpod, la gestion de l’état,
// et les principes d’architecture réactive dans Flutter.
//
// ============================================================================

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

/// ---------------------------------------------------------------------------
/// 1. StateProvider<bool>
/// ---------------------------------------------------------------------------
///
/// Un **StateProvider** est le provider le plus simple dans Riverpod.
/// Il est parfaitement adapté pour gérer des données simples et modifiables :
////   - booléen  (connecté / déconnecté),
////   - nombre   (compteur),
////   - chaîne   (texte temporaire),
////   - petit état UI.
///
/// Pourquoi utiliser StateProvider ici ?
///   - l’état d’authentification est très simple (true / false),
///   - cet état doit être observable par plusieurs widgets,
///   - Riverpod assure une mise à jour automatique de l’UI lorsque la valeur change.
///
/// Syntaxe générale :
///    final provider = StateProvider<Type>((ref) => valeurInitiale);
///
/// Ici, Type = bool (utilisateur connecté ou non).
///
final authStateProvider = StateProvider<bool>((ref) {
  // Valeur initiale de l'état.
  //
  // Au démarrage de l'application :
  //   - on considère l’utilisateur COMME NON CONNECTÉ.
  //   - la valeur est donc `false`.
  //
  // Dans un vrai projet :
  //   - cette valeur pourrait venir d’un cache (SharedPreferences),
  //   - d’un token stocké,
  //   - ou d’un backend.
  return false;
});

