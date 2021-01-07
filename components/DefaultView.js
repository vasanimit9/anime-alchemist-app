import React from "react";
import { StyleSheet, View } from "react-native";
import { Colors } from "../constants";

const DefaultView = (props) => {
  return (
    <View style={{ ...styles.defaultView, ...props.style }}>
      {props.children}
    </View>
  );
};

const styles = StyleSheet.create({
  defaultView: {
    backgroundColor: Colors.background,
    flex: 1,

    paddingHorizontal: 16.0,
    paddingTop: 32.0,
  },
});

export default DefaultView;
