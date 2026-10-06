import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let result = super.application(application, didFinishLaunchingWithOptions: launchOptions)
    if let controller = window?.rootViewController as? FlutterViewController {
      registerGalleryChannel(messenger: controller.binaryMessenger)
    }
    return result
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
    if let messenger = (engineBridge.pluginRegistry as? FlutterPluginRegistry)?.registrar(forPlugin: "VhbcGalleryPlugin")?.messenger() {
      registerGalleryChannel(messenger: messenger)
    }
  }

  private func registerGalleryChannel(messenger: FlutterBinaryMessenger) {
    let channel = FlutterMethodChannel(name: "com.vhbc.broker/gallery", binaryMessenger: messenger)
    channel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
      if call.method == "saveImageToGallery" {
        var image: UIImage? = nil
        if let args = call.arguments as? [String: Any] {
          if let typedData = args["bytes"] as? FlutterStandardTypedData {
            image = UIImage(data: typedData.data)
          } else if let path = args["path"] as? String {
            image = UIImage(contentsOfFile: path)
          }
        }
        guard let validImage = image else {
          result(false)
          return
        }
        UIImageWriteToSavedPhotosAlbum(validImage, nil, nil, nil)
        result(true)
      } else if call.method == "openGallery" {
        if let url = URL(string: "photos-redirect://"), UIApplication.shared.canOpenURL(url) {
          UIApplication.shared.open(url, options: [:]) { success in
            result(success)
          }
        } else {
          result(false)
        }
      } else {
        result(FlutterMethodNotImplemented)
      }
    }
  }
}
