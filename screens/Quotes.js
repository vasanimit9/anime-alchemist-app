import React from "react";
import { Dimensions, Image, StyleSheet, View } from "react-native";
import DefaultView from "../components/DefaultView";
import DefaultTitle from "../components/DefaultTitle";
import { useDispatch, useSelector } from "react-redux";
import { fetchQuoteURL } from "../fetch";
import { actions } from "../store/store";

const windowWidth = Dimensions.get("window").width;

const QuotesScreen = ({}) => {
  const quoteURL = useSelector((state) => state.quote);

  const dispatch = useDispatch();

  return (
    <DefaultView>
      <DefaultTitle
        reloadFunction={async () => {
          let url = await fetchQuoteURL();
          console.log(url);
          dispatch(actions.fetchQuote(url));
        }}
      >
        Random Quote
      </DefaultTitle>
      <View style={styles.ImageContainer}>
        {quoteURL ? (
          <Image
            defaultSource={require("../assets/anime_alchemist_logo.png")}
            source={{ uri: quoteURL }}
            style={styles.Image}
          />
        ) : (
          <Image
            source={require("../assets/anime_alchemist_logo.png")}
            style={styles.Image}
          />
        )}
      </View>
    </DefaultView>
  );
};

const styles = StyleSheet.create({
  ImageContainer: {
    width: windowWidth - 24,
    height: windowWidth - 24,
    borderRadius: 5.0,
    overflow: "hidden",
    marginVertical: 16.0,
    alignSelf: "center",
  },
  Image: {
    width: "100%",
    height: "100%",
  },
});

export default QuotesScreen;
