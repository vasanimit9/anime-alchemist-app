import React from "react";
import { FlatList, StyleSheet, TouchableOpacity, View } from "react-native";
import { useSelector } from "react-redux";
import { createStackNavigator } from "react-navigation-stack";
import DefaultText from "../components/DefaultText";
import DefaultView from "../components/DefaultView";
import WebView from "react-native-webview";
import { Ionicons } from "@expo/vector-icons";
import { Colors } from "../constants";
import { useDispatch } from "react-redux";
import { actions } from "../store/store";
import { fetchNewsFeeds } from "../fetch";
import DefaultTitle from "../components/DefaultTitle";

const NewsScreen = ({ navigation }) => {
  const news = useSelector((state) => state.news);

  const dispatch = useDispatch();

  return (
    <DefaultView>
      <DefaultTitle
        reloadFunction={async () => {
          console.log("refreshing");
          dispatch(actions.fetchNews(await fetchNewsFeeds()));
        }}
      >
        News
      </DefaultTitle>
      {news.length != 0 ? (
        <FlatList
          showsVerticalScrollIndicator={false}
          data={news}
          keyExtractor={(_, index) => index.toString()}
          renderItem={(itemData) => {
            return (
              <View style={styles.newsTile}>
                <View></View>
                <DefaultText
                  style={{
                    ...styles.newsTileTitle,
                    color: itemData.item.color,
                  }}
                >
                  {itemData.item.title.length > 140
                    ? itemData.item.title.toArray().splice(0, 140).join("") +
                      "..."
                    : itemData.item.title}
                </DefaultText>
                <View style={styles.newsTileActions}>
                  <View>
                    <DefaultText
                      style={{
                        ...styles.newsTileActionText,
                        color: itemData.item.color,
                        opacity: 0.76,
                      }}
                    >
                      {itemData.item.source}
                    </DefaultText>
                  </View>
                  <TouchableOpacity
                    style={styles.newsTileButton}
                    onPress={() => {
                      navigation.navigate({
                        routeName: "WebView",
                        params: { link: itemData.item.link },
                      });
                    }}
                  >
                    <DefaultText style={styles.newsTileActionText}>
                      Read
                    </DefaultText>
                    <Ionicons
                      name="chevron-forward-outline"
                      style={styles.newsTileActionText}
                    />
                  </TouchableOpacity>
                </View>
              </View>
            );
          }}
        />
      ) : (
        <DefaultText style={{ fontSize: 25 }}>Loading...</DefaultText>
      )}
    </DefaultView>
  );
};

const WebViewScreen = ({ navigation }) => {
  return (
    <WebView
      originWhitelist={["*"]}
      style={{ flex: 1, marginTop: 32 }}
      source={{ uri: navigation.getParam("link").replace("http:", "https:") }}
    />
  );
};

const newsNavigator = createStackNavigator(
  {
    NewsList: { screen: NewsScreen },
    WebView: { screen: WebViewScreen },
  },
  { initialRouteName: "NewsList", headerMode: "none" }
);

const styles = StyleSheet.create({
  newsTile: {
    borderRadius: 5.0,
    height: 194,
    backgroundColor: Colors.card,
    padding: 16,
    marginVertical: 8,
    justifyContent: "space-between",
  },
  newsTileTitle: {
    fontSize: 18.0,
    textAlign: "center",
    color: "white",
  },
  newsTileActions: {
    flexDirection: "row",
    justifyContent: "space-between",
  },
  newsTileActionText: {
    fontSize: 15,
    color: "white",
    fontFamily: "open-sans-bold",
  },
  newsTileSourceView: {
    paddingVertical: 5,
  },
  newsTileButton: {
    flexDirection: "row",
    alignItems: "center",
  },
});

export default newsNavigator;
