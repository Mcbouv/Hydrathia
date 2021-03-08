import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Plant.dart';

Future<List<Plant>> readJson() async {
  String data = await rootBundle.loadString("assets/data.json");
  final jsonResult = jsonDecode(data);
  // print(jsonResult);
  List<Plant> results = [];
  List cows = [];
  cows = jsonResult['items'];
  // print(cows.toString());
  cows.map((i) {
    // print(i.toString());
    results.add(Plant.fromJson(i));
  });

  for (var item in cows) {
    // print(item);
    results.add(Plant.fromJson(item));
  }

  print(results.toString());
  return results;
}
