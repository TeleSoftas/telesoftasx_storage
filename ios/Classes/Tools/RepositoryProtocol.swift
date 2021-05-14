import Foundation
import SwiftKeychainWrapper
import Flutter

enum RepositoryMethod: String {
    case put = "put"
    case getString = "getString"
    case getBool = "getBool"
    case getDouble = "getDouble"
    case getInt = "getInt"
}

protocol RepositoryProtocol {
    func put<T>(_ value: T?, for key: String)
    func get<T>(forKey key: String, method: RepositoryMethod, defaultValue: T?) -> T?
}
