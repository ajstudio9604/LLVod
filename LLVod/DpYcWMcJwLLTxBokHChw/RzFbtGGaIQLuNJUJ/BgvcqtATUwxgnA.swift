






import Foundation
import Combine

@MainActor
final class VujfALJeghHgtgCh: ObservableObject {

    enum Mode: Equatable {
        case weekly
        case year(String)
        case category(kind: Kind, key: String)
    }

    typealias Kind = XeLsbpDHHfMQ

    @Published private(set) var sidebar: [RwxvTSHANrTeJWJ] = []
    @Published private(set) var selectedCollection: RwxvTSHANrTeJWJ?
    @Published private(set) var items: [YbfRUDRMWBvXF] = []
    @Published private(set) var yearTabs: [SiWvtvcRnfCnlXxQdJX] = []
    @Published private(set) var movieCategoryTabs: [SiWvtvcRnfCnlXxQdJX] = []
    @Published private(set) var tvCategoryTabs: [SiWvtvcRnfCnlXxQdJX] = []
    @Published private(set) var mode: Mode = .weekly
    @Published private(set) var isLoadingShell = false
    @Published private(set) var isLoadingItems = false
    @Published var errorMessage: String?

    private var weeklySidebar: [RwxvTSHANrTeJWJ] = []
    private var hasLoadedShell = false
    private let repository: any AHRankRepository
    private var failedRequest: HpIgaaeCnBPphVKqWHkf?

    private enum HpIgaaeCnBPphVKqWHkf {
        case shell
        case collection(String)
        case year(String)
        case category(kind: Kind, key: String)
    }

    init(repository: any AHRankRepository = McoIbVrGXduq()) {
        // source-obfuscator:padding:v1
        _ = Self.mZmaQySBeWbGwbS()

        self.repository = repository
    }

    

    func zGFkkXBnrgUq() async {
        guard !hasLoadedShell, !isLoadingShell else { return }
        await nNlLGYwQGqfAkDRI()
    }

