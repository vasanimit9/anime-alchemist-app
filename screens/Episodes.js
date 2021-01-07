import React from "react";
import { Dimensions, Image, StyleSheet, View } from "react-native";
import { FlatList } from "react-native-gesture-handler";
import { useDispatch, useSelector } from "react-redux";
import DefaultText from "../components/DefaultText";
import DefaultTitle from "../components/DefaultTitle";
import DefaultView from "../components/DefaultView";
import { Colors } from "../constants";
import { fetchEpisodeList } from "../fetch";
import { actions } from "../store/store";

const windowWidth = Dimensions.get("window").width;

const EpisodesScreen = ({}) => {
  const episodes = useSelector((state) => state.episodes);

  const dispatch = useDispatch();

  return (
    <DefaultView>
      <DefaultTitle
        reloadFunction={async () =>
          dispatch(actions.fetchEpisodes(await fetchEpisodeList()))
        }
      >
        Episodes
      </DefaultTitle>
      {episodes.length > 0 ? (
        <FlatList
          data={episodes}
          keyExtractor={(_, index) => index.toString()}
          renderItem={(itemData) => (
            <View style={styles.EpisodeTile}>
              <View style={styles.SeriesImageContainer}>
                {itemData.item.image.length > 0 ? (
                  <Image
                    source={{ uri: itemData.item.image }}
                    style={styles.SeriesImage}
                  />
                ) : (
                  <Image
                    style={styles.Logo}
                    source={require("../assets/anime_alchemist_logo.png")}
                  />
                )}
              </View>
              <View style={styles.EpisodeInfo}>
                <DefaultText style={styles.LiveChartDotMe}>
                  LiveChart.me
                </DefaultText>
                <DefaultText style={styles.EpisodeTitle}>
                  {itemData.item.title.split(" #")[0]}
                </DefaultText>
                <DefaultText style={styles.EpisodeTitle}>
                  #{itemData.item.title.split(" #")[1]}
                </DefaultText>
                <DefaultText style={styles.EpisodeTime}>
                  {itemData.item.since}
                </DefaultText>
              </View>
            </View>
          )}
        />
      ) : (
        <DefaultText style={{ fontSize: 25 }}>Loading...</DefaultText>
      )}
    </DefaultView>
  );
};

const styles = StyleSheet.create({
  EpisodeTile: {
    backgroundColor: Colors.card,
    flexDirection: "row",
    height: 195,
    marginVertical: 8,
    borderRadius: 5,
    overflow: "hidden",
  },
  SeriesImageContainer: {
    flex: 2,
  },
  EpisodeInfo: {
    flex: 3,
    justifyContent: "space-between",
    padding: 8,
  },
  SeriesImage: {
    height: "100%",
    width: "100%",
  },
  EpisodeTitle: {
    fontSize: 18,
    fontFamily: "open-sans-bold",
    textAlign: "center",
  },
  EpisodeTime: {
    textAlign: "center",
  },
  Logo: {
    width: "100%",
    height: "100%",
  },
  LiveChartDotMe: {
    textAlign: "center",
  },
});

export default EpisodesScreen;
