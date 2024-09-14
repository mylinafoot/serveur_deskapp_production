import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:linafoot_admin/pages/equipes/equipe_controller.dart';
import 'package:linafoot_admin/pages/joueurs/nouveau_joueur.dart';
import 'package:linafoot_admin/utils/Loader.dart';
import 'package:linafoot_admin/utils/requete.dart';

import 'details_joueur.dart';
import 'joueur_controller.dart';

class Joueurs extends GetView<JoueurController> {
  //
  Map equipe;
  Joueurs(this.equipe) {
    //
    Timer(const Duration(seconds: 1), () {
      //
      controller.getAllJoueurs(equipe['id']);
    });
  }
  //
  RxMap joueur_ = {}.obs;
  //

  //
  /*
  RxList equipes = [
    {
      "nom": "Tout puissant Mazembe Englebert",
      "province": "Lubumbashi",
      "categorie": ""
    },
    {"nom": "FC Saint-Éloi Lupopo", "province": "Lubumbashi", "categorie": ""},
    {"nom": "FC Lubumbashi sport", "province": "Lubumbashi", "categorie": ""},
    {"nom": "CS Don Bosco", "province": "Lubumbashi", "categorie": ""},
    {
      "nom": "As Maniema Union de Kindu",
      "province": "Maniema",
      "categorie": ""
    },
    {
      "nom": "As Dauphin noir de Goma",
      "province": "Nord Kiva",
      "categorie": ""
    },
    {"nom": "As Vita club", "province": "Kinshasa", "categorie": ""},
    // {
    //   "nom": "Dc Motema Pembe de Kinshasa",
    //   "province": "Kinshasa",
    //   "categorie": ""
    // },
    {"nom": "LES AIGLES DU CONGO", "province": "Kinshasa", "categorie": ""},
    //{"nom": "FC LUBUMBASHI SPORT", "province": "Mbuji-Mayi", "categorie": ""},
  ].obs;
  */
  //
  RxString mot = "".obs;

  @override
  Widget build(BuildContext context) {
    //
    return Center(
      child: Container(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        //width: 500,
        child: Scaffold(
          body: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 4,
                child: controller.obx(
                  (state) {
                    RxList joueurs = RxList(state as List);
                    return Column(
                      children: [
                        Container(
                          height: 55,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: TextField(
                            onChanged: (t) {
                              //
                              mot.value = t;
                              //
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Obx(
                            () => ListView(
                              children: List.generate(joueurs.length, (index) {
                                //
                                Map joueur = joueurs[index];
                                //
                                if ("${joueur['nom']}".contains(mot.value)) {
                                  //
                                  return ListTile(
                                    onTap: () {
                                      //
                                      joueur_.value = joueur;
                                      //Get.to(DetailsEquipe(equipe));
                                      //
                                    },
                                    leading: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              "${Requete.url}/joueur/profile/${joueur['id']}"),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    title: Text(
                                        "${joueur['nom']} ${joueur['postnom']} ${joueur['prenom']}"),
                                    subtitle: Text("${joueur['numero']}"),
                                  );
                                } else {
                                  return Container();
                                }
                              }),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                  onEmpty: Container(),
                  onError: (error) {
                    return Center(
                      child: Text(
                          "Une erreur c'est produite lors du chargement des informations"),
                    );
                  },
                  onLoading: Loader.loadingW(),
                ),
              ),
              Container(
                height: double.maxFinite,
                width: 2,
                color: const Color.fromARGB(255, 118, 0, 0),
              ),
              Expanded(
                flex: 4,
                child: Obx(
                  () => joueur_.value == {}
                      ? Container()
                      : DetailsJoueur(joueur_.value),
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              //
              Get.to(NouveauJoueur(equipe));
              //
            },
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
