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

export interface SheetIosProps {
  /**
   * Present the Sheet IOS. recommend to use useState of this boolean variable.
   */
  present: boolean;
  /**
   * Style to the Sheet, better to implement the style in the children component.
   */
  style?: ViewStyle;
  /**
   * Show a native "X" button via SFSymbol.
   */
  cancelButton?: boolean;
  /**
   * Callback of dismiss Sheet, called when gusture down or any button action.
   */
  onDismissSheet: () => void;
  /**
   * Show a close button native, this will override the "X" button if both of them are true
   */
  showCloseButton?: boolean;
  /**
   * Present half sheet, only works in IOS 16.
   */
  halfSheet?: boolean;
  /**
   * Color of the "X" button, refer only hex string without #
   */
  closeButtonColor?: string;
  /**
   * Children of the screen.
   */
  children: React.ReactNode;
}

const ComponentName = 'SheetIosView';

export const SheetIosView =
  UIManager.getViewManagerConfig(ComponentName) != null && Platform.OS === 'ios'
    ? requireNativeComponent<SheetIosProps>(ComponentName)
    : () => {
        throw new Error(LINKING_ERROR);
      };
