import Combine
import Foundation

@MainActor
final class ChannelStore: ObservableObject {

    static let shared = ChannelStore()

    private let channelKey = "app_version"

    @Published private(set) var channel: String?

    private init() {
        restore()
    }

    func save(_ value: String) {
        guard isValid(value) else { return }
        channel = value
        UserDefaults.standard.set(value, forKey: channelKey)
    }

    func restore() {
        guard let value = UserDefaults.standard.string(forKey: channelKey) else {
            return
        }
        guard isValid(value) else {
            return
        }
        channel = value
    }

    func isValid(_ value: String) -> Bool {
        value.range(of: #"^[0-9]{3,}$"#, options: .regularExpression) != nil
    }
    
    func validateSuccess() -> Bool {
        (channel ?? "").range(of: #"^[0-9]{3,}$"#, options: .regularExpression) != nil
    }
}
