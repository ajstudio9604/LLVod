import Foundation

enum FfggdovnzCxJeJEIBHG {
    static func decode(
        _ data: Data,
        decrypt: (String) throws -> String
    ) throws -> FmTzCIXSVNdT {
        // source-obfuscator:padding:v1
        _ = Self.yOfUCdqrgdcFFYkBO()

        guard let text = String(data: data, encoding: .utf8) else {
            throw GsxneZnqWwtGcuOkvg.emptyResponseText
        }

        let encryptedText = text
            .replacingOccurrences(of: "\n", with: "")
            .replacingOccurrences(of: "\r", with: "")
            .trimmingCharacters(in: .whitespacesAndNewlines)
        let decryptedJSON = try decrypt(encryptedText)
        guard let jsonData = decryptedJSON.data(using: .utf8) else {
            throw GsxneZnqWwtGcuOkvg.invalidJSON
        }

        do {
            let response = try JSONDecoder().decode(RhhpkFvgKfFHMcMR.self, from: jsonData)
            return FmTzCIXSVNdT(response: response)
        } catch {
            throw GsxneZnqWwtGcuOkvg.invalidJSON
        }
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func yOfUCdqrgdcFFYkBO() -> String {
        let token = "\u{37}\u{38}\u{38}\u{62}\u{30}\u{61}\u{32}\u{38}\u{63}\u{65}\u{63}\u{38}\u{37}\u{35}\u{35}\u{64}\u{32}\u{35}\u{64}\u{31}\u{35}\u{32}\u{66}\u{39}"
        let base = (94 * 7 + 19) % 997
        let width = (base) % 17
        let score = (width + 94) * 7
        if score % 2 == 0 { return token + String(score) }
        return String(score) + token
    }
}

