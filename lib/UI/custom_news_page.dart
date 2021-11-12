import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:son_dakika_haber/UI/news_detail.dart';
import 'package:son_dakika_haber/components/drawer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;
import 'dart:math';

class CustomNewsPage extends StatefulWidget {
  final String? route;
  final String? topic;

  const CustomNewsPage({Key? key, this.route, this.topic}) : super(key: key);
  @override
  _CustomNewsPageState createState() => _CustomNewsPageState();
}

class _CustomNewsPageState extends State<CustomNewsPage> {
  GlobalKey<RefreshIndicatorState>? _refreshKey;
  RssFeed? _feed;
  TextEditingController controller = TextEditingController();
  String? search;
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
  Future<RssFeed?> loadFeed(context) async {
    try {
      final client = http.Client();
      final response = await client.get(Uri.https("www.cnnturk.com",
          "feed/rss/${widget.route == null ? "all" : widget.route}/news"));
      return RssFeed.parse(utf8
          .decode(response.bodyBytes)
          .replaceAll("&#39;", "'")
          .replaceAll("&quot;", ""));
    } catch (e) {}
    return null;
  }

  load(context) async {
    loadFeed(context).then((result) {
      if (null == result || result.toString().isEmpty) {
        return;
      }
      updateFeed(result);
    });
  }

  updateFeed(feed) {
    setState(() {
      _feed = feed;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshKey = GlobalKey<RefreshIndicatorState>();
    load(context);
  }

  thumbnail(imageUrl) {
    return Padding(
      padding: EdgeInsets.only(left: 0),
      child: Image.network(
        imageUrl,
        height: 50,
        width: 90,
        alignment: Alignment.center,
        fit: BoxFit.fill,
      ),
    );
  }

  list() {
    return ListView.builder(
      itemCount: _feed!.items!.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
            margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
            color: Colors.white,
            child: ListTile(
              title: Text(_feed!.items![index].title!,
                  style: TextStyle(fontSize: 13)),
              subtitle: Text("Haber Editörü: ${publishers[random.nextInt(8)]}",
                  style: TextStyle(fontSize: 11)),
              leading: _feed!.items![index].image == null
                  ? Container(
                      height: 50,
                      width: 90,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.contain,
                              image: AssetImage('assets/empty_image.jpg'))))
                  : thumbnail(_feed!.items![index].image.toString()),
              trailing: Icon(Icons.keyboard_arrow_right),
              contentPadding: EdgeInsets.all(5.0),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          WebViewExample(_feed!.items![index].link!)),
                );
              },
            ));
      },
    );
  }

  void _launchURL() async => await canLaunch("https://www.cnnturk.com")
      ? await launch("https://www.cnnturk.com")
      : throw 'Could not launch https://www.cnnturk.com';

  @override
  Widget build(BuildContext context) {
    isFeedEmpty() {
      return null == _feed || null == _feed!.items;
    }

    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
          backgroundColor: Colors.black54,
          title: Text(
              "${widget.topic == null ? "Son Dakika Haberler" : widget.topic}")),
      body: body(context),
    );
  }

  isFeedEmpty() {
    return null == _feed || null == _feed!.items;
  }

  body(context) {
    return isFeedEmpty()
        ? Center(
            child: CircularProgressIndicator(),
          )
        : RefreshIndicator(
            key: _refreshKey,
            child: list(),
            onRefresh: () => load(context),
          );
  }
}
