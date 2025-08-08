// ios/Classes/SwiftHapticPlugin.swift
import Flutter
import UIKit

public class HapticsPlugin: NSObject, FlutterPlugin {

  // A private struct to hold all string constants. This avoids "magic strings"
  // and makes the code robust, self-documenting, and easy to maintain.
  private struct Constants {
    static let channelName = "com.surf/haptics"

    struct Methods {
      static let initMethod = "init"
      static let disposeMethod = "dispose"
      static let impact = "impact"
      static let notification = "notification"
      static let selection = "selection"
      static let feedback = "feedback"
    }

    struct Keys {
      static let style = "style"
      static let type = "type"
    }

    struct Impact {
      static let light = "light"
      static let medium = "medium"
      static let heavy = "heavy"
      static let soft = "soft"
      static let rigid = "rigid"
    }

    struct Notification {
      static let success = "success"
      static let warning = "warning"
      static let error = "error"
    }

    struct Feedback {
      static let contextClick = "contextClick"
      static let dragStart = "dragStart"
      static let gestureEnd = "gestureEnd"
      static let gestureStart = "gestureStart"
      static let textHandleMove = "textHandleMove"
      static let virtualKeyRelease = "virtualKeyRelease"
    }
  }


  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(
      name: Constants.channelName, binaryMessenger: registrar.messenger())
    let instance = HapticsPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case Constants.Methods.initMethod:
      result(nil)
    case Constants.Methods.disposeMethod:
      result(nil)
    case Constants.Methods.impact:
      guard let style = extractStringArgument(from: call, withKey: Constants.Keys.style) else {
        result(createInvalidArgumentError(withKey: Constants.Keys.style))
        return
      }
      triggerImpact(style: style)
      result(nil)

    case Constants.Methods.notification:
      guard let type = extractStringArgument(from: call, withKey: Constants.Keys.type) else {
        result(createInvalidArgumentError(withKey: Constants.Keys.type))
        return
      }
      triggerNotification(type: type)
      result(nil)

    case Constants.Methods.selection:
      triggerSelection()
      result(nil)

    case Constants.Methods.feedback:
      guard let type = extractStringArgument(from: call, withKey: Constants.Keys.type) else {
        result(createInvalidArgumentError(withKey: Constants.Keys.type))
        return
      }
      triggerFeedback(type: type)
      result(nil)

    default:
      result(FlutterMethodNotImplemented)
    }
  }

  private func createInvalidArgumentError(withKey key: String) -> FlutterError {
    return FlutterError(
      code: "INVALID_ARGUMENT", message: "Argument \(key) is missing or invalid", details: nil)
  }


  // MARK: - Argument Extraction Helper

  private func extractStringArgument(from call: FlutterMethodCall, withKey key: String) -> String? {
    guard let args = call.arguments as? [String: Any], let value = args[key] as? String else {
      return nil
    }
    return value
  }

  // MARK: - Haptic Triggers

  private func triggerImpact(style: String) {
    let generator: UIImpactFeedbackGenerator

    switch style {
    case Constants.Impact.light:
      generator = UIImpactFeedbackGenerator(style: .light)
    case Constants.Impact.medium:
      generator = UIImpactFeedbackGenerator(style: .medium)
    case Constants.Impact.heavy:
      generator = UIImpactFeedbackGenerator(style: .heavy)
    case Constants.Impact.soft:
      if #available(iOS 13.0, *) {
        generator = UIImpactFeedbackGenerator(style: .soft)
      } else {
        return
      }
    case Constants.Impact.rigid:
      if #available(iOS 13.0, *) {
        generator = UIImpactFeedbackGenerator(style: .rigid)
      } else {
        return
      }
    default:
      return
    }
    generator.prepare()
    generator.impactOccurred()
  }

  private func triggerNotification(type: String) {
    let generator = UINotificationFeedbackGenerator()
    switch type {
    case Constants.Notification.success:
      generator.notificationOccurred(.success)
    case Constants.Notification.warning:
      generator.notificationOccurred(.warning)
    case Constants.Notification.error:
      generator.notificationOccurred(.error)
    default:
      return
    }
  }

  private func triggerSelection() {
    UISelectionFeedbackGenerator().selectionChanged()
  }

  private func triggerFeedback(type: String) {
    // These Android-specific feedback types are not implemented on iOS
    // They don't have equivalent system haptics, so we do nothing
    return
  }

}
