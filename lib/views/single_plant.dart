import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:plant_store/main.dart';
import 'package:plant_store/models/Plant.dart';
import 'package:plant_store/toast.dart';
import 'package:plant_store/views/colors.dart';

import 'home.dart';

class SinglePlant extends StatefulWidget {
  // final String image;
  // final String name;
  // final String time;
  // final String tip;
  final Plant plant;
  final bool isNotified;
  final String id;
  SinglePlant({this.plant, this.isNotified = false, this.id});
  @override
  _SinglePlantState createState() => _SinglePlantState();
}

class _SinglePlantState extends State<SinglePlant> {
  checkPayload() {
    if (widget.isNotified) {}
  }

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        child: Stack(
          children: <Widget>[
            Container(
              height: height / 1.6,
              width: width,
              decoration: BoxDecoration(color: DARK_GREEN),
              child: Image.asset(
                widget.plant.image,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
                bottom: 0,
                child: Container(
                  height: height / 2.4,
                  width: width,
                  padding: EdgeInsets.only(
                    left: 16,
                    top: 16,
                    right: 16,
                    bottom: 16,
                  ),
                  decoration: BoxDecoration(
                      color: widget.isNotified ? APP_WHITE : APP_BLACK,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(36),
                          topRight: Radius.circular(36))),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: <Widget>[
                      Container(
                        child: Text(
                          widget.plant.name,
                          style: TextStyle(
                              color: LIGHT_GREEN,
                              fontWeight: FontWeight.w600,
                              fontSize: 24),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 4),
                        child: Text(
                          widget.isNotified
                              ? "WATER TODAY"
                              : "water ${widget.plant.time}",
                          style: TextStyle(
                              color: LIGHT_GREEN,
                              fontWeight: FontWeight.w500,
                              fontSize: 18),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 16),
                        child: Text(
                          widget.plant.tip,
                          style: TextStyle(
                              color: LIGHT_GREEN,
                              fontWeight: FontWeight.w500,
                              fontSize: 18),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (widget.plant.isLiked) {
                            await removeFromDB(widget.plant);
                            showErrorToast(
                                "Plant removed from Favorites", context);
                          } else {
                            await saveToDB(widget.plant);
                            showSuccessToast(
                                "Plant added to Favorites", context);
                          }
                          setState(() {
                            widget.plant.isLiked = !widget.plant.isLiked;
                          });
                        },
                        child: Container(
                          width: width / 3,
                          margin: EdgeInsets.only(top: 16),
                          padding: EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: width / 16,
                          ),
                          decoration: BoxDecoration(
                            color:
                                widget.plant.isLiked ? LIGHT_GREEN : APP_BLACK,
                            border: Border.all(color: LIGHT_GREEN, width: 2),
                            boxShadow: [
                              BoxShadow(
                                  color: DARK_GREY.withAlpha(50),
                                  blurRadius: 22,
                                  offset: Offset(2, 1))
                            ],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                            child: Text(
                              widget.plant.isLiked
                                  ? "Favorite"
                                  : "Add to Favorites",
                              style: TextStyle(
                                  color: widget.plant.isLiked
                                      ? APP_BLACK
                                      : LIGHT_GREEN,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
            Positioned(
                top: 32,
                left: 8,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => App()));
                  },
                  child: Container(
                    // color: APP_BLACK,
                    padding: EdgeInsets.only(
                      left: 8,
                      top: 2,
                      bottom: 2,
                    ),
                    decoration: BoxDecoration(
                        color: APP_WHITE,
                        borderRadius: BorderRadius.circular(24)),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: DARK_GREEN,
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
