import Flutter
import UIKit

public class SwiftTelesoftasxStoragePlugin: NSObject, FlutterPlugin {
    let repository: RepositoryProtocol
    
    init(_ repository :RepositoryProtocol) {
        self.repository = repository
    }
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let userDefaultsChannel = FlutterMethodChannel(name: "telesoftasx_general_storage", binaryMessenger: registrar.messenger())
        let userDefaultsRepository = UserDefaultsRepository()
        
        let keychainChannel = FlutterMethodChannel(name: "telesoftasx_secure_storage", binaryMessenger: registrar.messenger())
        let keychainRepository = KeychainRepository()
        
        if userDefaultsRepository.hasAppBeenLaunched() == false {
            keychainRepository.reset()
            userDefaultsRepository.setAppHasBeenLaunched()
        }
        
        registrar.addMethodCallDelegate(SwiftTelesoftasxStoragePlugin(keychainRepository), channel: keychainChannel)
        registrar.addMethodCallDelegate(SwiftTelesoftasxStoragePlugin(userDefaultsRepository), channel: userDefaultsChannel)
    }
    
    
    public func handle(_ methodCall: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let dict = methodCall.arguments as? [String: Any],
              let key = dict["key"] as? String else {
            result(flutterError(message: "failed to parse call arguments \(String(describing: methodCall.arguments)) for method \(methodCall.method)"))
            return
        }
        guard let method = RepositoryMethod(rawValue: methodCall.method) else {
            result(flutterError(message: "storage method call not supported: \(methodCall.method)"))
            return
        }
        switch method {
        case .put:
            result(handlePut(dict: dict, key: key))
            
        case .getString, .getBool, .getDouble, .getInt:
            result(handleGet(dict: dict, key: key, method: method))
        }
    }
    
    private func handlePut(dict: [String: Any], key: String) -> Any? {
        guard let object = dict["value"] else {
            return flutterError(message: "failed to parse `put` call dictionary \(dict)")
        }
        repository.put(object, for: key)
        return true
    }
    
    private func handleGet(dict: [String: Any], key: String, method: RepositoryMethod) -> Any? {
        guard let defaultValue = dict["defaultValue"] else {
            return flutterError(message: "failed to parse `get` call dictionary \(dict)")
        }
        return repository.get(forKey: key, method: method, defaultValue: defaultValue)
    }
}
