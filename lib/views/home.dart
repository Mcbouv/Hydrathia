import 'package:flutter/material.dart';
import 'package:plant_store/models/Plant.dart';
import 'package:plant_store/models/readJson.dart';
import 'package:plant_store/views/colors.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  Future<List<Plant>> _futureBae;

  @override
  void initState() {
    _futureBae = readJson();
    super.initState();
  }

  @override
  Widget build(BuildContext ctx) {
    return FutureBuilder(
        future: _futureBae,
        builder: (ctx, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          // PROFILE SHIMMER
          return Home(
            plants: snapshot.data,
          );
        });
  }
}

class Home extends StatefulWidget {
  final List<Plant> plants;
  Home({@required this.plants});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: APP_WHITE,
        appBar: AppBar(
          backgroundColor: DARK_GREEN,
          // centerTitle: true,
          title: Text(
            "Hydrathia",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          bottom: TabBar(
            tabs: [
              Tab(
                text: "All",
              ),
              Tab(
                text: "Favorites",
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Container(
              width: width,
              height: height - 56,
              child: ListView.builder(
                padding: EdgeInsets.only(
                  top: 16,
                ),
                itemCount: widget.plants.length ?? 0,
                itemBuilder: (context, i) {
                  return PlantPill(
                      image: widget.plants[i].image,
                      name: widget.plants[i].name);
                },
              ),
            ),
            /* 000000000000000000000000000000000 */
            Container(
              width: width,
              height: height - 56,
              child: ListView(
                children: <Widget>[PlantPill(image: null, name: null)],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PlantPill extends StatelessWidget {
  final String image;
  final String name;
  PlantPill({@required this.image, @required this.name});
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        //
      },
      child: Container(
        width: width - 32,
        height: height / 3,
        margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
        decoration: BoxDecoration(
            border: Border.all(
              color: APP_GREY,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                  color: DARK_GREY.withOpacity(0.8),
                  blurRadius: 28,
                  offset: Offset(2, 2))
            ],
            borderRadius: BorderRadius.circular(12)),
        child: Stack(
          children: <Widget>[
            Positioned.fill(
                child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                image,
                fit: BoxFit.cover,
              ),
            )),
            Positioned.fill(
                child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: APP_GREY.withAlpha(100).withOpacity(0.1),
              ),
            )),
            Positioned(
              bottom: 12,
              left: 12,
              child: Text(
                name,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: REAL_BLACK,
                    fontWeight: FontWeight.w600,
                    fontSize: 18),
              ),
            ),
            // Positioned(
            //     right: 8,
            //     top: 8,
            //     child: GestureDetector(
            //       onTap: () {
            //         //
            //       },
            //       child: Container(
            //         child: Icon(
            //           Icons.favorite,
            //           color: APP_RED,
            //         ),
            //       ),
            //     )),
          ],
        ),
      ),
    );
  }
}
