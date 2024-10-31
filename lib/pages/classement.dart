import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_core/firebase_core.dart';
import 'ProfilePage.dart';


class ClassementPage extends StatefulWidget {
  const ClassementPage({super.key});

  @override
  State<ClassementPage> createState() => _ClassementPageState();
}


class _ClassementPageState extends State<ClassementPage> {

  @override
  Widget build(BuildContext context) {
    String currentPlayerId = '3' ; 

    return Scaffold(
      backgroundColor: Color(0xFFECF1FF),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0, bottom: 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            const Text(
              'CLASSEMENT \nAMIS',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF364F6B),
                height: 1,
              ),
            ),
            SizedBox(height: 8),
            Container(
              margin: const EdgeInsets.only(left: 7.5, right: 4.0),
              child: const Text(
                'Compare ton classement avec tes amis et \nregarde lequel est le meilleur d’entre vous',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF6D8097),
                ),
              ),
            ),
            SizedBox(height: 16),
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection("amis").snapshots(), 
              builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
                if (snapshot.connectionState == ConnectionState.waiting){
                  return CircularProgressIndicator();
                }
                if(!snapshot.hasData){
                  return Text("Aucun classement a afficher");
                }

                List<dynamic> players = [];
                snapshot.data!.docs.forEach((element){
                  players.add(element);
                });


                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: players.length,
                  itemBuilder: (context, index) {
                    final player = players[index];
                    bool isCurrentPlayer = player['id'].toString() == currentPlayerId;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        elevation: 4, // Ombre ajoutée à la carte
                        child: Container(
                          decoration: BoxDecoration(
                            color: isCurrentPlayer ? Color(0xFF7584FF) : Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.white,
                              width: 3, 
                            )
                          ),
                          child: ListTile(
                            onTap: () {
                              // Naviguer vers la page de profil avec l'ID du joueur
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProfilePage(playerId: player.id),
                                ),
                              );
                            },
                            contentPadding: EdgeInsets.symmetric(horizontal: 5), // Ajoutez un padding horizontal
                            title: Row(
                              children: [
                                // Affichage de l'index + 1
                                Text(
                                  '  ' + '${index + 1} ',
                                  style: TextStyle(
                                    color: isCurrentPlayer ? Colors.white : Color(0xFF7584FF),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                // Affichage du séparateur
                                Text(
                                  ' / ',
                                  style: TextStyle(
                                    color: isCurrentPlayer ? Colors.white : Color(0xFF7584FF), // Changement de couleur basé sur le joueur
                                  ),
                                ),
                                // Affichage de l'avatar
                                // Affichage de l'avatar
                                Container(
                                  margin: const EdgeInsets.only(left: 5.0, right: 4.0), // Espacement de 5 avant l'avatar
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white, // Couleur du bord
                                      width: 2, // Épaisseur du bord
                                    ),
                                    boxShadow: [
                                      const BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 4,
                                        spreadRadius: 1,
                                      ),
                                    ],
                                  ),
                                  child: CircleAvatar(
                                    radius: 18, // Réduit le rayon pour donner de l'espace pour le bord
                                    backgroundImage: AssetImage('assets/img/${player['avatar']}'),
                                    backgroundColor: Color(0xFF7584FF),
                                  ),
                                ),
                                // Affichage du nom du joueur
                                Text(
                                  player['name'],
                                  style: TextStyle(
                                    color: isCurrentPlayer ? Colors.white : const Color(0xFF35406A),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Affichage du montant
                                Text(
                                  player['score'].toString(),
                                  style: TextStyle(
                                    color: isCurrentPlayer ? Colors.white : Colors.black,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 5), // Espacement de 5 entre le montant et l'icône
                                // Affichage de l'icône de la pièce
                                Image.asset(
                                  'assets/img/coins.png',
                                  width: 20,
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
              ),
          ],
        ),
      ),
    );
  }
}
