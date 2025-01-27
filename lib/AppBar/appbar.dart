import 'package:flutter/material.dart';
import 'package:gestion_albums/themeController.dart';


class AppBar_Principal extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> actions;


  const AppBar_Principal({super.key, 
    required this.title, 
    this.actions = const [], 
  });

  @override
  _AppBar_PrincipalState createState() => _AppBar_PrincipalState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight); 
}

class _AppBar_PrincipalState extends State<AppBar_Principal> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(widget.title),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
          },
        ),
        IconButton(
          icon: const Icon(Icons.lightbulb),
          onPressed: () {
            themeController.toggleTheme();
          },        
        ),
     
        ...widget.actions,
      ],
    );
  }
}
