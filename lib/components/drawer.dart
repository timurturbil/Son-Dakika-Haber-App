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

  Random random = new Random();
  List<String> publishers = [
    "ahmetyar@cnnturk.com.tr",
    "mehmetgün@cnnturk.com.tr",
    "pınarsarkık@cnnturk.com.tr",
    "fıratsimsek@cnnturk.com.tr",
    "rıdvantopal@cnnturk.com.tr",
    "acunkelen@cnnturk.com.tr",
    "havvaustun@cnnturk.com.tr",
    "ozanerdeniz@cnnturk.com.tr",
    "ferdayeren@cnnturk.com.tr",
    "faitarslan@cnnturk.com.tr",
    "rasimoz@cnnturk.com.tr",
    "aydintarak@cnnturk.com.tr",
    "kemaltukenmez@cnnturk.com.tr"
    "hakanarslan@cnnturk.com.tr"
  ];

  List<String> items = [
    'Son Dakika Haberler',
    'Dünya\'dan Haberler',
    'Koronavirüs haberleri',
    'Politika Haberleri',
    'Ekonomi Haberleri',
    'Spor Haberleri',
    'Eğitim Haberleri',
    'Kültür-Sanat Haberleri',
    'Magazin Haberleri',
    'Medya Haberleri',
    'Bilim / Teknoloji Haberleri',
    'Sağlık Haberleri',
  ];

  void _launchURL() async => await canLaunch("https://www.cnnturk.com")
      ? await launch("https://www.cnnturk.com")
      : throw 'Could not launch https://www.cnnturk.com';
  @override
  Widget build(BuildContext context) {
    hangiSayfa(String? value) {
      if (value == "Son Dakika Haberler") {
        return null;
      } else if (value == "Dünya\'dan Haberler") {
        return "dunya-basininda-bugun";
      } else if (value == "Koronavirüs Haberleri") {
        return "koronavirus";
      } else if (value == "Politika Haberleri") {
        return "politika";
      } else if (value == 'Ekonomi Haberleri') {
        return "ekonomi";
      } else if (value == 'Spor Haberleri') {
        return "spor";
      } else if (value == "Eğitim Haberleri") {
        return "egitim";
      } else if (value == "Kültür-Sanat Haberleri") {
        return "kultur-sanat";
      } else if (value == "Magazin Haberleri") {
        return "magazin";
      } else if (value == "Medya Haberleri") {
        return "medya";
      } else if (value == "Bilim / Teknoloji Haberleri") {
        return "bilim-teknoloji";
      } else if (value == "Sağlık Haberleri") {
        return "saglik";
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
                  return Card(
                    margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
                    color: Colors.grey[200],
                    child: ListTile(
                      title: Text("${items[index]}"),
                      subtitle: Text(
                          "Haber Editörü: ${publishers[random.nextInt(8)]}",
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
