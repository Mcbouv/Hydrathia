import 'dart:math';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:plant_store/views/single_plant.dart';

import 'models/Plant.dart';
import 'views/home.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  await openDb();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // NOTIFICATIONS
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    var initializationSettingsIOs = IOSInitializationSettings();
    var initSetttings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOs);

    flutterLocalNotificationsPlugin.initialize(initSetttings,
        onSelectNotification: onSelectNotification);
    super.initState();
  }

  Future onSelectNotification(String payload) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return SinglePlant(
        isNotified: true,
        id: payload,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hydrathia',
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: MyBehavior(),
          child: child,
        );
      },
      theme: ThemeData(
        fontFamily: 'ProximaNova',
      ),
      home: App(),
    );
  }
}

// VIP CLASS DON'T TAMPER!!!!!
class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

openDb() async {
  await Hive.initFlutter();
  // Register Adapter
  Hive.registerAdapter(PlantAdapter());
  var box = await Hive.openBox('dbBox');
  var plantBox = await Hive.openBox<Plant>('plants');
}

checkDB(Plant plant) {
  var box = Hive.box('dbBox');
  List saved = box.get('ids') ?? List.empty(growable: true);
  if (saved.contains(plant)) {
    plant.isLiked = true;
    return plant;
  } else {
    return null;
  }
}

fetchSaved() {
  var plantBox = Hive.box<Plant>('plants');
  return plantBox.values.toList(growable: true);
  //
}

saveToDB(Plant plant) async {
  Plant id = plant;
  var box = Hive.box('dbBox');
  var plantBox = Hive.box<Plant>('plants');
  // List saved = box.get('ids') ?? List.empty(growable: true);
  // Map<String, String> drrr = Map();

  // List durations_init = box.get('durations') ?? List.empty(growable: true);
  // List durations = List.empty(growable: true);
  // for (var item in durations_init) {
  //   durations.add(item);
  //   // print("Duration Success!!!!!!!");
  // }
  // print(durations.toString());
  // if (saved.length == 0) {
  id.isLiked = true;
  // saved.add(id);
  plantBox.put(id.id, id);

  try {
    String duration = plant.duration;
    if (duration == '7') {
      // durations.add("7");
      // drrr.addAll({id.id: duration});
      box.put(id.id, duration);
      await alarm7Days(plant);
    }
    if (duration == '12') {
      // durations.add("12");
      // box.put("durations", durations);
      box.put(id.id, duration);
      await alarm12Days(plant);
    }

    if (duration == '14') {
      // durations.add("14");
      // box.put("durations", durations);
      box.put(id.id, duration);
      await alarm14Days(plant);
    }
  } catch (e) {
    print('Alarm Error: $e');
  }
  // }

  // if (saved.contains(id)) {
  //   return;
  // } else {
  //   id.isLiked = true;
  //   saved.add(id);
  //   try {
  //     box.put("ids", saved);
  //   } catch (e) {
  //     print(e);
  //   }
  //   try {
  //     String duration = plant.duration;
  //     if (duration == '7') {
  //       durations.add("7");
  //       box.put("durations", durations);
  //       await alarm7Days(plant);
  //       // showSuccessToast();
  //     }
  //     if (duration == '12') {
  //       durations.add("12");
  //       box.put("durations", durations);
  //       alarm12Days(plant);
  //     }

  //     if (duration == '14') {
  //       durations.add("14");
  //       box.put("durations", durations);
  //       alarm14Days(plant);
  //     }
  //   } catch (e) {
  //     print('Alarm Error: $e');
  //   }
  // }
}

removeFromDB(Plant plant) {
  var box = Hive.box('dbBox');
  Plant id = plant;
  List saved = box.get('ids') ?? List.empty(growable: true);
  if (saved.length == 0) {
    return;
  }
  if (saved.contains(id)) {
    saved.remove(id);
    try {
      box.put("ids", saved);
    } catch (e) {
      print(e);
    }
    return;
  }
}

//  ********************* NOTIFICATIONS

showNotification({String id}) async {
  print("Alarm Fired");
  var android = new AndroidNotificationDetails('id', 'channel ', 'description',
      priority: Priority.High, importance: Importance.Max);
  var iOS = new IOSNotificationDetails();
  var platform = new NotificationDetails(android, iOS);

  try {
    var box = Hive.box('dbBox');
    var saved = Hive.box<Plant>('plants');
    Plant plant = saved.get(id);
    if (plant == null) {
      return;
    }
    await flutterLocalNotificationsPlugin.show(
        0, 'Watering', 'Water your ${plant.name}', platform,
        payload: plant.id);
    // List saved = box.get('ids') ?? List.empty(growable: true);
    // List durations = box.get('durations') ?? List.empty(growable: true);
    // if (durations.contains(num)) {
    //
    // for (var plant in saved.values) {
    //   if (plant.duration == num) {
    //     await flutterLocalNotificationsPlugin.show(
    //         0, 'Watering', 'Water your ${plant.name}', platform,
    //         payload: plant.id);
    //     break;
    //   }
    // }
    // }
  } catch (e) {
    print("Notification Error: $e");
  }
}

//  ********************** ALARMS
alarm7Days(Plant plant) async {
  await AndroidAlarmManager.periodic(
      const Duration(days: 7),
      // Ensure we have a unique alarm ID.
      Random().nextInt(pow(2, 31).toInt()),
      showNotification(id: plant.id),
      exact: true,
      wakeup: true,
      rescheduleOnReboot: true);
}

alarm12Days(Plant plant) async {
  await AndroidAlarmManager.periodic(
      const Duration(days: 12),
      // Ensure we have a unique alarm ID.
      Random().nextInt(pow(2, 31).toInt()),
      showNotification(id: plant.id),
      exact: true,
      wakeup: true,
      rescheduleOnReboot: true);
}

alarm14Days(Plant plant) async {
  await AndroidAlarmManager.periodic(
      const Duration(days: 14),
      // Ensure we have a unique alarm ID.
      Random().nextInt(pow(2, 31).toInt()),
      showNotification(id: plant.id),
      exact: true,
      wakeup: true,
      rescheduleOnReboot: true);
}
