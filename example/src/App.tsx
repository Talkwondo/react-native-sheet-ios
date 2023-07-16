const React = require('react');
import { StyleSheet, View, Button, Text, Dimensions } from 'react-native';
import { SheetIosView } from 'react-native-sheet-ios';

const Sample = () => {
  return (
    <View style={styles.sampleContainer}>
      <Text style={styles.text}>This is a sample 1</Text>
    </View>
  );
};

export default function App(): JSX.Element {
  const [present, setPresent] = React.useState(false);
  return (
    <View style={styles.container}>
      <SheetIosView
        present={present}
        halfSheet
        cancelButton
        onDismissSheet={() => {
          setPresent(!present);
        }}
        showCloseButton
        closeButtonColor={'000080'}
      >
        <Sample />
      </SheetIosView>
      <Button
        onPress={() => setPresent(!present)}
        title="present Sheet"
        color={'black'}
      />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  box: {
    width: 60,
    height: 60,
    marginVertical: 20,
  },
  sampleContainer: {
    display: 'flex',
    width: Dimensions.get('screen').width,
  },
  text: {
    textAlign: 'center',
  },
});
