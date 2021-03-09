import 'package:flutter/material.dart';
import 'package:plant_store/views/colors.dart';

class SinglePlant extends StatefulWidget {
  // final String image;
  // final String name;
  // final String time;
  // final String tip;
  final Plant plant;
  SinglePlant({@required this.plant});
  @override
  _SinglePlantState createState() => _SinglePlantState();
}

class _SinglePlantState extends State<SinglePlant> {
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
                      color: APP_BLACK,
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
                          "water ${widget.plant.time}",
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
                        onTap: () {
                          // setState
                        },
                        child: Container(
                          width: width / 3,
                          margin: EdgeInsets.only(top: 16),
                          padding: EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: width / 16,
                          ),
                          decoration: BoxDecoration(
                            color: APP_BLACK,
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
                              "Add to Favorites",
                              style: TextStyle(
                                  color: LIGHT_GREEN,
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
                child: Container(
                  // color: APP_BLACK,
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      color: APP_BLACK,
                      borderRadius: BorderRadius.circular(24)),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: LIGHT_GREEN,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
