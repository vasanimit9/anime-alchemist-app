import React from "react";
import { StyleSheet, TouchableOpacity, View } from "react-native";
import { Ionicons } from "@expo/vector-icons";
import DefaultText from "../components/DefaultText";
import { Colors } from "../constants";

const DefaultTitle = ({ children, reloadFunction }) => {
  return (
    <View style={styles.Container}>
      <View>
        <DefaultText style={styles.title}>{children}</DefaultText>
      </View>
      {reloadFunction ? (
        <TouchableOpacity onPress={reloadFunction}>
          <Ionicons name="ios-refresh" color={Colors.defaultText} size={25} />
        </TouchableOpacity>
      ) : null}
    </View>
  );
};

const styles = StyleSheet.create({
  Container: {
    height: 48.0,
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "space-between",
    paddingTop: 8,
  },
  title: {
    fontSize: 25,
  },
});

export default DefaultTitle;
