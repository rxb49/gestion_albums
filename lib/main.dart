import 'package:flutter/material.dart';
//import 'package:gestion_albums/Customicons.dart';
import 'package:gestion_albums/themeController.dart';
import 'Appbar/appbar.dart';
import 'package:json_theme/json_theme.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:gestion_albums/Album.dart';
import 'carousel.dart'; // Importation du fichier carousel.dart
import 'package:carousel_slider/carousel_slider.dart';




Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final themeStr = await rootBundle.loadString('assets/ThemeAlbum.json');
  final lightThemeStr = await rootBundle.loadString('assets/theme_gestionAlbum_light.json');
  final darkThemeStr = await rootBundle.loadString('assets/theme_gestionAlbum_dark.json');

  final themeJson = jsonDecode(themeStr);
  final lightThemeJson = jsonDecode(lightThemeStr);
  final darkThemeJson = jsonDecode(darkThemeStr);

  final theme = ThemeDecoder.decodeThemeData(themeJson)!;
  final lightTheme = ThemeDecoder.decodeThemeData(lightThemeJson)!;
  final darkTheme = ThemeDecoder.decodeThemeData(darkThemeJson)!;

  runApp(MyApp(theme: theme, lightTheme: lightTheme, darkTheme: darkTheme));
}

class MyApp extends StatelessWidget {
  final ThemeData theme;
  final ThemeData lightTheme;
  final ThemeData darkTheme;

  const MyApp({super.key, required this.theme, required this.lightTheme, required this.darkTheme});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: themeController,
        builder: (context, themeMode, _) {
          return MaterialApp(
            title: 'Gestion des albums',
            debugShowMaterialGrid: false,
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: themeMode,
            home: const MyHomePage(),
          );
        });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPageIndex = 0;

  void _incrementCounter() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBar_Principal(
        title: 'Gestion des albums',
      ),
      body: currentPageIndex == 0
          ? _buildAccueil()
          : currentPageIndex == 1
              ? _buildAlbums()
          : currentPageIndex == 2
              ? _buildParametres()
              : null,
      floatingActionButton: currentPageIndex == 0
          ? FloatingActionButton(
              onPressed: _incrementCounter,
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          NavigationDestination(
            icon: Icon(Icons.music_note_sharp),
            label: 'Liste des albums',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'Paramètres',
          ),
        ],
      ),
    );
  }

 Widget _buildAccueil() {
  final List<String> carouselImages = [
    "assets/img/Ridethelightning.jpg",
    "assets/img/Masterofpuppets.jpg",
    "assets/img/hardwired.jpg",
    "assets/img/Andjusticeforall.jpg",
  ];

  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Card(
            shadowColor: Colors.black,
            color: Color.fromARGB(255, 121, 190, 141),
            child: SizedBox(
              width: double.infinity,
              height: 200,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Image(
                      image: AssetImage("img/imgAccueil/vinyltransp.webp"),
                      width: 100,
                      height: 100,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Bienvenue sur l'application de gestion d'album",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Voici les nouveaux albums ajoutés",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 8),
              CarouselSlider(
                items: carouselImages.map((imagePath) {
                  return Container(
                    margin: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        image: AssetImage(imagePath),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }).toList(),
                options: CarouselOptions(
                  height: 180,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: true,
                  viewportFraction: 1.0,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCard('News', 'Dernières actualités'),
              const SizedBox(height: 8),
              _buildCard('Version 1 en cours de développement', 'Wait and see'),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildAlbums() {
  final List<Map<String, String>> albumsData = [
  {
    "nomAlbum": "Metallica",
    "description": "L'album marque une évolution importante dans le style du groupe...",
    "nomGroupe": "Metallica",
    "image": "Metallica.jpg"
  },
  {
    "nomAlbum": "And justice for all",
    "description": "Un album iconique avec des riffs complexes et des paroles engagées.",
    "nomGroupe": "Metallica",
    "image": "Andjusticeforall.jpg"
  },
  {
    "nomAlbum": "Hardwired",
    "description": "Un retour aux racines du heavy metal avec des morceaux énergiques.",
    "nomGroupe": "Metallica",
    "image": "Hardwired.jpg"
  },
  {
    "nomAlbum": "Kill'em all",
    "description": "L'album qui a lancé Metallica sur la scène du thrash metal.",
    "nomGroupe": "Metallica",
    "image": "Killemall.jpg"
  },
  {
    "nomAlbum": "Master of puppets",
    "description": "Considéré comme l’un des meilleurs albums de heavy metal de tous les temps.",
    "nomGroupe": "Metallica",
    "image": "Masterofpuppets.jpg"
  },
  {
    "nomAlbum": "Ride the lightning",
    "description": "Un mélange parfait entre rapidité, technique et puissance.",
    "nomGroupe": "Metallica",
    "image": "Ridethelightning.jpg"
  }
];
  return Container(
    color: Colors.blue,
    alignment: Alignment.center,
    child: ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 10.0),
      children: albumsData.map((album) {
        return Album(
          nomAlbum: album["nomAlbum"],
          description: album["description"],
          nomGroupe: album["nomGroupe"],
          image: album["image"],
        );
      }).toList(),
    ),
  );
}


  Widget _buildParametres() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Configurer les paramètres de l'application",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Card(
            child: ListTile(
              title: const Text("Paramètre 1"),
              subtitle: const Text("Work in progress"),
              leading: const Icon(Icons.settings),
              onTap: () {
              },
            ),
          ),
          const SizedBox(height: 8),
          Card(
            child: ListTile(
              title: const Text("Paramètre 2"),
              subtitle: const Text("Work in progress"),
              leading: const Icon(Icons.tune),
              onTap: () {
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(String title, String subtitle) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}