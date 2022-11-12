import 'package:flutter/material.dart';

import '../logic/firestore_logic.dart';

class favorites extends StatefulWidget {
  const favorites({Key? key}) : super(key: key);

  @override
  State<favorites> createState() => _favoritesState();
}

class _favoritesState extends State<favorites> {
  var listFavs = getDataFirestore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListFav(),
    );
  }
}
