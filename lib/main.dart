import 'package:flutter/material.dart';
import 'package:gestion_albums/Customicons.dart';
import 'package:gestion_albums/themeController.dart';
import 'Appbar/appbar.dart';
import 'package:json_theme/json_theme.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

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
          ? Center(
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
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'News',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Dernières actualités',
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Version 1 en cours de développement',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Wait and see',
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )

          ],
        ),
      ): null,
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
            label: 'Page suivante',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'Paramètres',
          ),
        ],
      ),
    );
  }
}
