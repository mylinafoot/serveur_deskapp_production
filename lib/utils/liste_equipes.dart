import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:linafoot_admin/pages/calendrier/matchs/match_controller.dart';
import 'package:linafoot_admin/pages/equipes/equipe_controller.dart';

class ListEquipe extends StatelessWidget {
  //
  MatchController matchController = Get.find();
  EquipeController equipeController = Get.find();
  //
  String des;
  ListEquipe(this.des);

  RxString mot = "".obs;

  @override
  Widget build(BuildContext context) {
    //
    return Padding(
      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
      child: FutureBuilder(
        future: equipeController.getAllEquipes2(),
        builder: (c, t) {
          List equipes = t.data ?? [];
          if (t.hasData) {
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
                  child: ListView(
                    children: List.generate(
                      equipes.length,
                      (index) {
                        //
                        Map equipe = equipes[index];
                        //
                        if ("${equipe['nom']}".contains(mot.value)) {
                          //
                          return ListTile(
                            onTap: () {
                              //
                              if (des == "Equipe A") {
                                matchController.equipeA.value = equipe;
                                //arbitreController.equipeA.value = equipe;
                              }
                              //
                              if (des == "Equipe B") {
                                matchController.equipeB.value = equipe;
                                //arbitreController.equipeB.value = equipe;
                              }
                              //
                              Get.back();
                              //
                            },
                            leading: SvgPicture.asset(
                              'assets/IcBaselineSportsSoccer.svg',
                              width: 25,
                              height: 25,
                              color: Colors.blue,
                              semanticsLabel: 'GalaPortrait1.svg',
                            ),
                            title: Text("${equipe['nom']}"),
                            subtitle: Text("${equipe['province']}"),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                )
              ],
            );
          } else if (t.hasError) {
            return Container();
          }
          return const Center(
            child: SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
