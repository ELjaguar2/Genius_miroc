import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_application_1/pages/classement.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double playerProgress; // La progression du joueur (de 0 à 1)

  CustomAppBar({required this.playerProgress});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      elevation: 0,
      title: Padding(
        padding: const EdgeInsets.only(bottom: 3),
        child: Row(
            children: [
              // Avatar avec barre de progression circulaire
              Stack(
                alignment: Alignment.center,
                children: [
                  // Conteneur pour l'ombre
                  Container(
                    width: 52, // Ajuste pour laisser l'ombre autour
                    height: 52,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          spreadRadius: 1,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Barre de progression ajustée pour toucher l'avatar
                        SizedBox(
                          width: 48,
                          height: 48,
                          child: CircularProgressIndicator(
                            value: playerProgress,
                            strokeWidth: 4,
                            color: Color(0xFF108236), // Vert pour la progression
                            backgroundColor: Colors.white, // Fond blanc pour la partie non complétée
                          ),
                        ),
                        // Avatar au centre
                        const CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage('assets/img/person.png'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
          
              SizedBox(width: 10),
          
              // Points et Statut
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // Icône de pièce
                      Image.asset(
                        'assets/img/coins.png',
                        width: 27,
                        height: 27,
                      ),
                      const SizedBox(width: 4),
                      // Texte des points
                      const Text(
                        '452',
                        style: TextStyle(
                          color: Color(0xFF364F6B),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2),
                  // Statut Champion avec le rang
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xFF7584FF), // Couleur violet bleu pour le bord
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 9, vertical: 2),
                          decoration: BoxDecoration(
                            color: Color(0xFF7584FF), // Couleur violet bleu pour le fond
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Text(
                            'Champion  ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          ' #64  ',
                          style: TextStyle(
                            color: Color(0xFF7584FF), // Violet bleu pour le texte "#64"
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
          
                ],
              ),
              Spacer(),
          
              // Bouton Boutique
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFFFE3BA), // Jaune clair
                      Color.fromARGB(255, 241, 191, 99), // Jaune plus foncé
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Icône de caddie
                        SvgPicture.asset(
                          'assets/img/shop.svg',
                          width: 24,
                          height: 24,
                        ),
                        SizedBox(width: 15), // Espacement de 5 entre l'icône et le texte
                        // Texte "Boutique"
                        const Text(
                          'Boutique',
                          style: TextStyle(
                            color: Color(0xFF364F6B),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    // Indicateur de notification
                    Positioned(
                      right: -17,
                      top: -12,
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: const Text(
                          '1',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          
            ],
          ),
      ),
    );
  }
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;

  void setCurrentIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: CustomAppBar(playerProgress: 0.5),
        body: [
          ClassementPage(),
          Tournois(),
          Accueil(),
          Matchs(),
          Pronos(),
        ][_currentIndex],
        bottomNavigationBar: CustomNavBar(
          currentIndex: _currentIndex,
          onTap: setCurrentIndex,
        ),
      ),
    );
  }
}
// fausses pages pour navBar --------------------------------------------------------------------------------------------------
class Tournois extends StatelessWidget {
  const Tournois({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class Accueil extends StatelessWidget {
  const Accueil({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class Matchs extends StatelessWidget {
  const Matchs({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class Pronos extends StatelessWidget {
  const Pronos({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
// ------------------------------------------------------------------------------------------------------------------
class CustomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomNavBar({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: const Color(0xFF7584FF),
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            currentIndex == 0 
              ? 'assets/img/podium_primary.svg' 
              : 'assets/img/podium.svg',
          ),
          label: 'Classement',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            currentIndex == 1 
              ? 'assets/img/trophy_primary.svg' 
              : 'assets/img/trophy.svg',
          ),
          label: 'Tournois',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            currentIndex == 2 
              ? 'assets/img/stadium_primary.svg' 
              : 'assets/img/stadium.svg',
          ),
          label: 'Accueil',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            currentIndex == 3 
              ? 'assets/img/field_primary.svg' 
              : 'assets/img/field.svg',
          ),
          label: 'Matchs',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            currentIndex == 4 
              ? 'assets/img/ticket_primary.svg' 
              : 'assets/img/ticket.svg',
          ),
          label: 'Mes Pronos',
        ),
      ],
    );
  }
}
