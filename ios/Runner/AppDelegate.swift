import Flutter
import UIKit
import GoogleMaps

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("AIzaSyBmhmNVQufGCy8Iruka77zE4C0Uq2YpDDI")

    let controller = window?.rootViewController as? FlutterViewController
    if let messenger = controller?.binaryMessenger {
      let channel = FlutterMethodChannel(name: "com.systmgulf.checkpoint/device_clock", binaryMessenger: messenger)
      channel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
        if call.method == "getClockSnapshot" {
          let uptimeMs = Int64(ProcessInfo.processInfo.systemUptime * 1000)
          var tv = timeval()
          var size = MemoryLayout<timeval>.size
          sysctlbyname("kern.boottime", &tv, &size, nil, 0)
          let bootId = "ios-boot-\(tv.tv_sec)"
          result([
            "monotonicMs": uptimeMs,
            "bootId": bootId
          ])
        } else {
          result(FlutterMethodNotImplemented)
        }
      }
    }

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
