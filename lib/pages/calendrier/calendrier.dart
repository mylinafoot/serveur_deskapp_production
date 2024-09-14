import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linafoot_admin/utils/Loader.dart';
import 'package:linafoot_admin/utils/requete.dart';
import 'calendrier_controller.dart';
import 'details_calendrier.dart';
import 'matchs/match_controller.dart';
import 'nouveau_calendrier.dart';

class Calendrier extends GetView<CalendrierController> {
  //
  MatchController matchController = Get.find();
  //
  Calendrier() {
    //
    controller.getAllEquipes();
  }

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
              RxList equipes = RxList(state as List);
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
                        children: List.generate(equipes.length, (index) {
                          //
                          Map equipe = equipes[index];
                          print(equipe);
                          //
                          if ("${equipe['label']}".contains(mot.value) ||
                              "${equipe['saison']}".contains(mot.value)) {
                            String saison = equipe['saison'];
                            return ListTile(
                              onTap: () {
                                //
                                Get.to(DetailsCalendrier(equipe, saison));
                                //
                              },
                              leading: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: const DecorationImage(
                                    image: ExactAssetImage(
                                        "assets/mylinafoot.jpg"),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              title: Text("${equipe['label']}"),
                              subtitle: Text("${equipe['saison']}"),
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
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              //
              Get.to(NouveauCalendrier());
              //
            },
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }

  load(Map e) async {
    String rep = await matchController.saveMatch2(e);
    print(rep);
  }
}
