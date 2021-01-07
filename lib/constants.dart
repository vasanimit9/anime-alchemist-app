import 'package:flutter/material.dart';
import 'package:webfeed/webfeed.dart';

class CustomColors {
  static var bgColor = Color(0xff191c20);
  static var fgColor = Color(0xff495057);
  // static var fgColor = Colors.redAccent.shade200;
  static var textColor = Color(0xffffffff);
  static var buttonColor = Colors.blueAccent;
}

class CustomFeed {
  final String provider;
  final String feed;
  final String homepage;
  final Color color;

  CustomFeed({
    this.provider,
    this.homepage,
    this.feed,
    this.color,
  });
}

class NewsFeeds {
  static List<CustomFeed> feeds = [
    CustomFeed(
      provider: 'Anime News Network',
      homepage: 'https://www.animenewsnetwork.com',
      feed: 'https://www.animenewsnetwork.com/all/rss.xml',
      color: Colors.blue.shade200,
    ),
    CustomFeed(
      provider: "Honey's Anime",
      homepage: 'https://honeysanime.com',
      feed: 'https://honeysanime.com/feed/',
      color: Colors.yellow.shade200,
    ),
    CustomFeed(
      provider: 'All The Anime',
      homepage: 'https://blog.alltheanime.com',
      feed: 'https://blog.alltheanime.com/feed',
      color: Colors.red.shade200,
    ),
  ];
}

class WebViewArgs {
  String title, provider, url;
  WebViewArgs({this.title, this.provider, this.url}) {
    this.url = this.url.replaceFirst('http:', 'https:');
  }
}

class NewsScreenArgs {
  List<RssItem> newsItems;
  List<String> sources;
  NewsScreenArgs({this.newsItems, this.sources});
}

class ReleasesScreenArgs {
  List<RssItem> releases;
  ReleasesScreenArgs({this.releases});
}
