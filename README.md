# react-native-sheet-ios

make an ios sheet to show additional information on top of the current screen.

## Installation

```sh
npm install react-native-sheet-ios
cd ios && pod install
```

## Usage
The library only works for IOS and min version 13, please make a condition otherwise fatal error may occur.
all props works, TS will be add soon.
The view inside the sheet is a child component, styles should be written there.

```js
import { SheetIosView } from "react-native-sheet-ios";

// ...
const [present, setPresent] = React.useState(false);

<SheetIosView
    presnetSheet={present} 
    onDismissSheet={() => setPresent(!present)} // callback when dismissed
    showCloseButton // can be hidden
    closeButtonColor={'000080'} // hex color only!
  >
    <ChildComponent />
  </SheetIosView>
```

## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow.

## License

MIT

---

Made with [create-react-native-library](https://github.com/callstack/react-native-builder-bob)
