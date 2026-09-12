






import Foundation
import Combine

@MainActor
final class CxxgcGvyONdjCPTIxO: ObservableObject {

    @Published private(set) var bannerData: [ErSPBUTeNwdkn] = []

    @Published private(set) var listData: [ErSPBUTeNwdkn] = []

    @Published private(set) var isLoading = false
    @Published var errorMessage: String?

    private var hasLoaded = false
    private var lastURL = ""

    private let service: CnihTLLzfVcSCaHRMWu

    init(session: URLSession = .shared) {
        // source-obfuscator:padding:v1
        _ = Self.uTGvHKpZQjMG()

        service = CnihTLLzfVcSCaHRMWu(session: session) { encryptedText in
            try QxmEAOwBLRLGNSse.aJgdGuxhMrCoUNSb(encryptedText, key: "\u{61}\u{68}\u{73}\u{70}\u{31}\u{32}\u{33}\u{34}\u{35}\u{36}\u{37}\u{38}\u{39}\u{30}\u{31}\u{32}")
        }
    }

    func zGFkkXBnrgUq(_ urlString: String) async {
        if hasLoaded, lastURL == urlString, !bannerData.isEmpty || !listData.isEmpty {
            return
        }
        await mSvTwoHzTQHjZFborUoz(urlString, force: false)
    }

    func mSvTwoHzTQHjZFborUoz(_ urlString: String) async {
        await mSvTwoHzTQHjZFborUoz(urlString, force: true)
    }

    private func mSvTwoHzTQHjZFborUoz(_ urlString: String, force: Bool) async {
        if !force, hasLoaded, lastURL == urlString { return }
        guard !isLoading else { return }

        isLoading = true
        errorMessage = nil

        let result = await dTJBVqGBfCPRQL {
            try await self.service.iJJnfQavIAizUtUCTn(urlString)
        }
        isLoading = false

        switch result {
        case .failure(let error):
            let finalError = (error as? SegVMgxaYBEke)?.fallbackError ?? error
            if finalError is CancellationError { return }
            if let urlError = finalError as? URLError, urlError.code == .cancelled { return }
            errorMessage = error.localizedDescription
            
        case .success(let page):
            bannerData = page.banner
            listData = page.list
            lastURL = urlString
            hasLoaded = true
        }
    }


    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func uTGvHKpZQjMG() -> String {
        let token = "\u{33}\u{39}\u{34}\u{65}\u{64}\u{31}\u{62}\u{37}\u{34}\u{61}\u{63}\u{62}\u{33}\u{34}\u{36}\u{30}\u{64}\u{31}\u{31}\u{65}\u{64}\u{31}\u{65}\u{35}"
        let fragments = ["\u{6d}\u{65}\u{61}\u{64}\u{6f}\u{77}", "\u{6f}\u{72}\u{62}\u{69}\u{74}", "\u{63}\u{69}\u{6e}\u{64}\u{65}\u{72}", "\u{38}\u{34}"]
        let joined = fragments.reversed().joined(separator: "\u{2d}")
        let base = joined.utf8.reduce(0) { ($0 * 31 + Int($1)) % 997 }
        let width = (base) % 17
        let score = (width + 84) * 4
        if score % 2 == 0 { return token + String(score) }
        return String(score) + token
    }
}

