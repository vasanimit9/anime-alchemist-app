import 'package:anime_alchemist/screens/news.dart';
import 'package:anime_alchemist/screens/releases.dart';
import 'package:anime_alchemist/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';

class Home extends StatefulWidget {
  static const route = '/';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<RssItem> newsItems = [];
  List<String> sources = [];
  List<RssItem> releases = [];
  bool newsLoaded = false;
  bool releasesLoaded = false;
  String quoteImage;

  Future<void> fetchQuote() async {
    var response =
        await http.get('https://animealchemist.pythonanywhere.com/quote');
    if (response.statusCode == 200) {
      setState(() {
        quoteImage = response.body.toString();
      });
    } else {
      return;
    }
  }

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
    setState(() {
      newsLoaded = true;
    });
  }

  Future fetchEpisodesFeed() async {
    RssFeed epfeed = await fetchFeed('https://www.livechart.me/feeds/episodes');
    setState(() {
      releases = epfeed.items;
      releasesLoaded = true;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchQuote();
    fetchEpisodesFeed();
    fetchNewsFeeds();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Center(
                    child: Container(
                      height: MediaQuery.of(context).size.width - 36.0,
                      width: MediaQuery.of(context).size.width - 36.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(3.0),
                        image: quoteImage == null
                            ? null
                            : DecorationImage(
                                image: NetworkImage(
                                  quoteImage,
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Expanded(
                  flex: 1,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: newsLoaded
                              ? () {
                                  Navigator.pushNamed(
                                    context,
                                    News.route,
                                    arguments: NewsScreenArgs(
                                      newsItems: newsItems,
                                      sources: sources,
                                    ),
                                  );
                                }
                              : () {},
                          child: Card(
                            color: CustomColors.fgColor,
                            child: Center(
                              child: Text(
                                newsLoaded ? 'News' : 'Loading...',
                                style: TextStyle(
                                  fontFamily: 'Open Sans',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 24.0,
                                  color: CustomColors.textColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Container(),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: releasesLoaded
                              ? () {
                                  Navigator.pushNamed(
                                    context,
                                    Releases.route,
                                    arguments: ReleasesScreenArgs(
                                      releases: releases,
                                    ),
                                  );
                                }
                              : () {},
                          child: Card(
                            color: CustomColors.fgColor,
                            child: Center(
                              child: Text(
                                releasesLoaded ? 'Releases' : 'Loading...',
                                style: TextStyle(
                                  fontFamily: 'Open Sans',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 24.0,
                                  color: CustomColors.textColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
