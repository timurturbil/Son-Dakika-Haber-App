import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
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
    "kemaltukenmez@cnnturk.com.tr",
    "hakanerarslan@cnnturk.com.tr"
  ];
  Future<RssFeed?> loadFeed(context) async {
    try {
      final client = http.Client();
      final response = await client.get(Uri.https("www.t24.com.tr",
          "rss${widget.route == null ? "" : "/haber/" + widget.route!}"));
      print("response.statusCode: ${response.statusCode}");
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(2),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          alignment: Alignment.center,
          fit: BoxFit.fill,
          placeholder: (context, url) => Container(
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.height / 8,
            child: Center(child: CircularProgressIndicator()),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
    );
  }

  list() {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 0.0,
        mainAxisSpacing: 0.0,
      ),
      itemCount: _feed!.items!.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      WebViewExample(_feed!.items![index].link!)),
            );
          },
          child: Card(
              margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
              elevation: 5,
              color: Colors.white,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2), 
                    color: Colors.white 
                    ),
                child: Column(
                  children: [
                    thumbnail(_feed!.items![index].enclosure!.url),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          _feed!.items![index].title!.length > 40
                              ? _feed!.items![index].title!.substring(0, 40) +
                                  "..."
                              : _feed!.items![index].title!,
                          style: TextStyle(fontSize: 13)),
                    )
                  ],
                ),
              )),
        );
        // child: ListTile(
        //   title: Text(_feed!.items![index].title!,
        //       style: TextStyle(fontSize: 13)),
        //   subtitle: Text("Haber Editörü: ${publishers[random.nextInt(8)]}",
        //       style: TextStyle(fontSize: 11)),
        //   leading: _feed!.items![index].enclosure!.url == null
        //       ? Container(
        //           height: 50,
        //           width: 90,
        //           decoration: BoxDecoration(
        //               image: DecorationImage(
        //                   fit: BoxFit.contain,
        //                   image: AssetImage('assets/empty_image.jpg'))))
        //       : thumbnail(_feed!.items![index].enclosure!.url),
        //   trailing: Icon(Icons.keyboard_arrow_right),
        //   contentPadding: EdgeInsets.all(5.0),
        //   onTap: () {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //           builder: (context) =>
        //               WebViewExample(_feed!.items![index].link!)),
        //     );
        //   },
        // ));
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
          centerTitle: true,
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
