import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:linafoot_admin/pages/rapports/arbitre/arbitre_controller.dart';

class FormulaireArb5 extends StatelessWidget {
  //
  PageController controller;
  //
  ArbitreController2 arbitreController = Get.find();
  //
  FormulaireArb5(this.controller);

  @override
  Widget build(BuildContext context) {
    //
    return ListView(
      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
      children: [
        const SizedBox(
          height: 10,
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Avertissements joueurs equipe A",
            style: textStyle,
          ),
        ),
        Container(
          //height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.grey.shade600,
            ),
          ),
          child: Column(
            children: [
              Obx(
                () => Column(
                  children: List.generate(
                    arbitreController.avertissementsJoueursGeneralA.length,
                    (index) {
                      Map infos = arbitreController
                          .avertissementsJoueursGeneralA[index];
                      return ListTile(
                        onTap: () {
                          //
                        },
                        leading: SvgPicture.asset(
                          'assets/carte.svg',
                          width: 30,
                          height: 30,
                          semanticsLabel: 'carte.svg',
                          color: Colors.yellow.shade700,
                        ),
                        title: Text("${arbitreController.equipeA['nom']}"),
                        subtitle: Text("${infos['joueur']['nom']}"),

                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
        //
        const SizedBox(
          height: 10,
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Expulsions joueurs equipe A",
            style: textStyle,
          ),
        ),
        Container(
          //height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.grey.shade600,
            ),
          ),
          child: Column(
            children: [
              Obx(
                () => Column(
                  children: List.generate(
                    arbitreController.expulssionsJoueursGeneralA.length,
                    (index) {
                      Map infos =
                          arbitreController.expulssionsJoueursGeneralA[index];
                      return ListTile(
                        onTap: () {
                          //
                        },
                        leading: SvgPicture.asset(
                          'assets/carte.svg',
                          width: 30,
                          height: 30,
                          semanticsLabel: 'carte.svg',
                          color: Colors.red.shade700,
                        ),
                        title: Text("${arbitreController.equipeA['nom']}"),
                        subtitle: Text("${infos['joueur']['nom']}"),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
        //
        const SizedBox(
          height: 10,
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Buts joueurs equipe A",
            style: textStyle,
          ),
        ),
        Container(
          //height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.grey.shade600,
            ),
          ),
          child: Column(
            children: [
              Obx(
                () => Column(
                  children: List.generate(
                    arbitreController.butsJoueursGeneralA.length,
                    (index) {
                      Map infos = arbitreController.butsJoueursGeneralA[index];
                      return ListTile(
                        onTap: () {
                          //
                        },
                        leading: SvgPicture.asset(
                          'assets/IcBaselineSportsSoccer.svg',
                          width: 25,
                          height: 25,
                          color: Colors.blue,
                          semanticsLabel: 'IcBaselineSportsSoccer.svg',
                        ),
                        title: Text("${arbitreController.equipeA['nom']}"),
                        subtitle: Text("${infos['joueur']['nom']}"),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
        //_______________________________________________________
        const SizedBox(
          height: 10,
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Avertissements joueurs equipe B",
            style: textStyle,
          ),
        ),
        Container(
          //height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.grey.shade600,
            ),
          ),
          child: Column(
            children: [
              Obx(
                () => Column(
                  children: List.generate(
                    arbitreController.avertissementsJoueursGeneralB.length,
                    (index) {
                      Map infos = arbitreController
                          .avertissementsJoueursGeneralB[index];
                      return ListTile(
                        onTap: () {
                          //
                        },
                        leading: SvgPicture.asset(
                          'assets/carte.svg',
                          width: 30,
                          height: 30,
                          semanticsLabel: 'carte.svg',
                          color: Colors.yellow.shade700,
                        ),
                        title: Text("${arbitreController.equipeB['nom']}"),
                        subtitle: Text("${infos['joueur']['nom']}"),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
        //
        const SizedBox(
          height: 10,
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Expulsions joueurs equipe B",
            style: textStyle,
          ),
        ),
        Container(
          //height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.grey.shade600,
            ),
          ),
          child: Column(
            children: [
              Obx(
                () => Column(
                  children: List.generate(
                    arbitreController.expulssionsJoueursGeneralB.length,
                    (index) {
                      Map infos =
                          arbitreController.expulssionsJoueursGeneralB[index];
                      return ListTile(
                        onTap: () {
                          //
                        },
                        leading: SvgPicture.asset(
                          'assets/carte.svg',
                          width: 30,
                          height: 30,
                          semanticsLabel: 'carte.svg',
                          color: Colors.red.shade700,
                        ),
                        title: Text("${arbitreController.equipeB['nom']}"),
                        subtitle: Text("${infos['joueur']['nom']}"),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
        //
        const SizedBox(
          height: 10,
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Buts joueurs equipe B",
            style: textStyle,
          ),
        ),
        Container(
          //height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.grey.shade600,
            ),
          ),
          child: Column(
            children: [
              Obx(
                () => Column(
                  children: List.generate(
                    arbitreController.butsJoueursGeneralB.length,
                    (index) {
                      Map infos = arbitreController.butsJoueursGeneralB[index];
                      return ListTile(
                        onTap: () {
                          //
                        },
                        leading: SvgPicture.asset(
                          'assets/IcBaselineSportsSoccer.svg',
                          width: 25,
                          height: 25,
                          color: Colors.blue,
                          semanticsLabel: 'IcBaselineSportsSoccer.svg',
                        ),
                        title: Text("${arbitreController.equipeB['nom']}"),
                        subtitle: Text("${infos['joueur']['nom']}"),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),

        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  TextStyle textStyle = TextStyle(
    fontWeight: FontWeight.bold,
  );
}
