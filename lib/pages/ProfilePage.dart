import 'package:flutter/material.dart';


class ProfilePage extends StatelessWidget {
  final String playerId;

  ProfilePage({required this.playerId});

  @override
  Widget build(BuildContext context) {
    // Utilise playerId pour récupérer les informations du joueur depuis Firestore
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil du Joueur"),
      ),
      body: Center(
        child: Text("Affichage des informations pour le joueur : $playerId"),
      ),
    );
  }
}
