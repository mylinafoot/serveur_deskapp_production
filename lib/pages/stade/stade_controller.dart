import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linafoot_admin/utils/requete.dart';
import 'package:http/http.dart' as http;

class StadeController extends GetxController with StateMixin<List> {
  //
  Requete requete = Requete();
  //
  Future<void> getAllStades() async {
    //
    change([], status: RxStatus.loading());
    //
    Response response = await requete.getE("stade/all");
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
  Future<List<Map<String, dynamic>>> getAllStades2() async {Response response = await requete.getE("stade/all");

  if (response.isOk) {
    print("response: ${response.statusCode}");
    print("response: ${response.body}");

    // Assuming response.body is a List<dynamic>
    List<Map<String, dynamic>> formattedStades = [];
    for (var item in response.body) {
      if (item is Map<String, dynamic>) {
        formattedStades.add(item);
      } else {
        print("Invalid stadium data: $item");
      }}
    return formattedStades; // Return a List<Map<String, dynamic>>
  } else {
    print("response: ${response.statusCode}");
    print("response: ${response.body}");
    return []; // Return an empty list in case of error
  }
  }

  //
  Future<void> saveStade(Map equipe) async {
    //
    http.Response response = await requete.postE("stade", equipe);
    //
    if (response.statusCode == 200 || response.statusCode == 201) {
      //
      Get.back();
      getAllStades();
      Get.snackbar("Succès", "L'enregistrement a abouti",
          backgroundColor: Colors.green);
    } else {
      //
      Get.back();
      getAllStades();
      Get.snackbar("Oups erreur",
          "L'enregistrement n'a pas abouti code: ${response.statusCode}");
    }
  }

  Future<void> updateStade(Map equipe) async {
    //
    Response response = await requete.putE("stade", equipe);
    //
    if (response.isOk) {
      //
      Get.back();
      getAllStades();
      Get.snackbar("Succès", "L'enregistrement a abouti",
          backgroundColor: Colors.green);
    } else {
      //
      Get.back();
      getAllStades();
      Get.snackbar("Oups erreur",
          "L'enregistrement n'a pas abouti code: ${response.statusCode}");
    }
  }

  //
  Future<String> saveStade2(Map equipe) async {
    //
    http.Response response = await requete.postE("stade", equipe);
    //
    if (response.statusCode == 200 || response.statusCode == 201) {
      //
      Get.back();
      getAllStades();
      // Get.snackbar("Succès", "L'enregistrement a abouti",
      //     backgroundColor: Colors.green);
      return "Cool";
    } else {
      //
      Get.back();
      getAllStades();
      // Get.snackbar("Oups erreur",
      //     "L'enregistrement n'a pas abouti code: ${response.statusCode}");
      return "Pas cool";
    }
  }

  //
  Future<void> supprimer(String idAgent) async {
    //
    Response response = await requete.deleteE("stade?id=$idAgent");
    //
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("response mt: ${response.statusCode}");
      print("response mt: ${response.body}");
      // change(response.body, status: RxStatus.success());
      //return response.body;
      Get.back();
      getAllStades();
    } else {
      //
      print("response mt: ${response.statusCode}");
      print("response mt: ${response.body}");
      // change([], status: RxStatus.empty());
      Get.back();
      Get.snackbar("Oups", "Un problème au serveur.");
      //return [];
    }
  }
}