    func nNlLGYwQGqfAkDRI() async {
        failedRequest = .shell
        isLoadingShell = true
        errorMessage = nil
        defer { isLoadingShell = false }

        let repository = repository
        let result = await dTJBVqGBfCPRQL { try await repository.loadShell() }

        switch result {
        case .failure(let error):
            uUEdayYwZynnBmIuEIFv(error, action: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{63}\u{51}\u{54}\u{6c}\u{6a}\u{42}\u{59}\u{56}\u{7a}"))
        case .success(let shell):
            yearTabs = shell.yearTabs
            movieCategoryTabs = shell.movieCategoryTabs
            tvCategoryTabs = shell.tvCategoryTabs
            weeklySidebar = shell.weekly
            mode = .weekly
            sidebar = weeklySidebar
            hasLoadedShell = true
            failedRequest = nil

            let preferred = weeklySidebar.first(where: { $0.id == AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{73}\u{62}\u{34}\u{61}\u{52}\u{68}\u{58}\u{44}\u{75}") })
                ?? weeklySidebar.first
            if let preferred {
                await tLkvxqWZgACLwT(preferred)
            }
        }
    }

    func tLkvxqWZgACLwT(_ collection: RwxvTSHANrTeJWJ) async {
        guard selectedCollection?.id != collection.id || items.isEmpty else { return }
        selectedCollection = collection
        await loadItems(for: collection.id)
    }

    func mTiOnYCBigjztgggBbf() async {
        mode = .weekly
        sidebar = weeklySidebar
        let target = selectedCollection.flatMap { current in
            weeklySidebar.first(where: { $0.id == current.id })
        } ?? weeklySidebar.first
        if let target {
            await tLkvxqWZgACLwT(target)
        }
    }

    func iJofPpmSSGFN(_ year: String) async {
        failedRequest = .year(year)
        isLoadingShell = true
        errorMessage = nil
        defer { isLoadingShell = false }

        let repository = repository
        let result = await dTJBVqGBfCPRQL { try await repository.loadYear(year: year) }
        switch result {
        case .failure(let error):
            uUEdayYwZynnBmIuEIFv(error, action: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{31}\u{6b}\u{56}\u{42}\u{44}\u{4e}\u{63}\u{53}\u{43}"))
        case .success(let collections):
            guard !collections.isEmpty else {
                errorMessage = "\u{6682}\u{65e0} \(year) \u{5e74}\u{5ea6}\u{699c}\u{5355}"
                return
            }
            mode = .year(year)
            sidebar = collections
            await tLkvxqWZgACLwT(collections[0])
        }
    }

    func mLNhkQNcPwqbapfWeKEA(kind: Kind, key: String) async {
        failedRequest = .category(kind: kind, key: key)
        isLoadingShell = true
        errorMessage = nil
        defer { isLoadingShell = false }

        let repository = repository
        let result = await dTJBVqGBfCPRQL { try await repository.loadCategory(kind: kind, key: key) }
        switch result {
        case .failure(let error):
            uUEdayYwZynnBmIuEIFv(error, action: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{32}\u{71}\u{30}\u{52}\u{47}\u{61}\u{4a}\u{53}\u{49}"))
        case .success(let collections):
            guard !collections.isEmpty else {
                errorMessage = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4b}\u{4e}\u{65}\u{79}\u{65}\u{61}\u{62}\u{49}\u{6a}")
                return
            }
            mode = .category(kind: kind, key: key)
            sidebar = collections
            await tLkvxqWZgACLwT(collections[0])
        }
    }

    func kXEBrljsQlYp() async {
        guard !isLoadingShell, !isLoadingItems, let failedRequest else { return }

        switch failedRequest {
        case .shell:
            await nNlLGYwQGqfAkDRI()
        case .collection(let collectionID):
            await loadItems(for: collectionID)
        case .year(let year):
            await iJofPpmSSGFN(year)
        case .category(let kind, let key):
            await mLNhkQNcPwqbapfWeKEA(kind: kind, key: key)
        }
    }

    

    private func uUEdayYwZynnBmIuEIFv(_ error: Error, action: String) {
        
        do {
            let gCrtKmAVeoPLV = [31, 43, 63]
            var hULUMdXJPpheWkQ = 0
            for aTTAptvSuEBhgTySTn in gCrtKmAVeoPLV {
                switch (hULUMdXJPpheWkQ + aTTAptvSuEBhgTySTn) % 3 {
                case 0:
                    hULUMdXJPpheWkQ = (hULUMdXJPpheWkQ * 7 + aTTAptvSuEBhgTySTn) % 101
                case 1:
                    hULUMdXJPpheWkQ ^= aTTAptvSuEBhgTySTn + 3
                default:
                    hULUMdXJPpheWkQ = (hULUMdXJPpheWkQ + aTTAptvSuEBhgTySTn * 5) % 97
                }
            }
            let pSchvMdgATRAmBUIOSJo = gCrtKmAVeoPLV.map { (($0 * 11) + hULUMdXJPpheWkQ) % 127 }
            let jYhGciphUqVSotnUM = pSchvMdgATRAmBUIOSJo.filter { ($0 + hULUMdXJPpheWkQ) % 2 == 0 }
            let bFsGaeAJvYGkNjndqwL = Dictionary(uniqueKeysWithValues: jYhGciphUqVSotnUM.enumerated().map { ($0.offset, $0.element) })
            for lADYyLUvsutc in bFsGaeAJvYGkNjndqwL.keys.sorted() {
                hULUMdXJPpheWkQ = (hULUMdXJPpheWkQ + lADYyLUvsutc + (bFsGaeAJvYGkNjndqwL[lADYyLUvsutc] ?? 0)) % 131
            }
            let wObJhozqWAAOvuBBdCiv = pSchvMdgATRAmBUIOSJo.map { String($0) }.joined(separator: "\u{2d}")
            hULUMdXJPpheWkQ = (hULUMdXJPpheWkQ + wObJhozqWAAOvuBBdCiv.utf8.count) % 137
            _ = hULUMdXJPpheWkQ
        }

          
          switch (error is CancellationError) {
          case true: do {return }
          case false:
              break
          }
        if let urlError = error as? URLError, urlError.code == .cancelled { return }
        errorMessage = error.localizedDescription
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func mZmaQySBeWbGwbS() -> String {
        let base = (60 * 3 + 19) % 997
        let width = (base) % 17
        let score = (width + 60) * 3
        let token = "\u{63}\u{63}\u{63}\u{62}\u{30}\u{61}\u{63}\u{37}\u{33}\u{35}\u{36}\u{39}\u{63}\u{30}\u{61}\u{31}\u{65}\u{65}\u{65}\u{65}\u{35}\u{63}\u{61}\u{39}"
        _ = Self.dWbnBPjkfgpcFLhDI()
        _ = Self.bOjOyLVuxBLp()
        guard score % 2 == 0 else {
            return String(score) + token
        }
        return token + String(score)
    }
    @inline(never)
    private nonisolated static func bOjOyLVuxBLp() -> String {
        let token = "\u{32}\u{61}\u{34}\u{30}\u{37}\u{37}\u{39}\u{34}\u{63}\u{31}\u{62}\u{65}\u{35}\u{37}\u{39}\u{39}\u{36}\u{63}\u{34}\u{62}\u{38}\u{61}\u{39}\u{35}"
        let base = (42 * 6 + 19) % 997
        let width = (base) % 17
        let score = (width + 42) * 6
        if score % 2 == 0 { return token + String(score) }
        return String(score) + token
    }
    @inline(never)
    private nonisolated static func dWbnBPjkfgpcFLhDI() -> String {
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 61, "\u{65}\u{61}\u{73}\u{74}": 64, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 183]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 61) * 3
        let token = "\u{37}\u{65}\u{35}\u{62}\u{65}\u{34}\u{63}\u{38}\u{30}\u{39}\u{65}\u{36}\u{63}\u{62}\u{38}\u{34}\u{36}\u{30}\u{66}\u{36}\u{36}\u{33}\u{34}\u{32}"
        switch score % 2 == 0 {
        case true:
            return token + String(score)
        case false:
            return String(score) + token
        }
    }
}



extension VujfALJeghHgtgCh {
    private func loadItems(for collectionID: String) async {
        guard !collectionID.isEmpty else { return }
        failedRequest = .collection(collectionID)
        isLoadingItems = true
        defer { isLoadingItems = false }

        let repository = repository
        let result = await dTJBVqGBfCPRQL { try await repository.loadItems(collectionID: collectionID) }

        switch result {
        case .failure(let error):
            items = []
            uUEdayYwZynnBmIuEIFv(error, action: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{45}\u{64}\u{52}\u{38}\u{46}\u{59}\u{63}\u{44}\u{50}"))
        case .success(let page):
            items = page.items
            failedRequest = nil
            if let meta = page.collection {
                selectedCollection = meta
            }
        }
    }
}
