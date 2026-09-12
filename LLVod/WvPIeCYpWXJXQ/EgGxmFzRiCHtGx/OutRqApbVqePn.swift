




import Foundation

protocol AHDouBanPlaylistRepository {
    func playlists(category: String, start: Int, count: Int) async throws -> [YxdUIQGhxKMxKzMYnmOS]
}

struct YxZptPWtUviymiNiKVx: AHDouBanPlaylistRepository {

    private let session: URLSession
    private let decoder: JSONDecoder

    init(session: URLSession = .shared, decoder: JSONDecoder = JSONDecoder()) {
        // source-obfuscator:padding:v1
        _ = Self.jWBUbXCvYNTfGoBoBWPp()

        self.session = session
        self.decoder = decoder
    }

    func playlists(category: String, start: Int, count: Int) async throws -> [YxdUIQGhxKMxKzMYnmOS] {
        let data = try await AniKjrmweMtR.playlists(
            category: category,
            start: start,
            count: count,
            session: session
        )
        let response = try decoder.decode(NddHyKhRMgaZRVYLS.self, from: data)
        return (response.data.first?.items ?? []).map {
            YxdUIQGhxKMxKzMYnmOS(
                id: $0.id,
                title: $0.title,
                coverURL: $0.coverURL ?? "",
                headerBgImage: $0.headerBgImage ?? "",
                itemsCount: $0.itemsCount ?? 0
            )
        }
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func jWBUbXCvYNTfGoBoBWPp() -> String {
        let token = "\u{38}\u{61}\u{34}\u{36}\u{62}\u{30}\u{63}\u{63}\u{31}\u{30}\u{61}\u{37}\u{65}\u{66}\u{66}\u{63}\u{63}\u{31}\u{30}\u{66}\u{36}\u{37}\u{31}\u{64}"
        let base = (74 * 6 + 19) % 997
        let width = (base) % 17
        let score = (width + 74) * 6
        if score > 24 { return String(token.prefix(12)) + String(score % 31) }
        return token + "\u{2d}" + String(score)
    }
}

