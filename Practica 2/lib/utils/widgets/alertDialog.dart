import 'package:find_track_app/utils/widgets/snackBars.dart';
import 'package:flutter/material.dart';

import '../../Screens/music.dart';

showAlertDialog(BuildContext context) {
  bool cancel = false;
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Cancel"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = TextButton(
    child: Text("Eliminar"),
    onPressed: () {
      cancel = !cancel;
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Eliminar de favoritos"),
    content:
        Text("El elemento sera eliminado de tus favoritos. Deseas continuar?"),
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
}

showAlertDialogFavoritos(BuildContext context) {
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
    onPressed: () {
      toggle = !toggle;

      showSnackBar('Removed from favorites!', context);
      cancel = !cancel;
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Eliminar de favoritos"),
    content:
        Text("El elemento sera eliminado de tus favoritos. Deseas continuar?"),
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
}
