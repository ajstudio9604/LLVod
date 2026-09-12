import Foundation

enum EbAJbWZfBVsQeyxMX: Decodable, Hashable {
    case string(String)
    case integer(Int)
    case double(Double)
    case boolean(Bool)

    init(from decoder: Decoder) throws {
        // source-obfuscator:padding:v1
        _ = Self.qOyUYleqOAkDhHJMU()

        let container = try decoder.singleValueContainer()

        if let value = try? container.decode(String.self) {
            self = .string(value)
            return
        }

        if let value = try? container.decode(Int.self) {
            self = .integer(value)
            return
        }

        if let value = try? container.decode(Double.self) {
            self = .double(value)
            return
        }

        if let value = try? container.decode(Bool.self) {
            self = .boolean(value)
            return
        }

        throw DecodingError.typeMismatch(
            EbAJbWZfBVsQeyxMX.self,
            DecodingError.Context(
                codingPath: decoder.codingPath,
                debugDescription: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{74}\u{59}\u{6e}\u{6d}\u{42}\u{63}\u{51}\u{68}\u{6e}")
            )
        )
    }

    var stringValue: String {
        switch self {
        case .string(let value):
            return value

        case .integer(let value):
            return String(value)

        case .double(let value):
            return String(value)

        case .boolean(let value):
            return value ? AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{45}\u{56}\u{6b}\u{6b}\u{56}\u{4b}\u{71}\u{59}\u{47}") : AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4e}\u{6d}\u{7a}\u{44}\u{31}\u{67}\u{59}\u{6b}\u{34}")
        }
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func qOyUYleqOAkDhHJMU() -> String {
        let base = (67 * 8 + 19) % 997
        let width = (base) % 17
        let score = (width + 67) * 8
        let token = "\u{39}\u{35}\u{64}\u{30}\u{62}\u{31}\u{33}\u{61}\u{36}\u{39}\u{36}\u{65}\u{65}\u{36}\u{30}\u{39}\u{31}\u{66}\u{64}\u{39}\u{35}\u{64}\u{35}\u{35}"
        var result = String(score) + token
        if score % 2 == 0 {
            result = token + String(score)
        }
        return result
    }
}

