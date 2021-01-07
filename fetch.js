import * as rssParser from "react-native-rss-parser";

import { NewsFeeds, quoteAddressFetchURL, scheduleURL } from "./constants";

export const fetchNewsFeeds = async () => {
  let output = [];
  for (let i = 0; i < NewsFeeds.length; i++) {
    let fail = false;
    let el = fetch(NewsFeeds[i].feed)
      .then((response) => {
        return response.text();
      })
      .then((response) => rssParser.parse(response))
      .catch((err) => {
        console.error(err);
        fail = true;
      });
    let feed = await el;
    if (fail) {
      continue;
    }
    for (let m = 0; m < feed.items.length; m++) {
      output.push({
        source: NewsFeeds[i].name,
        homepage: NewsFeeds[i].homepage,
        title: feed.items[m].title,
        published: new Date(feed.items[m].published).getTime(),
        link: feed.items[m].links[0].url,
        color: NewsFeeds[i].color,
      });
    }
  }

  for (let i = 0; i < output.length; i++) {
    for (let j = 0; j < i; j++) {
      if (output[i].published > output[j].published) {
        [output[i], output[j]] = [output[j], output[i]];
      }
    }
  }

  return output;
};

export const fetchQuoteURL = () => {
  return fetch(quoteAddressFetchURL)
    .then((response) => response.text())
    .catch(console.error);
};

export const fetchEpisodeList = async () => {
  let output = [];
  let feed = await fetch(scheduleURL)
    .then((response) => response.text())
    .then((data) => rssParser.parse(data))
    .catch(console.error);
  for (let i = 0; i < feed.items.length; i++) {
    let dt = new Date(feed.items[i].published);
    output.push({
      title: feed.items[i].title,
      image: feed.items[i].enclosures[0].url,
      since:
        dt.toDateString().split(" ").splice(1, 3).join(" ") +
        " " +
        dt.toTimeString().split(" ")[0] +
        " " +
        dt.toTimeString().split(" ")[2],
    });
  }
  return output;
};
