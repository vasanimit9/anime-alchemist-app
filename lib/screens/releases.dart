import 'package:flutter/material.dart';
import 'package:anime_alchemist/constants.dart';
import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;

class Releases extends StatefulWidget {
  static const route = '/releases';

  @override
  _ReleasesState createState() => _ReleasesState();
}

class _ReleasesState extends State<Releases> {
  List<RssItem> releases = [];

  Future fetchFeed(String feed) async {
    var response = await http.get(feed);
    if (response.statusCode == 200) {
      var feed = RssFeed.parse(response.body);
      return feed;
    } else {
      return null;
    }
  }

  Future fetchEpisodesFeed() async {
    RssFeed epfeed = await fetchFeed('https://www.livechart.me/feeds/episodes');
    setState(() {
      releases = epfeed.items;
    });
    print('Releases fetched.');
  }

  List<Widget> buildReleaseListView(List<RssItem> releases) {
    List<Widget> output = [];

    for (int i = 0; i < releases.length; i++) {
      var release = releases[i];
      String newUrl = release.media.thumbnails.first.url.replaceFirst(
        'style=small',
        'style=large',
      );

      output.add(
        ReleaseTile(newUrl: newUrl, release: release),
      );
    }

    output.add(SizedBox(
      height: 16.0,
    ));
    return output;
  }

  @override
  Widget build(BuildContext context) {
    ReleasesScreenArgs args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          'Releases',
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
                await fetchEpisodesFeed();
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
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListView(
            children: buildReleaseListView(args.releases),
          ),
        ),
      ),
    );
  }
}

class ReleaseTile extends StatelessWidget {
  const ReleaseTile({
    Key key,
    @required this.newUrl,
    @required this.release,
  }) : super(key: key);

  final String newUrl;
  final RssItem release;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Container(
        height: 215.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: CustomColors.fgColor,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 144.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    newUrl,
                  ),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5.0),
                  bottomLeft: Radius.circular(5.0),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(' '),
                    Text(
                      release.title.length > 70
                          ? release.title.substring(0, 70)
                          : release.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.w600,
                        fontSize: 18.0,
                        color: CustomColors.textColor,
                      ),
                    ),
                    Text(
                      DateTime.now()
                              .subtract(DateTime.now().timeZoneOffset)
                              .difference(release.pubDate)
                              .inHours
                              .toString() +
                          'h',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0,
                        color: CustomColors.textColor,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
