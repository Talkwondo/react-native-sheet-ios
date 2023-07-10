import Foundation
import SwiftUI

@objc(SheetIosViewManager)
class SheetIosViewManager: RCTViewManager {
    override func view() -> UIView! {
        return SheetIosView()
    }
    override static func requiresMainQueueSetup() -> Bool {
        return true
    }
}
@available(iOS 13.0, *)
struct ComponentView: UIViewRepresentable {
    var componentRender: UIView

    func makeUIView(context: Context) -> UIView {
        componentRender
    }

    func updateUIView(_ uiView: UIView, context: Context) {
    }
}

@available(iOS 13.0.0, *)
struct SheetIOSWrapper: View {
    @State var presentedSheet: Bool;
    var present: Bool;
    var showCloseButton: Bool
    var closeButtonColor: String
    var componentRender: UIView
    var onDismiss: () -> Void
    init(present: Bool, onDismiss: @escaping ()-> Void, closeButtonColor: String, showCloseButton: Bool, componentRender: UIView) {
        self.present = present
        self.presentedSheet = present
        self.onDismiss = onDismiss
        self.closeButtonColor = closeButtonColor
        self.showCloseButton = showCloseButton
        self.componentRender = componentRender
    }
    var body: some View {
        ZStack{}
            .sheet(isPresented: $presentedSheet, onDismiss: {
                onDismiss()
            }) {
                VStack {
                    if(showCloseButton) {
                        Button(action: {
                            presentedSheet.toggle()
                        }, label: {
                            Image(systemName: "xmark.circle.fill").resizable()
                                .foregroundColor(Color(hex: closeButtonColor))
                                .frame(width: 35, height: 35)
                        }).position(CGPoint(x: UIScreen.screenWidth-30, y: 30))
                    }
                    ComponentView(componentRender: componentRender)
                }.frame(width: UIScreen.screenWidth)
               

            }

    }
}

class SheetIosView: UIView {
    @objc var onDismissSheet: RCTDirectEventBlock?
    @objc var closeButtonColor: NSString = "000000"
    @objc var showCloseButton: Bool = false
    @objc var componentRender: UIView = UIView()
    @objc override func insertReactSubview(_ renderComponent: UIView!, at atIndex: Int) {
        componentRender = renderComponent
    }

    @objc public var presnetSheet: Bool = false {
        didSet {
            if #available(iOS 13.0.0, *) {
                let host = UIHostingController(rootView: SheetIOSWrapper(present: presnetSheet, onDismiss: onDismissEvent, closeButtonColor: closeButtonColor as String, showCloseButton: showCloseButton, componentRender: componentRender as UIView)).view
                
                host?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                
                view.addSubview(host!)
                
            } else {
                // Fallback on earlier versions //send error react native support
            }
            
        }
    }
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(view)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("coder error")
        
    }
    lazy var view: UIView = {
        let parent = UIView()
        parent.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return parent
    }()
    @objc func onDismissEvent(){
        if onDismissSheet != nil {
            onDismissSheet!([:])
        }
    }
}

extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}

@available(iOS 13.0, *)
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
