import Flutter
import UIKit

public class EnvNativePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
      let channel = FlutterMethodChannel(name: "penf00k.ru/env_native", binaryMessenger: registrar.messenger())
    let instance = EnvNativePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
      self.handleMethod(call, result)
    }

      private func handleMethod(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
          switch call.method {
          case "getString":
              getString(call, result)
          case "getInt":
              getInt(call, result)
          default:
              result(FlutterMethodNotImplemented)
          }
      }

      private func getString(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
          guard let key = call.arguments as? String else {
              result(FlutterError.init(
                  code: "flutter_channel",
                  message: "you must provide key",
                  details: nil
              ))
              return
          }

          guard let res = Bundle.main.object(forInfoDictionaryKey: key) as? String else {
              result(FlutterError.init(
                  code: "flutter_channel",
                  message: "no such string variable \(key)",
                  details: nil
              ))
              return
          }

          result(res)
      }

      private func getInt(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
          guard let key = call.arguments as? String else {
              result(FlutterError.init(
                  code: "flutter_channel",
                  message: "you must provide key",
                  details: nil
              ))
              return
          }

          guard let res = Bundle.main.object(forInfoDictionaryKey: key) as? String else {
              result(FlutterError.init(
                  code: "flutter_channel",
                  message: "no such int variable \(key)",
                  details: nil
              ))
              return
          }

          guard let intRes = Int(res) else {
              result(FlutterError.init(
                  code: "flutter_channel",
                  message: "variable '\(res)' for key '\(key)' can not be cast to int",
                  details: nil
              ))
              return
          }

          result(intRes)
      }
}
