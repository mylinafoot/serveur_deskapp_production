import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linafoot_admin/utils/requete.dart';
import 'package:http/http.dart' as http;

class JoueurController extends GetxController with StateMixin<List> {
  //
  Requete requete = Requete();
  //
  Future<void> getAllJoueurs(int id) async {
    //
    change([], status: RxStatus.loading());
    //
    Response response = await requete.getE("joueur/All/$id");
    //
    if (response.isOk) {
      print("response: ${response.statusCode}");
      print("response: ${response.body}");
      //
      change(response.body, status: RxStatus.success());
    } else {
      //
      print("response: ${response.statusCode}");
      print("response: ${response.body}");
      change([], status: RxStatus.empty());
    }
  }

  //
  Future<void> updateEquipe(Map equipe, int id) async {
    //
    Response response = await requete.putE("joueur", equipe);
    //
    if (response.isOk) {
      //
      print("rep: ${response.body}");
      Get.back();
      getAllJoueurs(id);
      Get.snackbar("Succès", "Mise à jour éffectué",
          backgroundColor: Colors.green);
    } else {
      //
      Get.back();
      getAllJoueurs(id);
      Get.snackbar("Oups erreur",
          "Une erreur lors de la Mise à jour, code: ${response.statusCode}");
    }
  }

  //
  Future<void> saveJoueur(Map joueur, int id) async {
    //
    http.Response response = await requete.postE("joueur", joueur);
    //
    if (response.statusCode == 200 || response.statusCode == 201) {
      //
      Get.back();
      getAllJoueurs(id);
      Get.snackbar("Succès", "L'enregistrement a abouti",
          backgroundColor: Colors.green);
    } else {
      //
      print("Rep Eq: ${response.statusCode} -- ${response.body}");
      //
      Get.back();
      getAllJoueurs(id);
      Get.snackbar("Oups erreur",
          "L'enregistrement n'a pas abouti code: ${response.statusCode}");
    }
  }

  //
  Future<String> saveJoueur2(Map equipe, int id) async {
    //
    http.Response response = await requete.postE("joueur", equipe);
    //
    if (response.statusCode == 200 || response.statusCode == 201) {
      //
      Get.back();
      getAllJoueurs(id);
      // Get.snackbar("Succès", "L'enregistrement a abouti",
      //     backgroundColor: Colors.green);
      return "Cool";
    } else {
      //
      Get.back();
      getAllJoueurs(id);
      // Get.snackbar("Oups erreur",
      //     "L'enregistrement n'a pas abouti code: ${response.statusCode}");
      return "Pas cool";
    }
  }
}
