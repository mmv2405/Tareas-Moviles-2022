import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_track_app/utils/widgets/snackBars.dart';
import 'package:flutter/material.dart';

class FavoriteCard extends StatefulWidget {
  final snap;
  FavoriteCard({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  State<FavoriteCard> createState() => _FavoriteCardState();
}

class _FavoriteCardState extends State<FavoriteCard> {
  bool toggle = false;
  bool cancel = false;
  final _db = FirebaseFirestore.instance;

  getRank(
    int rank,
    var data,
    String? uid,
  ) {
    for (int i = 0; i < data.length; i++) {
      if (uid == data[i].reference.id) {
        rank = i + 1;
      }
    }
    return rank;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 2,
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .13,
              width: double.infinity,
              child: Image.network(
                widget.snap['imageUrl'],
                fit: BoxFit.cover,
              ),
            ),
            ButtonBar(
              buttonPadding: EdgeInsets.all(1),
              alignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    icon: toggle
                        ? Icon(Icons.favorite_border)
                        : Icon(Icons.favorite),
                    onPressed: () {
                      //UPLOAD AND REMOVE FROM FIREBASE
                      if (toggle == false) {
                        // set up the buttons
                        bool cancel = false;
                        Widget cancelButton = TextButton(
                          child: Text("Cancel"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        );
                        Widget continueButton = TextButton(
                          child: Text("Eliminar"),
                          onPressed: () async {
                            await _db
                                .collection("favs")
                                .doc('3ZaFW17ZQAT72rhJGXdv')
                                .delete();
                            setState(() {
                              toggle = !toggle;
                            });

                            showSnackBar('Removed from favorites!', context);
                            cancel = !cancel;
                            Navigator.of(context).pop();
                          },
                        );

                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          title: Text("Eliminar de favoritos"),
                          content: Text(
                              "El elemento sera eliminado de tus favoritos. Deseas continuar?"),
                          actions: [
                            cancelButton,
                            continueButton,
                          ],
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      } else {
                        showSnackBar('Added to favorites!', context);
                        setState(() {
                          toggle = !toggle;
                        });
                      }
                    }),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    widget.snap['title'],
                    style: TextStyle(color: Colors.white.withOpacity(0.6)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
