import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:wether_app/model/api/api.dart';
import 'package:wether_app/style/custome_loader.dart';
import 'package:wether_app/view/weather_screen.dart';

import '../model/provider/weather_notifier.dart';
import '../style/style.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/welcome.png"),
              MaterialButton(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  minWidth: 200,
                  height: 42,
                  color: Color(0x6f6837f8),
                  child: const Text(
                    'Get Started',
                    style: ThemeStyle.whiteText16,
                  ),
                  onPressed: () async {
                    CustomUIBlock.block(context);
                    final hasPermission = await _handlePermission();
                    if (!hasPermission) {
                      CustomUIBlock.unblock(context);
                      final snackBar = SnackBar(
                          content: Row(
                            children: const [
                              Flexible(
                                child: Text(
                                  "You can not check Weather forecast, because you denied the Location, Please allow location for Weather App in Mobile Setting Area",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          duration: const Duration(seconds: 5),
                          backgroundColor: Colors.red);
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      return;
                    }
                    var position =
                        await GeolocatorPlatform.instance.getCurrentPosition();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            ChangeNotifierProvider(
                              create: (context) => WeatherNotifier(position),
                              child: WeatherScreen(),
                            )));
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled =
        await GeolocatorPlatform.instance.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    permission = await GeolocatorPlatform.instance.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await GeolocatorPlatform.instance.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }
    return true;
  }
}
