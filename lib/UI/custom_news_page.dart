import 'package:flutter/material.dart';
import 'package:t24haber/UI/news_detail.dart';
import 'package:t24haber/components/drawer.dart';
import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;

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
  /* List<Items> _searchfeed = []; */
  TextEditingController controller = TextEditingController();
  String? search;

  Future<RssFeed?> loadFeed(context) async {
    print("çalıştı");
    try {
      final client = http.Client();
      final response = await client.get(Uri.https(
          "t24.com.tr", "${widget.route == null ? "rss" : widget.route}"));
      print("$response my responseeeeeeee");
      return RssFeed.parse(response.body);
    } catch (e) {
      //
    }
    return null;
  }

  load(context) async {
    /* final CustomNewsPage args =
        ModalRoute.of(context)!.settings.arguments as CustomNewsPage; */
    loadFeed(context).then((result) {
      if (null == result || result.toString().isEmpty) {
        /* updateTitle(feedLoadErrorMsg); */
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
    /* if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView(); */
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
              title: Text(_feed!.items![index].title!),
              subtitle: Text(_feed!.items![index].pubDate == null
                  ? ""
                  : _feed!.items![index].pubDate.toString()),
              leading:
                  thumbnail(_feed!.items![index].enclosure!.url.toString()),
              /* trailing: Icon(Icons.keyboard_arrow_right), */
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

  @override
  Widget build(BuildContext context) {
    isFeedEmpty() {
      return null == _feed || null == _feed!.items;
    }

    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
          title: Text(
              "T24 ${widget.topic == null ? "Son Dakika Haberler" : widget.topic}")),
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
