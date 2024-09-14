import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linafoot_admin/pages/rapports/arbitre/arbitre_controller.dart';

import 'remplacement.dart';

class FormulaireArb33 extends StatelessWidget {
  //
  PageController controller;
  //
  ArbitreController2 arbitreController = Get.find();
  //
  FormulaireArb33(this.controller);
  //
  @override
  Widget build(BuildContext context) {
    //
    return ListView(
      padding: EdgeInsets.all(10),
      children: [
        const SizedBox(
          height: 10,
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Remplacements equipes A",
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
              ListTile(
                onTap: () {
                  //
                  Get.to(Remplacement("Equipe A"));
                  //
                },
                title: const Text("Ajouter"),
                trailing: const Icon(Icons.add),
              ),
              Obx(
                () => Column(
                  children: List.generate(
                    arbitreController.joueurRemplacantA.length,
                    (i) {
                      return Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ListTile(
                              onTap: () {
                                //
                              },
                              leading: Icon(
                                Icons.person,
                                color: Colors.blue,
                              ),
                              title: Text(
                                  "${arbitreController.joueurRemplacantA[i]['entrant']['nom']} ${arbitreController.joueurRemplacantA[i]['entrant']['postnom']} ${arbitreController.joueurRemplacantA[i]['entrant']['prenom']}"),
                              subtitle: Text(
                                  "${arbitreController.joueurRemplacantA[i]['entrant']['numero']}"),
                              // trailing: IconButton(
                              //   icon: Icon(
                              //     Icons.delete,
                              //     color: Colors.red,
                              //   ),
                              //   onPressed: () {
                              //     //
                              //     arbitreController.joueurRemplacantA
                              //         .removeAt(i);
                              //     //
                              //   },
                              // ),
                            ),
                            ListTile(
                              onTap: () {
                                //
                              },
                              leading: Icon(
                                Icons.person,
                                color: Colors.blue,
                              ),
                              title: Text(
                                  "${arbitreController.joueurRemplacantA[i]['sortant']['nom']}"),
                              subtitle: Text(
                                  "${arbitreController.joueurRemplacantA[i]['sortant']['numero']}"),
                              // trailing: IconButton(
                              //   icon: Icon(
                              //     Icons.delete,
                              //     color: Colors.red,
                              //   ),
                              //   onPressed: () {
                              //     //
                              //     arbitreController.joueurRemplacantA
                              //         .removeAt(i);
                              //     //
                              //   },
                              // ),
                            ),
                            ListTile(
                              leading: Icon(Icons.timelapse),
                              title: Text("Minute:"),
                              subtitle: Text(
                                  "${arbitreController.joueurRemplacantA[i]['minute']}"),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        //

        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  //
  TextStyle textStyle = TextStyle(
    fontWeight: FontWeight.bold,
  );
}
