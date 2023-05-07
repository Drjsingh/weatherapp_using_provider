import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wether_app/style/style.dart';

import '../model/provider/weather_notifier.dart';

class WeatherScreen extends StatefulWidget {
  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  var provider;

  double boxHeight = 0;

  double boxWidth = 0;

  String dd = "50d";
  int? clickIndex;
  int counter = 0;
  var todaydata;
  var day1Data;
  var day2Data;
  var day3Data;
  var day4Data;
  var day5Data;
  var allData;

  @override
  Widget build(BuildContext context) {
    boxHeight = MediaQuery.of(context).size.height;
    boxWidth = MediaQuery.of(context).size.width;
    provider = context.watch<WeatherNotifier>();
    todaydata = provider.day1;
    day1Data = provider.day2;
    day2Data = provider.day3;
    day3Data = provider.day4;
    day4Data = provider.day5;
    day5Data = provider.day6;
    allData = provider.allData;
    return provider.dataLoading
        ? Center(
            child: Container(
                height: 60, width: 60, child: CircularProgressIndicator()))
        : WillPopScope(
            onWillPop: () async => exit(0),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.3), BlendMode.darken),
                  image: const AssetImage("assets/background.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: SafeArea(
                    child: Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 15, top: 15),
                  child: Column(
                    children: [
                      Text(
                        provider.location,
                        style: ThemeStyle.whiteText28,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        provider.currentDate,
                        style: ThemeStyle.whiteText16,
                        textAlign: TextAlign.center,
                      ),
                      Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(bottom: 10, top: 10),
                          width: boxWidth,
                          height: boxHeight * 0.18,
                          decoration: BoxDecoration(
                              color: Colors.redAccent.withOpacity(0.2),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20))),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Max : ${(provider.maxTempList[0] - 273.15).round()}\u2103",
                                              style: ThemeStyle.whiteText16,
                                              textAlign: TextAlign.center,
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              "Min : ${(provider.minTempList[0] - 273.15).round()}\u2103",
                                              style: ThemeStyle.whiteText16,
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "${(todaydata[0]['main']['temp_min'] - 273.15).round()}\u2103",
                                          style: ThemeStyle.whiteText35,
                                          textAlign: TextAlign.center,
                                        ),
                                        Text(
                                          "Feels like: ${(todaydata[0]['main']['feels_like'] - 273.15).round()}\u2103",
                                          style: ThemeStyle.whiteText16,
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        ImageIcon(
                                          AssetImage(
                                              'assets/${todaydata[0]['weather']['icon']}.png'),
                                          size: 70,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          "${todaydata[0]['weather']['main']}",
                                          style: ThemeStyle.whiteText16,
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )),
                      Container(
                        width: boxWidth - 20,
                        height: 110,
                        decoration: BoxDecoration(
                            color: Colors.redAccent.withOpacity(0.2),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: todaydata.length,
                          itemBuilder: (context, int index) => Padding(
                            padding: const EdgeInsets.all(5),
                            child: Container(
                              margin: const EdgeInsets.only(left: 10),
                              width: 70,
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${todaydata[index]['time'].substring(0, 5)} ",
                                    style: ThemeStyle.whiteText14,
                                  ),
                                  ImageIcon(
                                    AssetImage(
                                        'assets/${todaydata[index]['weather']['icon']}.png'),
                                    size: 40,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    "${(todaydata[index]['main']['feels_like'] - 273.15).round()}\u2103",
                                    style: ThemeStyle.whiteText14,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: boxWidth - 20,
                        margin: const EdgeInsets.only(top: 15),
                        padding: const EdgeInsets.only(left: 5, bottom: 5),
                        child: const Text(
                          "Next 5 days Forecast :",
                          style: ThemeStyle.whiteText16,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                              color: Colors.redAccent.withOpacity(0.2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: ListView.builder(
                            padding: EdgeInsets.all(10),
                            scrollDirection: Axis.vertical,
                            itemCount: provider.yesterdayExist ? 5 : 6,
                            itemBuilder: (context, int index) => Container(
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        clickIndex = index;
                                        counter = counter + 1;
                                      });
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 80,
                                          child: Text(
                                            index == 0
                                                ? "Today"
                                                : index == 1
                                                    ? "Tomorrow"
                                                    : "${allData[index][0]['date']}",
                                            style: ThemeStyle.whiteText14,
                                          ),
                                        ),
                                        const Spacer(),
                                        Column(
                                          children: [
                                            ImageIcon(
                                              AssetImage(
                                                  'assets/${allData[index][0]['weather']['icon']}.png'),
                                              size: 50,
                                              color: Colors.white,
                                            ),
                                          ],
                                        ),
                                        Spacer(),
                                        Column(
                                          children: [
                                            Text(
                                              "H: ${(provider.maxTempList[index] - 273.15).round()}\u2103",
                                              style: ThemeStyle.whiteText14,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "L: ${(provider.minTempList[index] - 273.15).round()}\u2103",
                                              style: ThemeStyle.whiteText14,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (clickIndex == index &&
                                      counter % 2 == 1) ...[
                                    moreInfo(index == 0
                                        ? todaydata
                                        : index == 1
                                            ? day1Data
                                            : index == 2
                                                ? day2Data
                                                : index == 3
                                                    ? day3Data
                                                    : index == 4
                                                        ? day4Data
                                                        : day5Data)
                                  ] else ...[
                                    Container(),
                                  ],
                                  // Visibility(
                                  //   visible: clickIndex == index ? true : false,
                                  //   child: Container(
                                  //     height: 40,
                                  //     color: Colors.red,
                                  //   ),
                                  // ),
                                  const Divider(
                                    thickness: 3,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      MaterialButton(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          minWidth: 200,
                          height: 42,
                          color: const Color(0x6f6837f8),
                          child: const Text(
                            'Feedback',
                            style: ThemeStyle.whiteText20,
                          ),
                          onPressed: () async {
                            _sendEmail();
                          }),
                    ],
                  ),
                )),
              ),
            ),
          );
  }

  moreInfo(listData) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: Colors.transparent,
          border: Border.all(color: Colors.white)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 25, top: 10, bottom: 10),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Weather: ${listData[0]['weather']['description']} ",
                      style: ThemeStyle.whiteText14,
                    ),
                    Text(
                      "Humidity: ${listData[0]['main']['humidity']} ",
                      style: ThemeStyle.whiteText14,
                    ),
                    Text(
                      "Wind: ${listData[0]['wind']['speed']} km/h ",
                      style: ThemeStyle.whiteText14,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(
            thickness: 2,
          ),
          Container(
            height: 110,
            margin: const EdgeInsets.only(bottom: 10),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: listData.length,
              itemBuilder: (context, int index) => Container(
                margin: const EdgeInsets.only(left: 10),
                width: 70,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${listData[index]['time'].substring(0, 5)} ",
                      style: ThemeStyle.whiteText14,
                    ),
                    ImageIcon(
                      AssetImage(
                          'assets/${listData[index]['weather']['icon']}.png'),
                      size: 40,
                      color: Colors.white,
                    ),
                    Text(
                      "${(listData[index]['main']['feels_like'] - 273.15).round()}\u2103",
                      style: ThemeStyle.whiteText14,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _sendEmail() async {
    final Uri _emailLaunchUri = await Uri(
        scheme: 'mailto',
        path: 'dhirajraghunathsingh@gmail.com',
        queryParameters: {
          'subject': 'Weather App Feedback',
          'body': '',
        });
    var getInfo = await launch(_emailLaunchUri.toString());
  }
}
