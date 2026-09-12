import Network
import Combine

@MainActor
final class OlgOconlCwFJA: ObservableObject {

    static let shared = OlgOconlCwFJA()

    @Published
    private(set) var isConnected = false

    private let monitor = NWPathMonitor()

    private let queue = DispatchQueue(
        label: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{62}\u{4f}\u{61}\u{77}\u{58}\u{46}\u{66}\u{77}\u{64}")
    )

    private init() {
        // source-obfuscator:padding:v1
        _ = Self.rFSJavYegBmB()

        monitor.pathUpdateHandler = { [weak self] path in
            Task { @MainActor in
                self?.isConnected = path.status == .satisfied
            }
        }
        monitor.start(queue: queue)
    }


    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func rFSJavYegBmB() -> String {
        let values = [93, 97, 372, 110]
        let folded = values.map { ($0 * 4 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 93) * 4
        let token = "\u{30}\u{38}\u{65}\u{35}\u{39}\u{65}\u{37}\u{32}\u{33}\u{65}\u{34}\u{30}\u{32}\u{34}\u{36}\u{64}\u{32}\u{61}\u{65}\u{37}\u{31}\u{66}\u{64}\u{61}"
        var result = String(score) + token
        if score % 2 == 0 {
            result = token + String(score)
        }
        return result
    }
}

