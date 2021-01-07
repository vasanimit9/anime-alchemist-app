import React from "react";
import { StyleSheet } from "react-native";
import { Text } from "react-native-elements";
import { Colors } from "../constants";

const DefaultText = (props) => {
  return (
    <Text {...props} style={{ ...styles.defaultText, ...props.style }}>
      {props.children}
    </Text>
  );
};

const styles = StyleSheet.create({
  defaultText: {
    color: Colors.defaultText,
    fontFamily: "open-sans-semibold",
  },
});

export default DefaultText;
