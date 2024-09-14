import 'package:dropdown_button2/dropdown_button2.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:linafoot_admin/pages/stade/stade_controller.dart';
import 'package:linafoot_admin/utils/Loader.dart';
import 'package:linafoot_admin/utils/liste_arbitre.dart';
import 'package:linafoot_admin/utils/liste_commissaire.dart';
import 'package:linafoot_admin/utils/liste_equipes.dart';
import 'package:linafoot_admin/utils/recherche.dart';
import 'match_controller.dart';

class NouveauMatch extends StatefulWidget {

  NouveauMatch(this.idCalendrier, this.categorie, this.journee, this.saison);
  String idCalendrier;
  int journee;
  String categorie;
  String saison;

  @override
  State<NouveauMatch> createState() => _NouveauMatchState();
}

class _NouveauMatchState extends State<NouveauMatch> {
  String nomStade = '';
  int? selectedStadeIndex;
  void _onStadeSelected(int? value, List<Map<String, dynamic>> stades) {
    setState(() {
      selectedStadeIndex = value;
      if (value != null && value >= 0 && value < stades.length) {
        nomStade = "${stades[value]['nom'] ?? ''}";
        place.text = "${stades[value]['capaciteStade'] ?? ''}";
        nombreDePlacesPourtour.text = "${stades[value]['nombrePlacePourtoure'] ?? ''}";
        nombreDePlacesTribuneLateralle.text = "${stades[value]['nombrePlaceTribuneLateralle'] ?? ''}";
        nombreDePlacesTribuneHonneur.text = "${stades[value]['nombrePlaceTribuneDhonneur'] ?? ''}";
        nombreDePlacesTribuneCentrale.text = "${stades[value]['nombrePlaceTribuneCentrale'] ?? ''}";
        nombreDePlacesVIP.text = "${stades[value]['vip'] ?? ''}";
      }
    });
  }
  //
  StadeController stadeController = Get.find();
  //
  MatchController matchController = Get.find();
  RxInt stade = 0.obs;
  TextEditingController place = TextEditingController();
  //
  TextEditingController nombreDePlacesPourtour = TextEditingController();
  TextEditingController nombreDePlacesTribuneLateralle = TextEditingController();
  TextEditingController nombreDePlacesTribuneHonneur = TextEditingController();
  TextEditingController nombreDePlacesVIP = TextEditingController();
  TextEditingController nombreDePlacesTribuneCentrale = TextEditingController();
  TextEditingController prixPourtour = TextEditingController();
  TextEditingController prixVIP = TextEditingController();
  TextEditingController prixTribuneLateralle = TextEditingController();
  TextEditingController prixTribuneHonneur = TextEditingController();
  TextEditingController prixTribuneCentrale = TextEditingController();

