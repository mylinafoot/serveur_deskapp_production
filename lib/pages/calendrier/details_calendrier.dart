import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'calendrier_controller.dart';
import 'categorie.dart';

class DetailsCalendrier extends StatelessWidget {
  //
  Map calendrier;
  final String saison;
  DetailsCalendrier(this.calendrier, this.saison) {
    vue = Rx(Categorie("${calendrier['id']}", "playoff", saison)); //
  }
  //
  CalendrierController calendrierController = Get.find();
  //
  Rx<Widget> vue = Rx(Container()); //
  RxInt choix = 0.obs;
  //"Encaissement", "Décaissement"
  List angles = [
    {"titre": "Playoff", "icon": "IcBaselineSportsSoccer"},
    {"titre": "Playdown", "icon": "MakiSoccer11"},
    {"titre": "Classique", "icon": "GameIconsSoccerKick"},
  ];
  //

  //
  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: AppBar(
        title: Text("${calendrier['label']} ${calendrier['saison']}"),
        centerTitle: true,
      ),
      body: Obx(() => vue.value),
      bottomNavigationBar: Container(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(angles.length, (index) {
            Map e = angles[index];
            return InkWell(
              onTap: () {
                //
                choix.value = index;
                //
                if (choix.value == 0) {
                  vue.value = Categorie("${calendrier['id']}", "playoff", saison);
                } else if (choix.value == 1) {
                  vue.value = Categorie("${calendrier['id']}", "playdown", saison);
                } else if (choix.value == 2) {
                  vue.value = Categorie("${calendrier['id']}", "Classique", saison);
                } else {
                  //
                  vue.value = Container();
                }
              },
              child: Obx(
                () => SizedBox(
                  //flex: 1,
                  //width: 70,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/${e["icon"]}.svg",
                        colorFilter: index == choix.value
                            ? const ColorFilter.mode(
                                Colors.blue, BlendMode.srcIn)
                            : const ColorFilter.mode(
                                Colors.grey, BlendMode.srcIn),
                        semanticsLabel: e["titre"],
                        height: 30,
                        width: 30,
                      ),
                      Text(
                        e["titre"],
                        style: TextStyle(
                          fontSize: 10,
                          color:
                              index == choix.value ? Colors.blue : Colors.grey,
                          fontWeight: index == choix.value
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  //
}
