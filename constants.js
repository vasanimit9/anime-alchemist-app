export const Colors = {
  primary: "#e57373",
  background: "#181818",
  defaultText: "#9e9e9e",
  card: "#212121",
};

class NewsFeed {
  constructor({ name, homepage, feed, color }) {
    this.name = name;
    this.homepage = homepage;
    this.feed = feed;
    this.color = color;
  }
}

export const NewsFeeds = [
  new NewsFeed({
    name: "Anime News Network",
    homepage: "https://www.animenewsnetwork.com",
    feed: "https://www.animenewsnetwork.com/all/rss.xml",
    color: "#90caf9",
  }),
  new NewsFeed({
    name: "Honey's Anime",
    homepage: "https://honeysanime.com",
    feed: "https://honeysanime.com/feed/",
    color: "#fff59d",
  }),
  new NewsFeed({
    name: "All the Anime",
    homepage: "https://blog.alltheanime.com",
    feed: "https://blog.alltheanime.com/feed",
    color: "#b0bec5",
  }),
];

export const quoteAddressFetchURL =
  "https://animealchemist.pythonanywhere.com/quote";

export const scheduleURL = "https://www.livechart.me/feeds/episodes";
