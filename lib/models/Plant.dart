// import 'package:flutter/material.dart';

class Plant {
  final String name;
  final String tip;
  final String image;
  final String time;

  Plant({this.image, this.name, this.time, this.tip});

  factory Plant.fromJson(Map<String, dynamic> json) {
    return Plant(
        name: json['name'],
        image: json['image'],
        tip: json['tip'],
        time: json['time']);
  }
}
