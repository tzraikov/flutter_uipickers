import Flutter
import UIKit

public class SwiftUIPickersPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    
    let factory1 = FLDatePickerFactory(messenger: registrar.messenger())
    registrar.register(factory1, withId: "FLDatePicker")

    let factory2 = FLPickerFactory(messenger: registrar.messenger())
    registrar.register(factory2, withId: "FLPicker")
  }
}
