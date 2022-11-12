import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_track_app/utils/widgets/favoriteCard.dart';
import 'package:flutter/material.dart';

CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('favs');

Future<List<Object?>> getDataFirestore() async {
  // Get docs from collection reference
  QuerySnapshot querySnapshot = await _collectionRef.get();

  // Get data from docs and convert map to List
  final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

  return (allData);
}

class ListFav extends StatefulWidget {
  const ListFav({Key? key}) : super(key: key);

  @override
  State<ListFav> createState() => _ListFavState();
}

class _ListFavState extends State<ListFav> {
  @override
  Widget build(BuildContext context) {
    int index1 = 100;
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('favs').snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, index) => FavoriteCard(
              snap: snapshot.data!.docs[index].data(),
            ),
          );
        },
      ),
    );
  }
}
