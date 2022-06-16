import Flutter
import UIKit

@available(iOS 14.0, *)
class FLPicker: NSObject, FlutterPlatformView {
    private var _view: UIView
    private var channel: FlutterMethodChannel?

    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger?
    ) {
        let argsDict = args as! Dictionary<String, Any>;
        let picker = MyPicker(frame: frame)
        if let itemsArr = argsDict["items"] as? Array<String> {
            picker.items = itemsArr
        }
        if let selectedIndex = argsDict["selectedIndex"] as? Int {
            picker.selectedIndex = selectedIndex
        }
        if let textColorStr = argsDict["textColor"] as? String {
            picker.button.setTitleColor(UIColor(hexString: textColorStr), for: .normal)
        }
        if let tintColorStr = argsDict["tintColor"] as? String {
            picker.button.setTitleColor(UIColor(hexString: tintColorStr), for: .highlighted)
        }
        if let backgroundColorStr = argsDict["backgroundColor"] as? String {
            picker.button.backgroundColor = UIColor(hexString: backgroundColorStr)
        }
        if let borderColorStr = argsDict["borderColor"] as? String {
            picker.button.layer.borderColor = UIColor(hexString: borderColorStr)?.cgColor
        }
        if let borderWidth = argsDict["borderWidth"] as? CGFloat {
            picker.button.layer.borderWidth = borderWidth
        }
        if let cornerRadius = argsDict["cornerRadius"] as? CGFloat {
            picker.button.layer.cornerRadius = cornerRadius
        }
        if let textAlignment = argsDict["textAlignment"] as? Int {
            switch(textAlignment) {
            case 1: picker.button.contentHorizontalAlignment = .left
            case 2: picker.button.contentHorizontalAlignment = .right
            default: picker.button.contentHorizontalAlignment = .center
            }
        }
        if let fontSize = argsDict["fontSize"] as? CGFloat {
            picker.button.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        }
        _view = picker
        channel = FlutterMethodChannel(name: "FLPicker/\(viewId)", binaryMessenger: messenger!);
        super.init()
        picker.onChanged = { [weak self] value in 
            self?.channel?.invokeMethod("onChanged", arguments: value)
        }
        channel?.setMethodCallHandler({ call, reault in
            if call.method == "setIndex" {
                (self._view as! MyPicker).selectedIndex = (call.arguments as? Int) ?? 0
            }
        })
    }

    func view() -> UIView {
        return _view
    }
}
