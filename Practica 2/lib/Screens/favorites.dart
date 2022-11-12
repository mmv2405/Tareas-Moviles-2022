import 'package:flutter/material.dart';

class favorites extends StatefulWidget {
  const favorites({Key? key}) : super(key: key);

  @override
  State<favorites> createState() => _favoritesState();
}

class _favoritesState extends State<favorites> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Favoritos'),
      ),
      body: Center(
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(20.0),
              child: Image.network(
                'https://i.scdn.co/image/d3acaeb069f37d8e257221f7224c813c5fa6024e',
                scale: 2.3,
              ),
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              child: Image.network(
                'https://i.scdn.co/image/d3acaeb069f37d8e257221f7224c813c5fa6024e',
                scale: 2.3,
              ),
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              child: Image.network(
                'https://i.scdn.co/image/d3acaeb069f37d8e257221f7224c813c5fa6024e',
                scale: 2.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
