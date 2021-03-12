// import 'package:flutter/material.dart';

import 'package:hive/hive.dart';
part 'Plant.g.dart';

@HiveType(typeId: 1)
class Plant {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String tip;
  @HiveField(2)
  final String image;
  @HiveField(3)
  final String time;
  @HiveField(4)
  final String id;
  @HiveField(5)
  final String duration;
  @HiveField(6)
  bool isLiked;

  Plant(
      {this.id,
      this.duration,
      this.isLiked = false,
      this.image,
      this.name,
      this.time,
      this.tip});

  factory Plant.fromJson(Map<String, dynamic> json) {
    return Plant(
        id: json["id"],
        duration: json['duration'],
        name: json['name'],
        image: json['image'],
        isLiked: false,
        tip: json['tip'],
        time: json['time']);
  }
}
