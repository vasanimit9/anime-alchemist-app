import 'package:anime_alchemist/screens/webview_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:anime_alchemist/constants.dart';
import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';

class News extends StatefulWidget {
  static const route = '/news';

  @override
  _NewsState createState() {
    return _NewsState();
  }
}

class _NewsState extends State<News> {
  List<RssItem> newsItems = [];
  List<String> sources = [];

  Future fetchFeed(String feed) async {
    var response = await http.get(feed);
    if (response.statusCode == 200) {
      var feed = RssFeed.parse(response.body);
      return feed;
    } else {
      return null;
    }
  }

  Future fetchNewsFeeds() async {
    newsItems = [];
    sources = [];
    for (int i = 0; i < NewsFeeds.feeds.length; i++) {
      var feed = await fetchFeed(NewsFeeds.feeds[i].feed);
      if (feed != null) {
        for (int j = 0; j < feed.items.length; j++) {
          newsItems.add(feed.items[j]);
          sources.add(NewsFeeds.feeds[i].provider);
        }
      }
    }
    for (int i = 0; i < newsItems.length; i++) {
      for (int j = 0; j <= i; j++) {
        if (newsItems[j].pubDate.isBefore(newsItems[i].pubDate)) {
          var swap = newsItems[i];
          newsItems[i] = newsItems[j];
          newsItems[j] = swap;

          var swapS = sources[i];
          sources[i] = sources[j];
          sources[j] = swapS;
        }
      }
    }
    setState(() {});
  }

  List<Widget> buildNewsFeed(
      List<RssItem> newsItems, List<String> sources, BuildContext context) {
    List<Widget> output = [];

    for (int i = 0; i < newsItems.length; i++) {
      output.add(
        FeedTile(context: context, newsItem: newsItems[i], source: sources[i]),
      );
    }

    output.add(SizedBox(
      height: 16.0,
    ));

    return output;
  }

  @override
  Widget build(BuildContext context) {
    if (newsItems.isEmpty) {
      NewsScreenArgs args = ModalRoute.of(context).settings.arguments;
      newsItems = args.newsItems;
      sources = args.sources;
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          'News',
          style: TextStyle(
            fontFamily: 'Open Sans',
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: GestureDetector(
              onTap: () async {
                await fetchNewsFeeds();
              },
              child: Row(
                children: [
                  Text(
                    'Refresh ',
                    style: TextStyle(
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.bold,
                      color: CustomColors.buttonColor,
                      fontSize: 16.0,
                    ),
                  ),
                  Icon(
                    Icons.refresh_rounded,
                    color: CustomColors.buttonColor,
                    size: 18.0,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(
          children: buildNewsFeed(newsItems, sources, context),
        ),
      ),
    );
  }
}

class FeedTile extends StatelessWidget {
  const FeedTile({
    Key key,
    @required this.newsItem,
    @required this.context,
    @required this.source,
  }) : super(key: key);

  final RssItem newsItem;
  final String source;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 16.0,
      ),
      child: Card(
        color: CustomColors.fgColor,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Container(
            height: 160.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(),
                Text(
                  (newsItem.title.length > 140
                      ? newsItem.title.substring(0, 139) + '...'
                      : newsItem.title),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: NewsFeeds.feeds
                        .singleWhere((element) => element.provider == source)
                        .color,
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w600,
                    fontSize: 18.0,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      source,
                      style: TextStyle(
                        fontFamily: 'Open Sans',
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: NewsFeeds.feeds
                            .singleWhere(
                                (element) => element.provider == source)
                            .color,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          WebViewScreen.route,
                          arguments: WebViewArgs(
                            provider: source,
                            title: newsItem.title,
                            url: newsItem.link,
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Text(
                            'Read',
                            style: TextStyle(
                              color: CustomColors.textColor,
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          Icon(CupertinoIcons.forward,
                              size: 18.0, color: CustomColors.textColor)
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
