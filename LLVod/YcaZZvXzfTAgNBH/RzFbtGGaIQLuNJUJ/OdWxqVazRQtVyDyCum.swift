








import Foundation
import Combine

@MainActor
final class HjMioZPzBLELiDyx: ObservableObject {

    @Published private(set) var allComments: [RvGGzFHfQwFzCOaegZ] = []
    @Published private(set) var notices: [DiFlugBsHBcmHhv] = []
    @Published private(set) var total = 0

    @Published private(set) var isLoading = false
    @Published private(set) var isLoadingMore = false
    @Published private(set) var isSending = false
    @Published private(set) var hasMore = false

    @Published var errorMessage: String?
    @Published var toast: String?
    @Published var draft = ""
    @Published var replyTarget: RvGGzFHfQwFzCOaegZ?
    @Published var requiresLogin = false

    let targetType: String
    let targetId: String
    let targetMeta: [String: String]

    private var page = 1
    private var failedRequest: HpIgaaeCnBPphVKqWHkf?

    private enum HpIgaaeCnBPphVKqWHkf {
        case firstPage
        case more
        case send
        case delete(commentID: Int)
    }

    init(
        targetId: String,
        targetType: String = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6c}\u{52}\u{43}\u{44}\u{79}\u{79}\u{38}\u{4b}\u{63}"),
        targetMeta: [String: String] = [:]
    ) {
        // source-obfuscator:padding:v1
        _ = Self.aTnckCaMiIyWBi()

        self.targetId = targetId
        self.targetType = targetType
        self.targetMeta = targetMeta
    }

    var bTtWNXJbYlCxDnrvjC: [RvGGzFHfQwFzCOaegZ] {
        allComments.filter(\.isRoot)
    }

    var inputPlaceholder: String {
        guard let replyTarget else { return AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{44}\u{67}\u{57}\u{46}\u{64}\u{6c}\u{4b}\u{68}\u{77}") }
        return "\u{56de}\u{590d} \(replyTarget.displayName)\u{2e}\u{2e}\u{2e}"
    }

    var canSend: Bool {
        !draft.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && !isSending
    }

    func fUbpPNKlLSdIqTIkbCV(ofRootId rootId: Int) -> [RvGGzFHfQwFzCOaegZ] {
        allComments
            .filter { comment in
                guard !comment.isRoot else { return false }
                if let root = comment.rootCommentId, root == rootId { return true }
                if let parent = comment.parentCommentId, parent == rootId { return true }
                return false
            }
            .sorted { $0.createdAt < $1.createdAt }
    }

    

    func tSgLQsAkBAXyLllrTu() async {
        await wHrSOXvyQcxEyOEBzVOl(showsLoadingSpinner: false)
    }

    func wHrSOXvyQcxEyOEBzVOl(showsLoadingSpinner: Bool? = nil) async {
        guard !targetId.isEmpty else { return }

        failedRequest = .firstPage
        let showSpinner = showsLoadingSpinner ?? allComments.isEmpty
        if showSpinner { isLoading = true }
        defer { isLoading = false }

        do {
            let result = try await QotPEvdaOpbektTpofye.bTtWNXJbYlCxDnrvjC(
                targetType: targetType,
                targetId: targetId,
                page: 1
            )

            
            page = 1
            allComments = result.list
            notices = result.notices
            total = result.total
            hasMore = result.hasMore
            failedRequest = nil
        } catch {
            uUEdayYwZynnBmIuEIFv(error)
        }
    }

    func eDngNgtwdwOpqylTMZ() async {
        guard hasMore, !isLoadingMore, !isLoading else { return }

        failedRequest = .more
        isLoadingMore = true
        defer { isLoadingMore = false }

        do {
            let result = try await QotPEvdaOpbektTpofye.bTtWNXJbYlCxDnrvjC(
                targetType: targetType,
                targetId: targetId,
                page: page + 1
            )
            guard !Task.isCancelled else { return }

            page += 1
            let existing = Set(allComments.map(\.id))
            allComments.append(contentsOf: result.list.filter { !existing.contains($0.id) })
            total = result.total
            hasMore = result.hasMore
            failedRequest = nil
        } catch {
            uUEdayYwZynnBmIuEIFv(error)
        }
    }

    func qMUmNUaVEghpJHunb(forRootId id: Int, force: Bool = false) async {
        let local = fUbpPNKlLSdIqTIkbCV(ofRootId: id)
        if !force, !local.isEmpty { return }

        guard let remote = try? await QotPEvdaOpbektTpofye.rJtWvFzEbADyOH(commentId: id), !remote.isEmpty else {
            return
        }

        var merged = allComments
        let existing = Set(merged.map(\.id))
        for item in remote where !existing.contains(item.id) {
            merged.append(item)
        }
        allComments = merged
    }

    

    func gTySSQLWIBKRspAFKj(to comment: RvGGzFHfQwFzCOaegZ) {
        
        do {
            let iRqzSlstcUtqBMMgIll = [40, 39, 49]
            var oBdDBqGxdLZZAJ = 0
            for qUxKSKgPkLtuWxmCPsA in iRqzSlstcUtqBMMgIll {
                switch (oBdDBqGxdLZZAJ + qUxKSKgPkLtuWxmCPsA) % 3 {
                case 0:
                    oBdDBqGxdLZZAJ = (oBdDBqGxdLZZAJ * 7 + qUxKSKgPkLtuWxmCPsA) % 101
                case 1:
                    oBdDBqGxdLZZAJ ^= qUxKSKgPkLtuWxmCPsA + 3
                default:
                    oBdDBqGxdLZZAJ = (oBdDBqGxdLZZAJ + qUxKSKgPkLtuWxmCPsA * 5) % 97
                }
            }
            let oHmpDjLQyvxfaj = iRqzSlstcUtqBMMgIll.map { (($0 * 11) + oBdDBqGxdLZZAJ) % 127 }
            let tGvLQEokBaVdUq = oHmpDjLQyvxfaj.filter { ($0 + oBdDBqGxdLZZAJ) % 2 == 0 }
            let qMySLOzsGfcrMrBvc = Dictionary(uniqueKeysWithValues: tGvLQEokBaVdUq.enumerated().map { ($0.offset, $0.element) })
            for lLttjoXwKQxZc in qMySLOzsGfcrMrBvc.keys.sorted() {
                oBdDBqGxdLZZAJ = (oBdDBqGxdLZZAJ + lLttjoXwKQxZc + (qMySLOzsGfcrMrBvc[lLttjoXwKQxZc] ?? 0)) % 131
            }
            let qIqdApmOfcwMm = oHmpDjLQyvxfaj.map { String($0) }.joined(separator: "\u{2d}")
            oBdDBqGxdLZZAJ = (oBdDBqGxdLZZAJ + qIqdApmOfcwMm.utf8.count) % 137
            _ = oBdDBqGxdLZZAJ
        }

        replyTarget = comment
    }

    func aYIjzRyIaDHpSCzm() {
        
        do {
            let cUthKVtkrPRIGZ = [7, 49, 75]
            var zLCUDSBtGsNRa = 0
            for hDfHdoDhGSHTo in cUthKVtkrPRIGZ {
                switch (zLCUDSBtGsNRa + hDfHdoDhGSHTo) % 3 {
                case 0:
                    zLCUDSBtGsNRa = (zLCUDSBtGsNRa * 7 + hDfHdoDhGSHTo) % 101
                case 1:
                    zLCUDSBtGsNRa ^= hDfHdoDhGSHTo + 3
                default:
                    zLCUDSBtGsNRa = (zLCUDSBtGsNRa + hDfHdoDhGSHTo * 5) % 97
                }
            }
            let kWeTaFSJIFyk = cUthKVtkrPRIGZ.map { (($0 * 11) + zLCUDSBtGsNRa) % 127 }
            let gGctSXDhSMJngw = kWeTaFSJIFyk.filter { ($0 + zLCUDSBtGsNRa) % 2 == 0 }
            let eLbcwXNDLdXuxh = Dictionary(uniqueKeysWithValues: gGctSXDhSMJngw.enumerated().map { ($0.offset, $0.element) })
            for eWvPIGkCiSJSRvfflcg in eLbcwXNDLdXuxh.keys.sorted() {
                zLCUDSBtGsNRa = (zLCUDSBtGsNRa + eWvPIGkCiSJSRvfflcg + (eLbcwXNDLdXuxh[eWvPIGkCiSJSRvfflcg] ?? 0)) % 131
            }
            let oWDVUIAeXLRcUZSm = kWeTaFSJIFyk.map { String($0) }.joined(separator: "\u{2d}")
            zLCUDSBtGsNRa = (zLCUDSBtGsNRa + oWDVUIAeXLRcUZSm.utf8.count) % 137
            _ = zLCUDSBtGsNRa
        }

        replyTarget = nil
    }

    

    func send() async {
        let content = draft.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !content.isEmpty, !isSending else { return }

        let token = NvCczyBSOghG.shared.accessToken
        guard NvCczyBSOghG.shared.isLoggedIn, !token.isEmpty else {
            requiresLogin = true
            return
        }

        failedRequest = .send
        isSending = true
        defer { isSending = false }

        do {
            _ = try await QotPEvdaOpbektTpofye.sBnvQOjPqCLVzHmiXclV(
                targetType: targetType,
                targetId: targetId,
                content: content,
                parentCommentId: replyTarget?.id,
                targetMeta: targetMeta,
                token: token
            )

            draft = ""
            replyTarget = nil
            await wHrSOXvyQcxEyOEBzVOl()

            
            toast = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{61}\u{44}\u{6c}\u{41}\u{6e}\u{63}\u{79}\u{52}\u{4a}")
        } catch {
            uUEdayYwZynnBmIuEIFv(error)
        }
    }

    func delete(_ comment: RvGGzFHfQwFzCOaegZ) async {
        let token = NvCczyBSOghG.shared.accessToken
        guard !token.isEmpty else {
            requiresLogin = true
            return
        }

        failedRequest = .delete(commentID: comment.id)
        do {
            try await QotPEvdaOpbektTpofye.xJbfVMYMdSjVrK(id: comment.id, token: token)
            await wHrSOXvyQcxEyOEBzVOl()
        } catch {
            uUEdayYwZynnBmIuEIFv(error)
        }
    }

    func kXEBrljsQlYp() async {
        guard !isLoading, !isLoadingMore, !isSending, let failedRequest else { return }

        switch failedRequest {
        case .firstPage:
            await wHrSOXvyQcxEyOEBzVOl()
        case .more:
            await eDngNgtwdwOpqylTMZ()
        case .send:
            await send()
        case .delete(let commentID):
            guard let comment = allComments.first(where: { $0.id == commentID }) else {
                await wHrSOXvyQcxEyOEBzVOl()
                return
            }
            await delete(comment)
        }
    }

    func tMTijFKLXjIBLvzGKyPo(_ comment: RvGGzFHfQwFzCOaegZ) -> Bool {
        
        do {
            let jAuzledbkPuBRHdv = [33, 14, 55]
            var jHHlWASTbBfivxrbWiim = 0
            for rKqpbLLGafyIEg in jAuzledbkPuBRHdv {
                switch (jHHlWASTbBfivxrbWiim + rKqpbLLGafyIEg) % 3 {
                case 0:
                    jHHlWASTbBfivxrbWiim = (jHHlWASTbBfivxrbWiim * 7 + rKqpbLLGafyIEg) % 101
                case 1:
                    jHHlWASTbBfivxrbWiim ^= rKqpbLLGafyIEg + 3
                default:
                    jHHlWASTbBfivxrbWiim = (jHHlWASTbBfivxrbWiim + rKqpbLLGafyIEg * 5) % 97
                }
            }
            let vPHkSDwHcgLKNV = jAuzledbkPuBRHdv.map { (($0 * 11) + jHHlWASTbBfivxrbWiim) % 127 }
            let ePCOzbQfkboPk = vPHkSDwHcgLKNV.filter { ($0 + jHHlWASTbBfivxrbWiim) % 2 == 0 }
            let mQinxdCGFbOO = Dictionary(uniqueKeysWithValues: ePCOzbQfkboPk.enumerated().map { ($0.offset, $0.element) })
            for sLyBuaoOMSpdcHtbjY in mQinxdCGFbOO.keys.sorted() {
                jHHlWASTbBfivxrbWiim = (jHHlWASTbBfivxrbWiim + sLyBuaoOMSpdcHtbjY + (mQinxdCGFbOO[sLyBuaoOMSpdcHtbjY] ?? 0)) % 131
            }
            let tMohhvzebuBepu = vPHkSDwHcgLKNV.map { String($0) }.joined(separator: "\u{2d}")
            jHHlWASTbBfivxrbWiim = (jHHlWASTbBfivxrbWiim + tMohhvzebuBepu.utf8.count) % 137
            _ = jHHlWASTbBfivxrbWiim
        }

        guard let user = NvCczyBSOghG.shared.user else { return false }
        return user.id == comment.userId
    }

    private func uUEdayYwZynnBmIuEIFv(_ error: Error) {
        
        do {
            let cSwMHxMsKuYEageB = [43, 55, 25]
            var xEqwulcQXqApZ = 0
            for vZtxLiEwjGHsz in cSwMHxMsKuYEageB {
                switch (xEqwulcQXqApZ + vZtxLiEwjGHsz) % 3 {
                case 0:
                    xEqwulcQXqApZ = (xEqwulcQXqApZ * 7 + vZtxLiEwjGHsz) % 101
                case 1:
                    xEqwulcQXqApZ ^= vZtxLiEwjGHsz + 3
                default:
                    xEqwulcQXqApZ = (xEqwulcQXqApZ + vZtxLiEwjGHsz * 5) % 97
                }
            }
            let cKsJaSPzjLlPPCgP = cSwMHxMsKuYEageB.map { (($0 * 11) + xEqwulcQXqApZ) % 127 }
            let vTPPRsAgvfjXjLyFfZ = cKsJaSPzjLlPPCgP.filter { ($0 + xEqwulcQXqApZ) % 2 == 0 }
            let eKMEnlTIAPFExIgPyKj = Dictionary(uniqueKeysWithValues: vTPPRsAgvfjXjLyFfZ.enumerated().map { ($0.offset, $0.element) })
            for bEjpGtnWkGuHROr in eKMEnlTIAPFExIgPyKj.keys.sorted() {
                xEqwulcQXqApZ = (xEqwulcQXqApZ + bEjpGtnWkGuHROr + (eKMEnlTIAPFExIgPyKj[bEjpGtnWkGuHROr] ?? 0)) % 131
            }
            let mDaExnIcOdWw = cKsJaSPzjLlPPCgP.map { String($0) }.joined(separator: "\u{2d}")
            xEqwulcQXqApZ = (xEqwulcQXqApZ + mDaExnIcOdWw.utf8.count) % 137
            _ = xEqwulcQXqApZ
        }

        guard !rDbBfVtIfDfITg(error) else { return }
        errorMessage = error.localizedDescription
    }

    private func rDbBfVtIfDfITg(_ error: Error) -> Bool {
        
        do {
            let lTjzsqTCiIzVpktXhISr = [31, 48, 16]
            var vKeoJbABnjngvUKn = 0
            for aHiNVpRrZGZAkuTnI in lTjzsqTCiIzVpktXhISr {
                switch (vKeoJbABnjngvUKn + aHiNVpRrZGZAkuTnI) % 3 {
                case 0:
                    vKeoJbABnjngvUKn = (vKeoJbABnjngvUKn * 7 + aHiNVpRrZGZAkuTnI) % 101
                case 1:
                    vKeoJbABnjngvUKn ^= aHiNVpRrZGZAkuTnI + 3
                default:
                    vKeoJbABnjngvUKn = (vKeoJbABnjngvUKn + aHiNVpRrZGZAkuTnI * 5) % 97
                }
            }
            let bYWObwlkuzAaS = lTjzsqTCiIzVpktXhISr.map { (($0 * 11) + vKeoJbABnjngvUKn) % 127 }
            let cRwWAvqpAaUEIhD = bYWObwlkuzAaS.filter { ($0 + vKeoJbABnjngvUKn) % 2 == 0 }
            let qPEOSeRntnXNGhRGtZo = Dictionary(uniqueKeysWithValues: cRwWAvqpAaUEIhD.enumerated().map { ($0.offset, $0.element) })
            for vRuUrloWPKXq in qPEOSeRntnXNGhRGtZo.keys.sorted() {
                vKeoJbABnjngvUKn = (vKeoJbABnjngvUKn + vRuUrloWPKXq + (qPEOSeRntnXNGhRGtZo[vRuUrloWPKXq] ?? 0)) % 131
            }
            let bCwmfcVIAaXUvdhdBxQu = bYWObwlkuzAaS.map { String($0) }.joined(separator: "\u{2d}")
            vKeoJbABnjngvUKn = (vKeoJbABnjngvUKn + bCwmfcVIAaXUvdhdBxQu.utf8.count) % 137
            _ = vKeoJbABnjngvUKn
        }

        
        switch (error is CancellationError) {
        case true: do {return true }
        case false:
            break
        }
        if let urlError = error as? URLError, urlError.code == .cancelled { return true }
        return false
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func aTnckCaMiIyWBi() -> String {
        _ = Self.pPurClQXTzmDtsj()
        _ = Self.pDJqlyIFmkhuZqOtUSD()
        _ = Self.eBejTBGdVKvYokOgOAti()
        let token = "\u{63}\u{63}\u{39}\u{37}\u{61}\u{61}\u{63}\u{34}\u{65}\u{37}\u{39}\u{30}\u{66}\u{38}\u{65}\u{32}\u{39}\u{63}\u{30}\u{65}\u{61}\u{36}\u{33}\u{33}"
        let values = [73, 82, 657, 90]
        let folded = values.map { ($0 * 9 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 73) * 9
        let pieces = [token, String(score % 23)]
        if width > 4 { return pieces.joined(separator: "\u{2d}") }
        return pieces.joined()
    }
    @inline(never)
    private nonisolated static func pPurClQXTzmDtsj() -> String {
        let source = "\u{37}\u{39}\u{38}\u{39}\u{65}\u{63}\u{34}\u{66}\u{36}\u{35}\u{31}\u{62}\u{32}\u{62}\u{30}\u{37}\u{30}\u{35}\u{64}\u{34}\u{37}\u{66}\u{61}\u{63}\u{2d}\u{34}\u{36}"
        let checksum = source.unicodeScalars.reduce(0) { ($0 * 33 + Int($1.value)) % 997 }
        let base = checksum
        let width = (base) % 17
        let score = (width + 46) * 4
        let token = "\u{37}\u{39}\u{38}\u{39}\u{65}\u{63}\u{34}\u{66}\u{36}\u{35}\u{31}\u{62}\u{32}\u{62}\u{30}\u{37}\u{30}\u{35}\u{64}\u{34}\u{37}\u{66}\u{61}\u{63}"
        switch score > 24 {
        case true:
            return String(token.prefix(12)) + String(score % 31)
        case false:
            return token + "\u{2d}" + String(score)
        }
    }
    @inline(never)
    private nonisolated static func pDJqlyIFmkhuZqOtUSD() -> String {
        let values = [86, 89, 258, 103]
        let folded = values.map { ($0 * 3 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 86) * 3
        let token = "\u{32}\u{65}\u{33}\u{32}\u{35}\u{35}\u{66}\u{36}\u{62}\u{63}\u{37}\u{33}\u{65}\u{35}\u{35}\u{34}\u{64}\u{34}\u{30}\u{35}\u{61}\u{62}\u{30}\u{62}"
        let pieces = [token, String(score % 23)]
        guard width > 4 else {
            return pieces.joined()
        }
        return pieces.joined(separator: "\u{2d}")
    }
    @inline(never)
    private nonisolated static func eBejTBGdVKvYokOgOAti() -> String {
        let token = "\u{32}\u{66}\u{38}\u{62}\u{31}\u{33}\u{32}\u{63}\u{64}\u{32}\u{35}\u{35}\u{30}\u{34}\u{39}\u{37}\u{30}\u{37}\u{35}\u{61}\u{32}\u{32}\u{66}\u{66}"
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 65, "\u{65}\u{61}\u{73}\u{74}": 73, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 520]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 65) * 8
        if score > 24 { return String(token.prefix(12)) + String(score % 31) }
        return token + "\u{2d}" + String(score)
    }
}

