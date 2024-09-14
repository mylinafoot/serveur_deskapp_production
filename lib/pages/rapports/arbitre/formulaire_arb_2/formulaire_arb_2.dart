import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../arbitre_controller.dart';

class FormulaireArb2 extends StatelessWidget {
  PageController controller;
  RxInt attitudeJouerA = 0.obs;
  RxInt attitudeJouerB = 0.obs;
  RxInt attitudePublicA = 0.obs;
  RxInt attitudePublicB = 0.obs;
  RxInt etatTerrain = 0.obs;
  RxInt etatInstallation = 0.obs;
  RxInt meteo = 1.obs;

  TextEditingController nombreSpectateur = TextEditingController();

  ArbitreController2 arbitreController = Get.find();

  List<String> etats = [
    "Tension et Excitation",
    "Encouragement",
    "Nervosité",
    "Critique",
    "Célébration ou Déception",
    "Réactions envers l'adversaire",
  ];

  List<String> meteos = [
    "Ensoleillé",
    "Nuageux",
    "Pluie",
    "Rosée",
  ];

  List<String> etatsTI = [
    "Pelouse Praticable",
    "Pelouse non Praticable",
    "Drainage Adéquat",
    "Drainage non Adéquat",
    "Marquages Clairs",
    "Marquages Ilisibles",
    "Fanions d'Angle",
    "Pas de fanions d'angle",
    "Filets de But solide et correct",
    "Filets de But troué et incorrect",
    "Surface Plane",
    "Surface dénivelé",
    "Bancs des Remplaçants",
    "Abscence de bancs des remplaçants",
    "Éclairage Suffisant",
    "Éclairage insuffisant",
    "Vestiaires Fonctionnels",
    "Vestiaires non fonctionnels",
    "Sièges pour les Spectateurs adequats",
    "Sièges pour les Spectateurs inexistants",
    "Tunnel Joueur sécurisé",
    "Tunnel Joueur non sécurisé",
    "Présence ambulance",
    "Ambulance absente",
    "Zones Réservées aux Médias existantes",
    "Zones Réservées aux Médias inexistantes",
    "Sécurité et Incendie maximale",
    "Sécurité et Incendie minimale",
    "Sécurité et Incendie inexistante",
    "Aspect Général"
  ];

  RxList<String> etatsTerrainListe = <String>[].obs;
  RxList<String> etatsInstallationListe = <String>[].obs;

  FormulaireArb2(this.controller);

  int getIndexFromValue(String value, List<String> list) {
    int index = list.indexOf(value);
    return index != -1 ? index : 0; // Retourner 0 si la valeur n'est pas trouvée
  }

