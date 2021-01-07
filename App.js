import { StatusBar } from "expo-status-bar";
import React, { useEffect, useState } from "react";
import { createStore } from "redux";
import { Provider, useDispatch } from "react-redux";

import * as Font from "expo-font";
import AppLoading from "expo-app-loading";

import AppContainer from "./navigation/Navigator";
import { actions, reducer } from "./store/store";
import { fetchEpisodeList, fetchNewsFeeds, fetchQuoteURL } from "./fetch";

const store = createStore(reducer);

function App() {
  const dispatch = useDispatch();
  const [fontsLoaded, setFontsLoaded] = useState(false);

  useEffect(() => {
    if (fontsLoaded) {
      fetchNewsFeeds().then((res) => dispatch(actions.fetchNews(res)));
      fetchQuoteURL().then((url) => dispatch(actions.fetchQuote(url)));
      fetchEpisodeList().then((list) => dispatch(actions.fetchEpisodes(list)));
    } else {
      Font.loadAsync({
        "open-sans": require("./assets/fonts/OpenSans-Regular.ttf"),
        "open-sans-semibold": require("./assets/fonts/OpenSans-SemiBold.ttf"),
        "open-sans-bold": require("./assets/fonts/OpenSans-Bold.ttf"),
      }).then(() => {
        setFontsLoaded(true);
      });
    }
  }, [fontsLoaded]);

  if (!fontsLoaded) {
    return <AppLoading />;
  }

  return (
    <>
      <AppContainer />
      <StatusBar style="light" />
    </>
  );
}

export default function Main() {
  return (
    <Provider store={store}>
      <App />
    </Provider>
  );
}
