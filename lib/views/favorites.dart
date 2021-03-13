import 'package:flutter/material.dart';
import 'package:plant_store/models/Plant.dart';
import 'package:plant_store/views/home.dart';

import '../main.dart';

class Favorites extends StatefulWidget {
  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  List<Plant> _cowsBabe;
  @override
  void initState() {
    _cowsBabe = fetchSaved();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      height: height - 56,
      child: ListView.builder(
        padding: EdgeInsets.only(
          top: 16,
        ),
        itemCount: _cowsBabe.length ?? 0,
        itemBuilder: (context, i) {
          return PlantPill(plant: _cowsBabe[i]);
        },
      ),
    );
  }
}
