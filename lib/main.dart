import 'package:flutter/material.dart';
//import 'package:gestion_albums/Customicons.dart';
import 'package:gestion_albums/themeController.dart';
import 'Appbar/appbar.dart';
import 'package:json_theme/json_theme.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:gestion_albums/Album.dart';


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
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCard('News', 'Dernières actualités'),
                const SizedBox(height: 8),
                _buildCard('Version 1 en cours de développement', 'Wait and see'),
              ],
            ),
          )
        ],
      ),
    );
  }

Widget _buildAlbums() {
  return Container(
    color: Colors.blue, // Fond bleu
    alignment: Alignment.center,
    child: ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 10.0),
      children: <Widget>[
        Album(
          nomAlbum: "Metallica",
          description: "L'album marque une évolution importante dans le style du groupe. Les tempos sont plus lents, les morceaux plus courts et leurs structures beaucoup plus simples, aspirant ainsi à du simple rock. C'est principalement un album de heavy metal, et il n'y a plus beaucoup de traces de thrash metal.",
          nomGroupe: "Metallica",
          image: "Metallica.jpg",
        ),
        Album(
          nomAlbum: "Andjusticeforall",
          description: "Premier album de Linkin Park, sorti en 2000. Il a marqué le début du nu-metal avec des influences hip-hop et électroniques.",
          nomGroupe: "Linkin Park",
          image: "Andjusticeforall.jpg",
        ),
        Album(
          nomAlbum: "Hardwired",
          description: "L'album emblématique de Nirvana qui a popularisé le grunge à travers le monde avec des morceaux comme 'Smells Like Teen Spirit'.",
          nomGroupe: "Nirvana",
          image: "Hardwired.jpg",
        ),
        Album(
          nomAlbum: "Killemall",
          description: "L'album emblématique de Nirvana qui a popularisé le grunge à travers le monde avec des morceaux comme 'Smells Like Teen Spirit'.",
          nomGroupe: "Nirvana",
          image: "Killemall.jpg",
        ),
        Album(
          nomAlbum: "Masterofpuppets",
          description: "L'album emblématique de Nirvana qui a popularisé le grunge à travers le monde avec des morceaux comme 'Smells Like Teen Spirit'.",
          nomGroupe: "Nirvana",
          image: "Masterofpuppets.jpg",
        ),
        Album(
          nomAlbum: "Ridethelightning",
          description: "L'album emblématique de Nirvana qui a popularisé le grunge à travers le monde avec des morceaux comme 'Smells Like Teen Spirit'.",
          nomGroupe: "Nirvana",
          image: "Ridethelightning.jpg",
        ),
      ],
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