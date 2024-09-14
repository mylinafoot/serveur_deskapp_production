import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linafoot_admin/utils/requete.dart';
import 'package:http/http.dart' as http;

class MatchController extends GetxController with StateMixin<List> {
  //
  Requete requete = Requete();
  //
  RxMap equipeA = {}.obs;
  //
  RxMap equipeB = {}.obs;
  //
  //RxString stade = {}.obs;
  //
  RxMap commissaire = {}.obs;
  RxMap arbitreCentrale = {}.obs;
  RxMap arbitreAssitant1 = {}.obs;
  RxMap arbitreAssitant2 = {}.obs;
  RxMap arbitreProtocolaire = {}.obs;
  //
  //
  Future<List> getAllJourneeDeLaSaison(
      String idCalendrier, String categorie) async {
    //
    change([], status: RxStatus.loading());
    //
    Response response =
        await requete.getE("match/All/journee/$idCalendrier/$categorie");
    //
    if (response.isOk) {
      print("response mt: ${response.statusCode}");
      print("response mt: ${response.body}");
      // change(response.body, status: RxStatus.success());
      return response.body;
    } else {
      //
      print("response mt: ${response.statusCode}");
      print("response mt: ${response.body}");
      // change([], status: RxStatus.empty());
      return [];
    }
  }

  //
  Future<void> getAllMatchsDeLaJournee(
      int id, String idCalendrier, String categorie, String journee) async {
    //
    change([], status: RxStatus.loading());
    //
    Response response = await requete
        .getE("match/All/journee/$idCalendrier/$categorie/$journee");
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
  Future<void> updateMatch(Map equipe) async {
    //
    Response response = await requete.putE("match", equipe);
    //
    if (response.isOk) {
      //
      print("rep: ${response.body}");
      Get.back();
      getAllJourneeDeLaSaison(
          "${equipe['idCalendrier']}", "${equipe['categorie']}");
      Get.snackbar("Succès", "Mise à jour éffectué",
          backgroundColor: Colors.green);
    } else {
      //
      Get.back();
      //getAllJourneeDeLaSaison(id);
      Get.snackbar("Oups erreur",
          "Une erreur lors de la Mise à jour, code: ${response.statusCode}");
    }
  }

  //
  Future<void> saveMatch(Map equipe) async {
    //
    print("equipe: $equipe");
    //
    http.Response response = await requete.postE("match", equipe);
    //
    if (response.statusCode == 200 || response.statusCode == 201) {
      //
      Get.back();
      getAllJourneeDeLaSaison(
          "${equipe['idCalendrier']}", "${equipe['categorie']}");
      Get.snackbar("Succès", "L'enregistrement a abouti",
          backgroundColor: Colors.green);
    } else {
      //
      Get.back();
      //getAllJourneeDeLaSaison(id);
      Get.snackbar("Oups erreur",
          "L'enregistrement n'a pas abouti code: ${response.statusCode}");
    }
  }

  //
  Future<String> saveMatch2(Map equipe) async {
    //

    //
    http.Response response = await requete.postE("match", equipe);
    //
    if (response.statusCode == 200 || response.statusCode == 201) {
      //
      //Get.back();
      print("A______________________________");
      print("equipe: ${response.statusCode}");
      print("equipe: ${response.body}");
      print("A______________________________");
      return "Cool";
    } else {
      //
      //Get.back();
      print("B______________________________");
      print("equipe: ${response.statusCode}");
      print("equipe: ${response.body}");
      print("B______________________________");
      //getAllJourneeDeLaSaison(id);
      return "Pas cool";
    }
  }

  //
  Future<String> saveMatch3(List equipes) async {
    //

    //
    http.Response response = await requete.postE("match/all", equipes);
    //
    if (response.statusCode == 200 || response.statusCode == 201) {
      //
      //Get.back();
      print("A______________________________");
      print("equipe: ${response.statusCode}");
      print("equipe: ${response.body}");
      print("A______________________________");
      return "Cool";
    } else {
      //
      //Get.back();
      print("B______________________________");
      print("equipe: ${response.statusCode}");
      print("equipe: ${response.body}");
      print("B______________________________");
      //getAllJourneeDeLaSaison(id);
      return "Pas cool";
    }
  }

  //
  Future<Map> getOneArbitre(String id) async {
    //
    //
    Response response = await requete.getE("arbitre/one?id=$id");
    //
    if (response.isOk) {
      //
      return response.body;
    } else {
      //
      return {};
    }
  }

  //
  Future<Map> getOneCommissaire(String id) async {
    //
    //
    Response response = await requete.getE("commissaire/one?id=$id");
    //
    if (response.isOk) {
      //
      return response.body;
    } else {
      //
      return {};
    }
  }

  //
  Future<Map> getOneEquipe(String id) async {
    //
    //
    Response response = await requete.getE("equipe/one?id=$id");
    //
    if (response.isOk) {
      //
      return response.body;
    } else {
      //
      return {};
    }
  }
}
