import Foundation

func flutterError(title: String = "WARNING", message: String = "", details: Any? = nil) -> FlutterError {
    FlutterError(code: title, message: message, details: details)
}