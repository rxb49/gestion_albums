import 'package:flutter/material.dart';

class Album extends StatelessWidget {
  final String? nomAlbum;
  final String? description;
  final String? nomGroupe;
  final String? image;

  Album({Key? key, this.nomAlbum, this.description, this.nomGroupe, this.image}) 
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4,
        child: Row(
          children: <Widget>[
            image != null
                ? Image.asset(
                    "img/$image",
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  )
                : Container(width: 100, height: 100, color: Colors.grey), // ✅ Image par défaut
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      nomAlbum ?? "Album inconnu",
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    Text(description ?? "Aucune description"),
                    const SizedBox(height: 4),
                    Text("Groupe : ${nomGroupe ?? 'Inconnu'}"),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
