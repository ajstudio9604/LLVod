




import Foundation

struct ByStGTmBwKVJKNlH {
    let items: [EyDFcDrlWhFFRVgXi]
    let total: Int
}

protocol AHDouBanFilmListRepository {
    func films(playlistID: String, start: Int, count: Int) async throws -> ByStGTmBwKVJKNlH
}

struct NgQVVohpKzaOohBqvPG: AHDouBanFilmListRepository {

    private let session: URLSession
    private let decoder: JSONDecoder

    init(session: URLSession = .shared, decoder: JSONDecoder = JSONDecoder()) {
        // source-obfuscator:padding:v1
        _ = Self.uFKtOLRUkXvmcV()

        self.session = session
        self.decoder = decoder
    }

    

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func uFKtOLRUkXvmcV() -> String {
        let token = "\u{30}\u{34}\u{37}\u{65}\u{39}\u{36}\u{33}\u{32}\u{66}\u{39}\u{33}\u{65}\u{33}\u{62}\u{30}\u{31}\u{63}\u{37}\u{36}\u{66}\u{62}\u{65}\u{34}\u{34}"
        let source = "\u{30}\u{34}\u{37}\u{65}\u{39}\u{36}\u{33}\u{32}\u{66}\u{39}\u{33}\u{65}\u{33}\u{62}\u{30}\u{31}\u{63}\u{37}\u{36}\u{66}\u{62}\u{65}\u{34}\u{34}\u{2d}\u{34}\u{34}"
        let checksum = source.unicodeScalars.reduce(0) { ($0 * 33 + Int($1.value)) % 997 }
        let base = checksum
        let width = (base) % 17
        let score = (width + 44) * 2
        let pieces = [token, String(score % 23)]
        if width > 4 { return pieces.joined(separator: "\u{2d}") }
        return pieces.joined()
    }
}



extension NgQVVohpKzaOohBqvPG {
    func films(playlistID: String, start: Int, count: Int) async throws -> ByStGTmBwKVJKNlH {
        let data = try await AniKjrmweMtR.zWmALwGqXcVdzUVhiFn(
            id: playlistID,
            isDoulist: !playlistID.isEmpty && playlistID.allSatisfy(\.isNumber),
            start: start,
            count: count,
            itemsOnly: "\u{31}",
            session: session
        )
        let response = try decoder.decode(OwccvjpSDejUHjnyOJL.self, from: data)
        let items = response.subjects.compactMap { subject -> EyDFcDrlWhFFRVgXi? in
            guard let title = subject.title, !title.isEmpty else { return nil }
            return EyDFcDrlWhFFRVgXi(
                title: title,
                subtitle: subject.displaySubtitle,
                imageURL: subject.posterURL
            )
        }
        return ByStGTmBwKVJKNlH(items: items, total: response.total ?? 0)
    }
}
