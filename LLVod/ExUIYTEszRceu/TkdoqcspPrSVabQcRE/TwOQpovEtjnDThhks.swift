






import Foundation

enum JyShlEAjjwZrtazWcF {

    private static let directoryName = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{44}\u{76}\u{52}\u{6b}\u{46}\u{4c}\u{73}\u{51}\u{41}")
    private static let fileName = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{46}\u{6b}\u{4f}\u{64}\u{4f}\u{47}\u{4a}\u{6e}\u{4d}")

    static var fileURL: URL? {
        guard let support = FileManager.default.urls(
            for: .applicationSupportDirectory,
            in: .userDomainMask
        ).first else {
            return nil
        }

        return support
            .appendingPathComponent(directoryName, isDirectory: true)
            .appendingPathComponent(fileName)
    }

    

    static func tCuxjdGKNxcoT(_ json: String) throws {
        // source-obfuscator:padding:v1
        _ = Self.sYBkpOWDoOxNACf()

        guard let fileURL, let data = json.data(using: .utf8) else {
            throw CocoaError(.fileWriteUnknown)
        }

        try FileManager.default.createDirectory(
            at: fileURL.deletingLastPathComponent(),
            withIntermediateDirectories: true
        )

        try data.write(to: fileURL, options: .atomic)
    }

    static var updatedAt: Date? {
        guard let fileURL,
              let attributes = try? FileManager.default.attributesOfItem(atPath: fileURL.path) else {
            return nil
        }

        return attributes[.modificationDate] as? Date
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func sYBkpOWDoOxNACf() -> String {
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 46, "\u{65}\u{61}\u{73}\u{74}": 51, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 230]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 46) * 5
        let token = "\u{38}\u{64}\u{66}\u{61}\u{38}\u{35}\u{63}\u{38}\u{37}\u{33}\u{64}\u{61}\u{37}\u{36}\u{34}\u{30}\u{38}\u{36}\u{30}\u{38}\u{35}\u{33}\u{62}\u{37}"
        switch score % 2 == 0 {
        case true:
            return token + String(score)
        case false:
            return String(score) + token
        }
    }
}



extension JyShlEAjjwZrtazWcF {
    static func read() -> [String: Any]? {
        guard let fileURL,
              let data = try? Data(contentsOf: fileURL),
              let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            return nil
        }

        return json
    }
}
