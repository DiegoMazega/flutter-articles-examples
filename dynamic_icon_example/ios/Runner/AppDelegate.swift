import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
    //Our channel name has update
    let appIconChannel = FlutterMethodChannel(
      name: "app.com.get.change.icon", binaryMessenger: controller.binaryMessenger)

    appIconChannel.setMethodCallHandler({
      [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
      if call.method == "changeIcon" {
        // function to make the change
       self?.changeAppIcon(call: call, result: result)
      } else {
       result(-1)
        return
      }
    })

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  private func changeAppIcon(call: FlutterMethodCall, result: FlutterResult) {
    // only work on > 10.3
    if #available(iOS 10.3, *) {
      guard UIApplication.shared.supportsAlternateIcons else {
        result(false)
        return
      }
      // recover name pass as argument
      guard let args = call.arguments as? [String : Any] else {return}
      let arguments: String = args["targetIcon"] as! String

      var iconName: String?

      // check the name of current icon
      if let currentIconName = UIApplication.shared.alternateIconName {
        iconName = currentIconName
      } else {
        iconName = "Normal"
      }
      // condition to not make the change twice
      if iconName == arguments {
        result(false)
        return
      }
      //Apply the new icon
      UIApplication.shared.setAlternateIconName(arguments)
      result(true)

    } else {
      result(false)
    }
  }

  private func getIcon(call: FlutterMethodCall, result: FlutterResult) {
    result(UIApplication.shared.alternateIconName)
  }
}