  @override
  Widget build(BuildContext context) {
    // Mapper les valeurs de l'API aux indices
    attitudeJouerA.value = getIndexFromValue(arbitreController.comportementEquipeA.value, etats);
    attitudeJouerB.value = getIndexFromValue(arbitreController.comportementEquipeB.value, etats);
    attitudePublicA.value = getIndexFromValue(arbitreController.comportementPubliqueEquipeA.value, etats);
    attitudePublicB.value = getIndexFromValue(arbitreController.comportementPubliqueEquipeB.value, etats);
    meteo.value = getIndexFromValue(arbitreController.meteo.value, meteos);

    return ListView(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      children: [
        const SizedBox(height: 10),
        _buildMeteoSection(),
        const SizedBox(height: 10),
        _buildDropdownSection(
          "Comportement équipe A",
          attitudeJouerA,
          etats,
              (e) {
            attitudeJouerA.value = e as int;
            arbitreController.comportementEquipeA.value = etats[e];
            arbitreController.indexComportementEquipeA.value = e;
          },
        ),
        const SizedBox(height: 10),
        _buildDropdownSection(
          "Comportement équipe B",
          attitudeJouerB,
          etats,
              (e) {
            attitudeJouerB.value = e as int;
            arbitreController.comportementEquipeB.value = etats[e];
            arbitreController.indexComportementEquipeB.value = e;
          },
        ),
        const SizedBox(height: 10),
        _buildDropdownSection(
          "Comportement public A",
          attitudePublicA,
          etats,
              (e) {
            attitudePublicA.value = e as int;
            arbitreController.comportementPubliqueEquipeA.value = etats[e];
            arbitreController.indexComportementPubliqueEquipeA.value = e;
          },
        ),
        const SizedBox(height: 10),
        _buildDropdownSection(
          "Comportement public B",
          attitudePublicB,
          etats,
              (e) {
            attitudePublicB.value = e as int;
            arbitreController.comportementPubliqueEquipeB.value = etats[e];
            arbitreController.indexComportementPubliqueEquipeB.value = e;
          },
        ),
        const SizedBox(height: 10),
        _buildEtatTerrainSection(),
        const SizedBox(height: 10),
        _buildEtatInstallationSection(),
        const SizedBox(height: 20),
        _buildNavigationButtons(),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildMeteoSection() {
    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Condition météorologique",
            style: textStyle,
          ),
          Container(
            padding: const EdgeInsets.only(left: 10),
            height: 60,
            width: double.maxFinite,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.shade500,
                width: 1.2,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButtonHideUnderline(
              child: Obx(
                    () => DropdownButton(
                  onChanged: (e) {
                    meteo.value = e as int;
                    arbitreController.meteo.value = meteos[e];
                  },
                  value: meteo.value,
                  items: List.generate(
                    meteos.length,
                        (index) => DropdownMenuItem(
                      value: index,
                      child: Text(meteos[index]),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownSection(String title, RxInt selectedValue, List<String> items, void Function(int?) onChanged) {
    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: textStyle,
          ),
          Container(
            padding: const EdgeInsets.only(left: 10),
            height: 60,
            width: double.maxFinite,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.shade500,
                width: 1.2,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButtonHideUnderline(
              child: Obx(
                    () => DropdownButton(
                  onChanged: onChanged,
                  value: selectedValue.value,
                  items: List.generate(
                    items.length,
                        (index) => DropdownMenuItem(
                      value: index,
                      child: Text(items[index]),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEtatTerrainSection() {
    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "État du terrain",
            style: textStyle,
          ),
          Container(
            padding: const EdgeInsets.only(left: 10),
            width: double.maxFinite,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.shade500,
                width: 1.2,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                DropdownButtonHideUnderline(
                  child: Obx(
                        () => DropdownButton(
                      onChanged: (e) {
                        etatTerrain.value = e as int;
                        arbitreController.etatsTerrainListe.add(etatsTI[e]);
                      },
                      isExpanded: true,
                      value: etatTerrain.value,
                      items: List.generate(
                        etatsTI.length,
                            (index) => DropdownMenuItem(
                          value: index,
                          child: Text(etatsTI[index]),
                        ),
                      ),
                    ),
                  ),
                ),
                Obx(
                      () => Column(
                    children: List.generate(
                      arbitreController.etatsTerrainListe.length,
                          (index) {
                        String e = arbitreController.etatsTerrainListe[index];
                        return ListTile(
                          onTap: () {},
                          leading: SvgPicture.asset(
                            'assets/F7Sportscourt.svg',
                            width: 25,
                            height: 25,
                            color: Colors.blue,
                          ),
                          title: Text(e),
                          trailing: IconButton(
                            onPressed: () {
                              arbitreController.etatsTerrainListe.removeAt(index);
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEtatInstallationSection() {
    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "État des installations",
            style: textStyle,
          ),
          Container(
            padding: const EdgeInsets.only(left: 10),
            width: double.maxFinite,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.shade500,
                width: 1.2,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                DropdownButtonHideUnderline(
                  child: Obx(
                        () => DropdownButton(
                      onChanged: (e) {
                        etatInstallation.value = e as int;
                        arbitreController.etatsInstallationListe.add(etatsTI[e]);
                      },
                      isExpanded: true,
                      value: etatInstallation.value,
                      items: List.generate(
                        etatsTI.length,
                            (index) => DropdownMenuItem(
                          value: index,
                          child: Text(etatsTI[index]),
                        ),
                      ),
                    ),
                  ),
                ),
                Obx(
                      () => Column(
                    children: List.generate(
                      arbitreController.etatsInstallationListe.length,
                          (index) {
                        String e = arbitreController.etatsInstallationListe[index];
                        return ListTile(
                          onTap: () {},
                          leading: SvgPicture.asset(
                            'assets/F7Sportscourt.svg',
                            width: 25,
                            height: 25,
                            color: Colors.blue,
                          ),
                          title: Text(e),
                          trailing: IconButton(
                            onPressed: () {
                              arbitreController.etatsInstallationListe.removeAt(index);
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            controller.previousPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.ease,
            );
          },
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomLeft: Radius.circular(30),
              ),
            ),
            alignment: Alignment.center,
            height: 50,
            width: 100,
            child: const Text(
              "Retour",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            controller.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.ease,
            );
          },
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            alignment: Alignment.center,
            height: 50,
            width: 100,
            child: const Text(
              "Suivant 2/9",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  TextStyle textStyle = const TextStyle(
    fontWeight: FontWeight.bold,
  );
}
