import {
  requireNativeComponent,
  UIManager,
  Platform,
  type ViewStyle,
} from 'react-native';

const LINKING_ERROR =
  `The package 'react-native-sheet-ios' doesn't seem to be linked or you are using it with andorid device. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo Go\n' +
  '- You are running ios operation system';

type SheetIosProps = {
  present: boolean;
  style: ViewStyle;
  onDismissSheet: () => void;
  showCloseButton: boolean;
  halfSheet: boolean;
  closeButtonColor: string;
};

const ComponentName = 'SheetIosView';

export const SheetIosView =
  UIManager.getViewManagerConfig(ComponentName) != null && Platform.OS === 'ios'
    ? requireNativeComponent<SheetIosProps>(ComponentName)
    : () => {
        throw new Error(LINKING_ERROR);
      };
