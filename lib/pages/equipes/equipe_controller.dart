import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linafoot_admin/utils/requete.dart';
import 'package:http/http.dart' as http;

class EquipeController extends GetxController with StateMixin<List> {
  //
  Requete requete = Requete();
  //
  Future<void> getAllEquipes() async {
    //
    change([], status: RxStatus.loading());
    //
    Response response = await requete.getE("equipe/All");
    //
    if (response.statusCode == 200 || response.statusCode == 201) {
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
  Future<List> getAllEquipes2() async {
    //
    //
    Response response = await requete.getE("equipe/All");
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
  //
  Future<void> saveEquipe(Map equipe) async {
    //
    http.Response response = await requete.postE("equipe", equipe);
    //
    if (response.statusCode == 200 || response.statusCode == 201) {
      //
      print("Rep Eq: ${response.statusCode} -- ${response.body}");
      //
      Get.back();
      getAllEquipes();
      Get.snackbar("Succès", "L'enregistrement a abouti",
          backgroundColor: Colors.green);
    } else {
      //
      print("Rep Eq: ${response.statusCode} -- ${response.body}");
      //
      Get.back();
      getAllEquipes();
      Get.snackbar("Oups erreur",
          "L'enregistrement n'a pas abouti code: ${response.statusCode}");
    }
  }

  //
  Future<void> saveEquipe2(List equipes) async {
    //
    http.Response response = await requete.postE("equipe/saveall", equipes);
    //
    if (response.statusCode == 200 || response.statusCode == 201) {
      //
      Get.back();
      getAllEquipes();
      Get.snackbar("Succès", "L'enregistrement a abouti",
          backgroundColor: Colors.green);
    } else {
      //
      Get.back();
      getAllEquipes();
      Get.snackbar("Oups erreur",
          "L'enregistrement n'a pas abouti code: ${response.statusCode}");
    }
  }

  //
  Future<void> updateEquipe(Map equipe) async {
    //
    Response response = await requete.putE("equipe", equipe);
    //
    if (response.isOk) {
      //
      print("rep: ${response.body}");
      Get.back();
      getAllEquipes();
      Get.snackbar("Succès", "Mise à jour éffectué",
          backgroundColor: Colors.green);
    } else {
      //
      Get.back();
      getAllEquipes();
      Get.snackbar("Oups erreur",
          "Une erreur lors de la Mise à jour, code: ${response.statusCode}");
    }
  }
}
