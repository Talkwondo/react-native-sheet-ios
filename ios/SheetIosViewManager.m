#import <React/RCTViewManager.h>
#import <Foundation/Foundation.h>

@interface RCT_EXTERN_MODULE(SheetIosViewManager, RCTViewManager)

RCT_EXPORT_VIEW_PROPERTY(present, BOOL)
RCT_EXPORT_VIEW_PROPERTY(component, RCTView)
RCT_EXPORT_VIEW_PROPERTY(showCloseButton, BOOL)
RCT_EXPORT_VIEW_PROPERTY(cancelButton, BOOL)
RCT_EXPORT_VIEW_PROPERTY(halfSheet, BOOL)
RCT_EXPORT_VIEW_PROPERTY(closeButtonColor, NSString)
RCT_EXPORT_VIEW_PROPERTY(onDismissSheet, RCTDirectEventBlock)

@end
