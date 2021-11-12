import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:son_dakika_haber/UI/custom_news_page.dart';
import 'package:url_launcher/url_launcher.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  String dropdownValue = 'Son Dakika Haberler';
  final _scrollController = ScrollController();
  List<String> items = [
    'Son Dakika Haberler',
    'Dünya\'dan Haberler',
    'Türkiye\'den Haberler',
    'Ekonomi Haberleri',
    'Spor Haberleri',
    'Magazin Haberleri',
    'Kültür-Sanat Haberleri',
    'Sağlık Haberleri',
    'Yazar Haberleri',
    'Otomobil Haberleri',
    'Seyahat Haberleri'
  ];
  Random random = new Random();
  List<String> publishers = [
    "ahmetyardelen@cnnturk.com.tr",
    "mehmetgöngören@cnnturk.com.tr",
    "pınarsarkık@cnnturk.com.tr",
    "fıratsimsek@cnnturk.com.tr",
    "rıdvantopal@cnnturk.com.tr",
    "acunkelen@cnnturk.com.tr",
    "havvaustunseven@cnnturk.com.tr",
    "ozanerdeniz@cnnturk.com.tr",
    "ferdayerebakan@cnnturk.com.tr",
    "faitarslan@cnnturk.com.tr",
    "rasimoz@cnnturk.com.tr",
    "aydintarak@cnnturk.com.tr",
    "kemaltukenmez@cnnturk.com.tr"
    "hakanerarslan@cnnturk.com.tr"
  ];

  void _launchURL() async => await canLaunch("https://www.cnnturk.com")
      ? await launch("https://www.cnnturk.com")
      : throw 'Could not launch https://www.cnnturk.com';
  @override
  Widget build(BuildContext context) {
    hangiSayfa(String? value) {
      if (value == "Son Dakika Haberler") {
        return "all";
      } else if (value == "Dünya\'dan Haberler") {
        return "dunya";
      } else if (value == "Türkiye\'den Haberler") {
        return "turkiye";
      } else if (value == "Ekonomi Haberleri") {
        return "ekonomi";
      } else if (value == "Spor Haberleri") {
        return "spor";
      } else if (value == 'Magazin Haberleri') {
        return "magazin";
      } else if (value == "Kültür-Sanat Haberleri") {
        return "kultur-sanat";
      } else if (value == "Sağlık Haberleri") {
        return "saglik";
      } else if (value == "Yazar Haberleri") {
        return "yazarlar";
      } else if (value == "Otomobil Haberleri") {
        return "otomobil";
      } else if (value == "Seyahat Haberleri") {
        return "seyahat";
      }
    }

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
              child: null,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.contain,
                      image: AssetImage('assets/images.jpg')))),
          Container(
            height: Get.height / 1.5,
            child: CupertinoScrollbar(
              controller: _scrollController,
              isAlwaysShown: true,
              child: ListView.separated(
                padding: EdgeInsets.all(0),
                controller: _scrollController,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Column(
                      children: [
                        Card(
                          margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
                          color: Colors.grey[200],
                          child: ListTile(
                            title: GestureDetector(
                                child: Row(
                                  children: [
                                    Text("Haber Kaynağı: "),
                                    Text("www.cnnturk.com",
                                        style: TextStyle(
                                            fontSize: 12,
                                            decoration:
                                                TextDecoration.underline,
                                            color: Colors.blue)),
                                  ],
                                ),
                                onTap: _launchURL),
                            subtitle: GestureDetector(
                                child: Row(
                                  children: [
                                    Text(
                                        "Haber Kordinatör Maili: internet@cnnturk.com",
                                        style: TextStyle(fontSize: 11)),
                                  ],
                                ),
                                onTap: () {}),
                            contentPadding: EdgeInsets.all(5.0),
                            onTap: () {},
                          ),
                        ),
                        Divider(),
                        Card(
                          margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
                          color: Colors.grey[200],
                          child: ListTile(
                            title: Text("${items[index]}"),
                            subtitle: Text("Haber Editörü: ${publishers[random.nextInt(8)]}",
                  style: TextStyle(fontSize: 11)),
                            contentPadding: EdgeInsets.all(5.0),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CustomNewsPage(
                                    route: hangiSayfa(items[index]),
                                    topic: items[index],
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    );
                  }
                  return Card(
                    margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
                    color: Colors.grey[200],
                    child: ListTile(
                      title: Text("${items[index]}"),
                      subtitle: Text("Haber Editörü: ${publishers[random.nextInt(8)]}",
                  style: TextStyle(fontSize: 11)),
                      contentPadding: EdgeInsets.all(5.0),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CustomNewsPage(
                              route: hangiSayfa(items[index]),
                              topic: items[index],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
                separatorBuilder: (context, i) {
                  return Divider();
                },
              ),
            ),
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
