import Foundation
import SwiftKeychainWrapper

final class KeychainRepository: RepositoryProtocol {
    // MARK: - Declarations
    private let keychain = KeychainWrapper.standard

    // MARK: - Methods -
    func reset() {
        keychain.removeAllKeys()
    }

    // MARK: - RepositoryProtocol
    func put<T>(_ value: T?, for key: String) {
        switch value {
        case .none, _ as NSNull:
            keychain.removeObject(forKey: key)
            
        case let bool as Bool:
            keychain.set(bool, forKey: key)
            
        case let string as String:
            keychain.set(string, forKey: key)
            
        case let double as Double:
            keychain.set(double, forKey: key)
            
        case let int as Int:
            keychain.set(int, forKey: key)
            
        default:
            fatalError("Storage type not supported")
        }
    }

    func get<T>(forKey key: String, method: RepositoryMethod, defaultValue: T?) -> T? {
        let result: Any?
        switch method {
        case .getString:
            result = keychain.string(forKey: key)
            
        case .getBool:
            result = keychain.bool(forKey: key)
            
        case .getDouble:
            result = keychain.double(forKey: key)
            
        case .getInt:
            result = keychain.integer(forKey: key)
            
        default:
            fatalError("RepositoryMethod value not handled: \(method)")
        }
        return result as? T ?? defaultValue
    }
}
