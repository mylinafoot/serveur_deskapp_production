import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linafoot_admin/utils/requete.dart';
import 'package:http/http.dart' as http;

class ArbitreController extends GetxController with StateMixin<List> {
  //
  Requete requete = Requete();
  //
  Future<void> getAllArbitre() async {
    //
    change([], status: RxStatus.loading());
    //
    Response response = await requete.getE("arbitre/All");
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
  Future<void> updateEquipe(Map equipe) async {
    //
    Response response = await requete.putE("arbitre", equipe);
    //
    if (response.isOk) {
      //
      print("rep: ${response.body}");
      Get.back();
      getAllArbitre();
      Get.snackbar("Succès", "Mise à jour éffectué",
          backgroundColor: Colors.green);
    } else {
      //
      Get.back();
      getAllArbitre();
      Get.snackbar("Oups erreur",
          "Une erreur lors de la Mise à jour, code: ${response.statusCode}");
    }
  }

  Future<List> getAllArbitre2() async {
    //
    //
    Response response = await requete.getE("arbitre/All");
    //
    if (response.isOk) {
      print("response: ${response.statusCode}");
      print("response: ${response.body}");
      //
      return response.body;
    } else {
      //
      print("response: ${response.statusCode}");
      print("response: ${response.body}");
      return [];
    }
  }

  //
  Future<void> saveArbitre(Map equipe) async {
    //
    http.Response response = await requete.postE("arbitre", equipe);
    //
    if (response.statusCode == 200 || response.statusCode == 201) {
      //
      print("Rep::: ${response.statusCode} -- ${response.body}");
      //
      Get.back();
      getAllArbitre();
      Get.snackbar("Succès", "L'enregistrement a abouti",
          backgroundColor: Colors.green);
    } else {
      //
      Get.back();
      getAllArbitre();
      Get.snackbar("Oups erreur",
          "L'enregistrement n'a pas abouti code: ${response.statusCode}");
    }
  }

  //
  Future<String> saveCommissaire2(Map equipe) async {
    //
    http.Response response = await requete.postE("arbitre", equipe);
    //
    if (response.statusCode == 200 || response.statusCode == 201) {
      //
      Get.back();
      getAllArbitre();
      return "cool";
    } else {
      //
      Get.back();
      getAllArbitre();
      return "Pas cool";
    }
  }
}
