import React from "react";
import { createAppContainer } from "react-navigation";
import { createBottomTabNavigator } from "react-navigation-tabs";
import { Ionicons, FontAwesome } from "@expo/vector-icons";
import EpisodesScreen from "../screens/Episodes";
import NewsScreen from "../screens/News";
import QuotesScreen from "../screens/Quotes";
import { Colors } from "../constants";

const iconSize = 23;

export const navigator = createBottomTabNavigator(
  {
    Quote: {
      screen: QuotesScreen,
      navigationOptions: {
        tabBarIcon: (tabInfo) => {
          return (
            <FontAwesome
              name="quote-left"
              size={iconSize}
              color={tabInfo.tintColor}
            />
          );
        },
      },
    },
    News: {
      screen: NewsScreen,
      navigationOptions: {
        tabBarIcon: (tabInfo) => {
          return (
            <Ionicons
              name="ios-newspaper"
              color={tabInfo.tintColor}
              size={iconSize}
            />
          );
        },
      },
    },
    Episodes: {
      screen: EpisodesScreen,
      navigationOptions: {
        tabBarIcon: (tabInfo) => {
          return (
            <Ionicons
              name="ios-time"
              color={tabInfo.tintColor}
              size={iconSize}
            />
          );
        },
      },
    },
  },
  {
    tabBarOptions: {
      activeTintColor: Colors.primary,
      activeBackgroundColor: Colors.background,
      inactiveTintColor: Colors.defaultText,
      inactiveBackgroundColor: Colors.background,
      labelStyle: {
        fontFamily: "open-sans-semibold",
        fontSize: 12,
      },
    },
    initialRouteName: "News",
  }
);

export default createAppContainer(navigator);