  RxInt equipeA = 1.obs;
  RxInt equipeB = 1.obs;
  RxString province = "".obs;
  RxString date = "".obs;
  RxInt equipeBfin = 0.obs;
  RxMap scoreMitemps = {}.obs;
  RxMap scoreFin = {}.obs;
  RxInt division = 1.obs;
  RxString heure = "".obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nouveau match"),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          width: 500,
          child: ListView(
            padding: EdgeInsets.only(left: 10, right: 10, top: 10),
            children: [
              const SizedBox(
                height: 10,
              ),

              //
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Equipe A",
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
                        Recherche.affiche(ListEquipe("Equipe A"), context);
                      },
                      title: const Text("Ajouter"),
                      trailing: const Icon(Icons.add),
                    ),
                    Obx(
                      () => matchController.equipeA['nom'] != null
                          ? ListTile(
                              onTap: () {},
                              leading: SvgPicture.asset(
                                'assets/IcBaselineSportsSoccer.svg',
                                width: 25,
                                height: 25,
                                color: Colors.blue,
                                semanticsLabel: 'GalaPortrait1.svg',
                              ),
                              title: Text("${matchController.equipeA['nom']}"),
                              subtitle: Text(
                                  "${matchController.equipeA['province']}"),
                              trailing: IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  matchController.equipeA.value = {};
                                },
                              ),
                            )
                          : Container(),
                    ),
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
                  "Equipe B",
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
                        Recherche.affiche(ListEquipe("Equipe B"), context);
                      },
                      title: const Text("Ajouter"),
                      trailing: const Icon(Icons.add),
                    ),
                    Obx(
                      () => matchController.equipeB['nom'] != null
                          ? ListTile(
                              onTap: () {
                                //
                              },
                              leading: SvgPicture.asset(
                                'assets/IcBaselineSportsSoccer.svg',
                                width: 25,
                                height: 25,
                                color: Colors.blue,
                                semanticsLabel: 'GalaPortrait1.svg',
                              ),
                              title: Text("${matchController.equipeB['nom']}"),
                              subtitle: Text(
                                  "${matchController.equipeB['province']}"),
                              trailing: IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  //
                                  matchController.equipeB.value = {};
                                },
                              ),
                            )
                          : Container(),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Stade",
                  style: textStyle,
                ),
              ),
              Container(
                height: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade600),
                ),
                child: _stadeFieldDropdown(selectedStadeIndex, (value, stades) {
                  // Call the _onStadeSelected function in the parent widget
                  _onStadeSelected(value, stades);
                }),
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Nombre de place Pourtour",
                  style: textStyle,
                ),
              ),
              Container(
                //height: 60,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.grey.shade600,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextField(
                      controller: nombreDePlacesPourtour,
                    ),
                    TextField(
                      controller: prixPourtour,
                      decoration: InputDecoration(labelText: "Prix en Franc"),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Nombre de place Tribune Centrale",
                  style: textStyle,
                ),
              ),
              Container(
                //height: 60,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.grey.shade600,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextField(
                      controller: nombreDePlacesTribuneCentrale,
                      decoration: InputDecoration(),
                    ),
                    TextField(
                      controller: prixTribuneCentrale,
                      decoration: InputDecoration(labelText: "Prix en Franc"),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Nombre de place Tribune d'honneur",
                  style: textStyle,
                ),
              ),
              Container(
                //height: 60,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.grey.shade600,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextField(
                      controller: nombreDePlacesTribuneHonneur,
                      decoration: InputDecoration(),
                    ),
                    TextField(
                      controller: prixTribuneHonneur,
                      decoration: InputDecoration(labelText: "Prix en Franc"),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "VIP",
                  style: textStyle,
                ),
              ),
              Container(
                //height: 60,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.grey.shade600,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextField(
                      controller: nombreDePlacesVIP,
                      decoration: InputDecoration(),
                    ),
                    TextField(
                      controller: prixVIP,
                      decoration: InputDecoration(labelText: "Prix en Franc"),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Nombre de place Tribune Lateralle",
                  style: textStyle,
                ),
              ),
              Container(
                //height: 60,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.grey.shade600,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextField(
                      controller: nombreDePlacesTribuneLateralle,
                      decoration: InputDecoration(),
                    ),
                    TextField(
                      controller: prixTribuneLateralle,
                      decoration: InputDecoration(labelText: "Prix en Franc"),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Jour du match (date)",
                  style: textStyle,
                ),
              ),
              Container(
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
                        showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                lastDate: DateTime(2050),
                                firstDate: DateTime(1900))
                            .then((d) {
                          //
                          if (d != null) {
                            date.value = "${d.day}-${d.month}-${d.year}";
                          }
                        });
                      },
                      title: const Text("Ajouter"),
                      trailing: const Icon(Icons.calendar_month),
                    ),
                    Obx(
                      () => date.value.isNotEmpty
                          ? Text(
                              date.value,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            )
                          : Container(),
                    ),
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
                  "Heure",
                  style: textStyle,
                ),
              ),
              //
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
                        showTimePicker(
                                context: context, initialTime: TimeOfDay.now())
                            .then((d) {
                          //
                          if (d != null) {
                            heure.value = "${d.hour}:${d.minute}";
                          }
                        });
                      },
                      title: const Text("Ajouter"),
                      trailing: const Icon(Icons.timelapse),
                    ),
                    Obx(
                      () => heure.value.isNotEmpty
                          ? Text(
                              heure.value,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            )
                          : Container(),
                    ),
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
                  "Commissaire",
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
                        Recherche.affiche(ListCommissaire(), context);
                      },
                      title: const Text("Ajouter"),
                      trailing: const Icon(Icons.add),
                    ),
                    Obx(
                      () => matchController.commissaire['nom'] != null
                          ? ListTile(
                              onTap: () {
                                //
                              },
                              leading: SvgPicture.asset(
                                'assets/GalaPortrait1.svg',
                                width: 25,
                                height: 25,
                                color: Colors.blue,
                                semanticsLabel: 'GalaPortrait1.svg',
                              ),
                              title: Text(
                                  "${matchController.commissaire['nom']} ${matchController.commissaire['postnom']} ${matchController.commissaire['prenom']}"),
                              subtitle: Text(
                                  "${matchController.commissaire['region']}"),
                              trailing: IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  matchController.commissaire.value = {};
                                },
                              ),
                            )
                          : Container(),
                    ),
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
                  "Arbitre centrale",
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
                        Recherche.affiche(ListArbitre("A1"), context);
                      },
                      title: const Text("Ajouter"),
                      trailing: const Icon(Icons.add),
                    ),
                    Obx(
                      () => matchController.arbitreCentrale['nom'] != null
                          ? ListTile(
                              onTap: () {
                                //
                              },
                              leading: SvgPicture.asset(
                                'assets/IcBaselineSportsSoccer.svg',
                                width: 25,
                                height: 25,
                                color: Colors.blue,
                                semanticsLabel: 'GalaPortrait1.svg',
                              ),
                              title: Text(
                                  "${matchController.arbitreCentrale['nom']} ${matchController.arbitreCentrale['postnom']} ${matchController.arbitreCentrale['prenom']}"),
                              subtitle: Text(
                                  "${matchController.arbitreCentrale['province']}"),
                              trailing: IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  //
                                  matchController.arbitreCentrale.value = {};
                                },
                              ),
                            )
                          : Container(),
                    ),
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
                  "Arbitre assistant 1",
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
                        Recherche.affiche(ListArbitre("A2"), context);
                      },
                      title: const Text("Ajouter"),
                      trailing: const Icon(Icons.add),
                    ),
                    Obx(
                      () => matchController.arbitreAssitant1['nom'] != null
                          ? ListTile(
                              onTap: () {
                                //
                              },
                              leading: SvgPicture.asset(
                                'assets/IcBaselineSportsSoccer.svg',
                                width: 25,
                                height: 25,
                                color: Colors.blue,
                                semanticsLabel: 'GalaPortrait1.svg',
                              ),
                              title: Text(
                                  "${matchController.arbitreAssitant1['nom']} ${matchController.arbitreAssitant1['postnom']} ${matchController.arbitreAssitant1['prenom']}"),
                              subtitle: Text(
                                  "${matchController.arbitreAssitant1['province']}"),
                              trailing: IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  //
                                  matchController.arbitreAssitant1.value = {};
                                },
                              ),
                            )
                          : Container(),
                    ),
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
                  "Arbitre Assistant 2",
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
                        Recherche.affiche(ListArbitre("A3"), context);
                      },
                      title: const Text("Ajouter"),
                      trailing: const Icon(Icons.add),
                    ),
                    Obx(
                      () => matchController.arbitreAssitant2['nom'] != null
                          ? ListTile(
                              onTap: () {
                                //
                              },
                              leading: SvgPicture.asset(
                                'assets/IcBaselineSportsSoccer.svg',
                                width: 25,
                                height: 25,
                                color: Colors.blue,
                                semanticsLabel: 'GalaPortrait1.svg',
                              ),
                              title: Text(
                                  "${matchController.arbitreAssitant2['nom']} ${matchController.arbitreAssitant2['postnom']} ${matchController.arbitreAssitant2['prenom']}"),
                              subtitle: Text(
                                  "${matchController.arbitreAssitant2['province']}"),
                              trailing: IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  //
                                  matchController.arbitreAssitant2.value = {};
                                },
                              ),
                            )
                          : Container(),
                    ),
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
                  "Arbitre protocolaire",
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
                        Recherche.affiche(ListArbitre("A4"), context);
                      },
                      title: const Text("Ajouter"),
                      trailing: const Icon(Icons.add),
                    ),
                    Obx(
                      () => matchController.arbitreProtocolaire['nom'] != null
                          ? ListTile(
                              onTap: () {
                                //
                              },
                              leading: SvgPicture.asset(
                                'assets/IcBaselineSportsSoccer.svg',
                                width: 25,
                                height: 25,
                                color: Colors.blue,
                                semanticsLabel: 'GalaPortrait1.svg',
                              ),
                              title: Text(
                                  "${matchController.arbitreProtocolaire['nom']} ${matchController.arbitreProtocolaire['postnom']} ${matchController.arbitreProtocolaire['prenom']}"),
                              subtitle: Text(
                                  "${matchController.arbitreProtocolaire['province']}"),
                              trailing: IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  //
                                  matchController.arbitreProtocolaire.value =
                                      {};
                                },
                              ),
                            )
                          : Container(),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () async {
                  Loader.loading();
                  Map e = {
                    "idCalendrier": widget.idCalendrier,
                    "idEquipeA": matchController.equipeA['id'],
                    "nomEquipeA": matchController.equipeA['nom'],
                    "idEquipeB": matchController.equipeB['id'],
                    "nomEquipeB": matchController.equipeB['nom'],
                    "stade": nomStade,
                    "terrainNeutre": "",
                    "quiRecoit": "",
                    "saison": widget.saison,
                    "categorie": widget.categorie,
                    "journee": widget.journee,
                    "date": date.value,
                    "heure": heure.value,
                    "commissaire": matchController.commissaire['id'],
                    "mdpCommissaire": mdpGenerer(),
                    "arbitreCentrale": matchController.arbitreCentrale['id'],
                    "mdpArbitreCentrale": mdpGenerer(),
                    "arbitreAssitant1": matchController.arbitreAssitant1['id'],
                    "arbitreAssitant2": matchController.arbitreAssitant2['id'],
                    //""
                    "arbitreProtocolaire": matchController.arbitreProtocolaire['id'],
                    "mdpOfficier": mdpGenerer(),
                    "nombreDePlacesPourtour": nombreDePlacesPourtour.text,
                    "nombreDePlacesTribuneCentrale": nombreDePlacesTribuneCentrale.text,
                    "nombreDePlacesTribuneHonneur": nombreDePlacesTribuneHonneur.text,
                    "nombreDePlacesTribuneLateralle": nombreDePlacesTribuneLateralle.text,
                    "prixVIP": prixVIP.text,
                    //
                    "prixPourtour": prixPourtour.text,
                    "prixTribuneCentrale": prixTribuneCentrale.text,
                    "prixTribuneHonneur": prixTribuneHonneur.text,
                    "prixTribuneLateralle": prixTribuneLateralle.text,
                    //
                  };
                  //
                  matchController.saveMatch(e);
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: double.maxFinite,
                  child: const Text("Enregistrer"),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle textStyle = const TextStyle(
    fontWeight: FontWeight.bold,
  );

  //
  String mdpGenerer() {
    //
    var r = Random();
    //
    String mdp = "";
    for (int t = 0; t < 15; t++) {
      mdp = "$mdp${r.nextInt(10)}";
    }
    return mdp;
  }
}

//Drop down logique
Widget _stadeFieldDropdown(int? defaultValue, Function(int?, List<Map<String,dynamic>>) onChange) {
  var stadeController = Get.put(StadeController());
  int? _selectedValue = defaultValue;
  String label = "Sélectionnez un stade";
  var selectedOption = _selectedValue == null ? label : _selectedValue;

  return Center(
    child: FutureBuilder<List<Map<String, dynamic>>>(
      future: stadeController.getAllStades2(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          List<Map<String, dynamic>> stades = snapshot.data!;

          return DropdownButtonHideUnderline(
            child: DropdownButton2<int>(
              isExpanded: true,
              hint: Row(
                children: [
                  Icon(Icons.stadium, size: 16, color: Colors.grey),
                  SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      selectedOption.toString(),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              items: stades.map((stade) => DropdownMenuItem<int>(
                value: stades.indexOf(stade),
                child: Text(
                  stade['nom'] ?? '',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              )).toList(),
              value: _selectedValue,
              onChanged: (value) {
                // Pass the 'stades' list to the onChange callback
                onChange(value, stades);
              },
              // ... Customize button style, icon style, dropdown style as needed ...
            ),
          );
        } else {
          return Container(); // Handle no data
        }
      },
    ),
  );
}