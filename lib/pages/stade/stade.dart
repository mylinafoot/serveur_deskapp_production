import 'dart:async';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:linafoot_admin/pages/joueurs/nouveau_joueur.dart';
import 'package:linafoot_admin/pages/stade/stade_controller.dart';
import 'package:linafoot_admin/utils/Loader.dart';
import 'package:linafoot_admin/utils/requete.dart';

import 'details_stade.dart';
import 'nouveau_stade.dart';

class Stade extends GetView<StadeController> {
  //
  Stade() {
    //
    Timer(const Duration(seconds: 1), () {
      //
      controller.getAllStades();
    });
  }

  //
  RxMap joueur_ = {}.obs;
  //
  RxString mot = "".obs;

  @override
  Widget build(BuildContext context) {
    //
    return Center(
      child: Container(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        width: 500,
        child: Scaffold(
          appBar: AppBar(
              ),
          body: controller.obx(
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
                          Map stade = joueurs[index];
                          print(stade);
                          //
                          if ("${stade['nom']}".contains(mot.value)) {
                            //
                            return ListTile(
                              onTap: () {
                                //
                                joueur_.value = stade;
                                Get.to(DetailsStade(stade));
                                //Get.to(DetailsEquipe(equipe));
                                //
                              },
                              leading: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  // image: DecorationImage(
                                  //   image: NetworkImage(
                                  //       "${Requete.url}/joueur/profile/${stade['id']}"),
                                  //   fit: BoxFit.contain,
                                  // ),
                                ),
                                child: SvgPicture.asset(
                                  "assets/F7Sportscourt.svg",
                                  colorFilter: const ColorFilter.mode(
                                      Colors.blue, BlendMode.srcIn),
                                  semanticsLabel: stade["nom"],
                                  height: 30,
                                  width: 30,
                                ),
                              ),
                              title: Text("${stade['nom']}"),
                              subtitle: Text("${stade['ville']}"),
                              trailing: IconButton(
                                onPressed: () {
                                  //
                                  Loader.loading();
                                  //
                                  controller.supprimer("${stade['id']}");
                                  //
                                },
                                icon: const Icon(Icons.delete),
                              ),
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
              return const Center(
                child: Text(
                    "Une erreur c'est produite lors du chargement des informations"),
              );
            },
            onLoading: Loader.loadingW(),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              //
              Get.to(NouveauStade());
              //
            },
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
