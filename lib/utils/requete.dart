import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Requete extends GetConnect {
  //Le bon Urls
  static String url = "https://mylinafootbackendserveur-9c1d6014e77f.herokuapp.com";
  //static String url = "http://localhost:8080";
  //
  Future<Response> getE(String path) async {
    var response = await get("$url/$path");
    return response;
  }

  Future<http.Response> postE(String path, var e) async {
    var response = await http.post(
      Uri.parse("$url/$path"),
      body: jsonEncode(e),
      headers: {
        "Content-Type": "application/json",
      },
    );
    return response;
  }

  Future<Response> putE(String path, Map e) async {
    //print(await http.read(Uri.https('example.com', 'foobar.txt')));
    var response = await put("$url/$path", e);
    return response;
  }

  Future<Response> deleteE(String path) async {
    //var url = Uri.parse("${Connexion.lien}$path");
    var response = await delete("$url/$path");
    //print(await http.read(Uri.https('example.com', 'foobar.txt')));
    return response;
  }
}
