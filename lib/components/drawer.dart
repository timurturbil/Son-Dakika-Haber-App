import 'package:flutter/material.dart';
import 'package:t24haber/UI/custom_news_page.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  String dropdownValue = 'Haberler';
  String yazarlar = "Yazarlar";
  String kitaplar = "K24 Kitapları";
  @override
  Widget build(BuildContext context) {
    hangiSayfa(String? value) {
      if (value == "Dünya Basınında Bugün Haberleri") {
        return "rss/haber/dunya-basininda-bugun";
      } else if (value == "Koronavirüs Haberleri") {
        return "rss/haber/koronavirus";
      } else if (value == "Ekonomi Haberleri") {
        return "rss/haber/ekonomi";
      } else if (value == "Spor Haberleri") {
        return "rss/haber/spor";
      } else if (value == "Eğitim Haberleri") {
        return "rss/haber/egitim";
      } else if (value == "Magazin Haberleri") {
        return "rss/haber/magazin";
      } else if (value == "Yazarlar") {
        return "rss/yazarlar";
      } else if (value == "K24 Kitapları") {
        return "rss/k24/kitap";
      } else if (value == "Haberler") {
        return "rss";
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
                      image: NetworkImage(
                          "https://s1.dmcdn.net/v/PkQ0_1VtLomoydCK3/x720")))),
          Card(
            margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
            color: Colors.grey[200],
            child: DropdownButton<String>(
              value: dropdownValue,
              icon: const Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(color: Colors.black),
              underline: Container(
                height: 2,
                color: Colors.grey[200],
              ),
              onChanged: (String? newValue) => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CustomNewsPage(
                    route: hangiSayfa(newValue),
                    topic: newValue == "Haberler" ? "Son Dakika Haberler": newValue,
                  ),
                ),
              ),
              items: <String>[
                'Haberler',
                'Dünya Basınında Bugün Haberleri',
                'Koronavirüs Haberleri',
                'Ekonomi Haberleri',
                'Spor Haberleri',
                'Eğitim Haberleri',
                'Magazin Haberleri',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          Card(
              margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
              color: Colors.grey[200],
              child: ListTile(
                title: Text("$yazarlar"),
                contentPadding: EdgeInsets.all(5.0),
                onTap: () {
                  /* Navigator.pushNamed(context, '/yazarlar'); */
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CustomNewsPage(
                        route: hangiSayfa(yazarlar),
                        topic: yazarlar,
                      ),
                    ),
                  );
                },
              )),
          Card(
              margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
              color: Colors.grey[200],
              child: ListTile(
                title: Text("$kitaplar"),
                contentPadding: EdgeInsets.all(5.0),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CustomNewsPage(
                        route: hangiSayfa(kitaplar),
                        topic: kitaplar,
                      ),
                    ),
                  );
                  /* Navigator.pushNamed(context, '/kitaplar'); */
                },
              )),
        ],
      ),
    );
  }
}
