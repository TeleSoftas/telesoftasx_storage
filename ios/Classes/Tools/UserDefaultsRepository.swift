import Foundation

final class UserDefaultsRepository: RepositoryProtocol {
    // MARK: - Constants
    private let kHasAppBeenLaunchedKey = "kHasAppBeenLaunchedKey"

    // MARK: - Declarations
    private let userDefaults = UserDefaults.standard

    // MARK: - Methods
    func hasAppBeenLaunched() -> Bool {
        userDefaults.bool(forKey: kHasAppBeenLaunchedKey)
    }

    func setAppHasBeenLaunched() {
        userDefaults.set(true, forKey: kHasAppBeenLaunchedKey)
    }

    // MARK: - RepositoryProtocol
    func put<T>(_ value: T?, for key: String) {
        userDefaults.set(value, forKey: key)
    }

    func get<T>(forKey key: String, method: RepositoryMethod, defaultValue: T?) -> T? {
        userDefaults.object(forKey: key) as? T ?? defaultValue
    }
}
