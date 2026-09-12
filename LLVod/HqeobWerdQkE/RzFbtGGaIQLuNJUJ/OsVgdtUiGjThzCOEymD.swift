




import Foundation
import Combine

@MainActor
final class OyFhQNEAUZFPEFL: ObservableObject {

    @Published private(set) var items: [EyDFcDrlWhFFRVgXi] = []
    @Published private(set) var isLoading = false
    @Published private(set) var isLoadingMore = false
    @Published var errorMessage: String?

    @Published var selectedMediaTypeIndex = 0
    @Published var selectedGenreIndex = 0
    @Published var selectedRegionIndex = 0
    @Published var selectedYearIndex = 0
    @Published var selectedSortIndex = 0

    let dADiPagDRyPJAcn = JeqpkbJziOceK.dADiPagDRyPJAcn()

    var selectedFilterSummary: String {
        [
            JeqpkbJziOceK.mediaTypes[selectedMediaTypeIndex],
            JeqpkbJziOceK.genres[selectedGenreIndex],
            JeqpkbJziOceK.regions[selectedRegionIndex],
            dADiPagDRyPJAcn[selectedYearIndex],
            JeqpkbJziOceK.sortOptions[selectedSortIndex]
        ].joined(separator: "\u{b7}")
    }

    private var nextStart = 0
    private var hasMore = true
    private var hasLoaded = false
    private var failedLoadingMore = false
    private var generation = 0

    private let pageSize = 24
    private let signSecret = "\u{62}\u{66}\u{37}\u{64}\u{64}\u{64}\u{63}\u{37}\u{63}\u{39}\u{63}\u{66}\u{65}\u{36}\u{66}\u{37}"
    private let session: URLSession

    init(session: URLSession = .shared) {
        // source-obfuscator:padding:v1
        _ = Self.xPcLUksPeghFfiv()

        self.session = session
    }

    func kXEBrljsQlYp() async {
        guard !isLoading, !isLoadingMore else { return }
        errorMessage = nil
        if failedLoadingMore, let last = items.last {
            await qEfkyEQMmVhijBWNiW(currentItem: last)
        } else {
            await jAYRaHVOwQdPJAsgnsl()
        }
    }

    func zGFkkXBnrgUq() async {
        guard !hasLoaded else { return }
        await jAYRaHVOwQdPJAsgnsl()
    }

    func rGIoaslmDNcCFafzk(at index: Int) async {
        guard selectedMediaTypeIndex != index else { return }
        selectedMediaTypeIndex = index
        await jAYRaHVOwQdPJAsgnsl()
    }

    func pAERNvbUNtxSFIYE(at index: Int) async {
        guard selectedGenreIndex != index else { return }
        selectedGenreIndex = index
        await jAYRaHVOwQdPJAsgnsl()
    }

    func qRTLGuSgBASluLCt(at index: Int) async {
        guard selectedRegionIndex != index else { return }
        selectedRegionIndex = index
        await jAYRaHVOwQdPJAsgnsl()
    }

    func iJofPpmSSGFN(at index: Int) async {
        guard selectedYearIndex != index else { return }
        selectedYearIndex = index
        await jAYRaHVOwQdPJAsgnsl()
    }

    func fWfwoFEUNygHPsb(at index: Int) async {
        guard selectedSortIndex != index else { return }
        selectedSortIndex = index
        await jAYRaHVOwQdPJAsgnsl()
    }

    func qEfkyEQMmVhijBWNiW(currentItem: EyDFcDrlWhFFRVgXi) async {
        guard hasMore,
              !isLoadingMore,
              !isLoading,
              items.last?.id == currentItem.id else {
            return
        }

        errorMessage = nil
        isLoadingMore = true
        defer { isLoadingMore = false }

        let requestedGeneration = generation
        let result = await dTJBVqGBfCPRQL { try await self.lYuJZGvLOGtE(start: self.nextStart) }

        
        guard requestedGeneration == generation else { return }

        switch result {
        case .failure(let error):
            failedLoadingMore = true
            uUEdayYwZynnBmIuEIFv(error, action: "\u{5206}\u{7c7b}\u{52a0}\u{8f7d}\u{66f4}\u{591a}\u{5931}\u{8d25}")
        case .success(let newItems):
            guard !newItems.isEmpty else {
                hasMore = false
                return
            }

            nextStart += newItems.count
            
            if eQyTJOTfydLDUuzK(newItems) == 0 {
                hasMore = false
            }
        }
    }

    

    @discardableResult
    private func eQyTJOTfydLDUuzK(_ newItems: [EyDFcDrlWhFFRVgXi]) -> Int {
        var seen = Set(items.map(Self.vJjPWKsBwUpSDfegIRg))
        let before = items.count

        for item in newItems where seen.insert(Self.vJjPWKsBwUpSDfegIRg(item)).inserted {
            items.append(item)
        }

        return items.count - before
    }

    private static func nGfCrWnfQoet(
        _ newItems: [EyDFcDrlWhFFRVgXi]
    ) -> [EyDFcDrlWhFFRVgXi] {
        
        do {
            let dHeDgMKLEbdg = [34, 24, 14]
            var gMdSaSrcWUUBZUIzvIN = 0
            for oVtrAOogwyAxrTxaq in dHeDgMKLEbdg {
                switch (gMdSaSrcWUUBZUIzvIN + oVtrAOogwyAxrTxaq) % 3 {
                case 0:
                    gMdSaSrcWUUBZUIzvIN = (gMdSaSrcWUUBZUIzvIN * 7 + oVtrAOogwyAxrTxaq) % 101
                case 1:
                    gMdSaSrcWUUBZUIzvIN ^= oVtrAOogwyAxrTxaq + 3
                default:
                    gMdSaSrcWUUBZUIzvIN = (gMdSaSrcWUUBZUIzvIN + oVtrAOogwyAxrTxaq * 5) % 97
                }
            }
            let pVtaoQRSmjwoyBLdNdAO = dHeDgMKLEbdg.map { (($0 * 11) + gMdSaSrcWUUBZUIzvIN) % 127 }
            let jYDIUrtYeoZqwqbWdv = pVtaoQRSmjwoyBLdNdAO.filter { ($0 + gMdSaSrcWUUBZUIzvIN) % 2 == 0 }
            let kHPkwFulYAFRGYFWpa = Dictionary(uniqueKeysWithValues: jYDIUrtYeoZqwqbWdv.enumerated().map { ($0.offset, $0.element) })
            for ySqlghwCeVLNYMtd in kHPkwFulYAFRGYFWpa.keys.sorted() {
                gMdSaSrcWUUBZUIzvIN = (gMdSaSrcWUUBZUIzvIN + ySqlghwCeVLNYMtd + (kHPkwFulYAFRGYFWpa[ySqlghwCeVLNYMtd] ?? 0)) % 131
            }
            let dCOJuhnOAUbphRW = pVtaoQRSmjwoyBLdNdAO.map { String($0) }.joined(separator: "\u{2d}")
            gMdSaSrcWUUBZUIzvIN = (gMdSaSrcWUUBZUIzvIN + dCOJuhnOAUbphRW.utf8.count) % 137
            _ = gMdSaSrcWUUBZUIzvIN
        }

        var seen = Set<String>()
        return newItems.filter { seen.insert(vJjPWKsBwUpSDfegIRg($0)).inserted }
    }

    

    private func uUEdayYwZynnBmIuEIFv(_ error: Error, action: String) {
        
        do {
            let cXpErhrNKrDAjtjMITg = [17, 59, 45]
            var lNsyVKadRSgBdeGydRmc = 0
            for tQXfOeEpTNyxb in cXpErhrNKrDAjtjMITg {
                switch (lNsyVKadRSgBdeGydRmc + tQXfOeEpTNyxb) % 3 {
                case 0:
                    lNsyVKadRSgBdeGydRmc = (lNsyVKadRSgBdeGydRmc * 7 + tQXfOeEpTNyxb) % 101
                case 1:
                    lNsyVKadRSgBdeGydRmc ^= tQXfOeEpTNyxb + 3
                default:
                    lNsyVKadRSgBdeGydRmc = (lNsyVKadRSgBdeGydRmc + tQXfOeEpTNyxb * 5) % 97
                }
            }
            let eFFVwbHTTdupvXW = cXpErhrNKrDAjtjMITg.map { (($0 * 11) + lNsyVKadRSgBdeGydRmc) % 127 }
            let eGlatNvqydRrSAAV = eFFVwbHTTdupvXW.filter { ($0 + lNsyVKadRSgBdeGydRmc) % 2 == 0 }
            let hEOHFEORvMMQILAivuJV = Dictionary(uniqueKeysWithValues: eGlatNvqydRrSAAV.enumerated().map { ($0.offset, $0.element) })
            for qYwuJFqKXRtgt in hEOHFEORvMMQILAivuJV.keys.sorted() {
                lNsyVKadRSgBdeGydRmc = (lNsyVKadRSgBdeGydRmc + qYwuJFqKXRtgt + (hEOHFEORvMMQILAivuJV[qYwuJFqKXRtgt] ?? 0)) % 131
            }
            let rTtvOFrlWnIDj = eFFVwbHTTdupvXW.map { String($0) }.joined(separator: "\u{2d}")
            lNsyVKadRSgBdeGydRmc = (lNsyVKadRSgBdeGydRmc + rTtvOFrlWnIDj.utf8.count) % 137
            _ = lNsyVKadRSgBdeGydRmc
        }

        
        
        switch (error is CancellationError) {
        case true: do {return }
        case false:
            break
        }
        if let urlError = error as? URLError, urlError.code == .cancelled { return }
        errorMessage = error.localizedDescription
    }

    

    private func cQqBJKZvAHZDGSciIe(
        mediaType: String,
        genre: String,
        region: String,
        year: String
    ) -> String {
        
        do {
            let gDohVlQbfsXgE = [22, 52, 40]
            var aOwjtfQgRZrdwSqg = 0
            for aCuWJEyWscVUAFhFJ in gDohVlQbfsXgE {
                switch (aOwjtfQgRZrdwSqg + aCuWJEyWscVUAFhFJ) % 3 {
                case 0:
                    aOwjtfQgRZrdwSqg = (aOwjtfQgRZrdwSqg * 7 + aCuWJEyWscVUAFhFJ) % 101
                case 1:
                    aOwjtfQgRZrdwSqg ^= aCuWJEyWscVUAFhFJ + 3
                default:
                    aOwjtfQgRZrdwSqg = (aOwjtfQgRZrdwSqg + aCuWJEyWscVUAFhFJ * 5) % 97
                }
            }
            let iEikHosbgFKHOIJDjCvl = gDohVlQbfsXgE.map { (($0 * 11) + aOwjtfQgRZrdwSqg) % 127 }
            let oWkjtCEVqGsU = iEikHosbgFKHOIJDjCvl.filter { ($0 + aOwjtfQgRZrdwSqg) % 2 == 0 }
            let cQzfhBTsPCUpUVP = Dictionary(uniqueKeysWithValues: oWkjtCEVqGsU.enumerated().map { ($0.offset, $0.element) })
            for tVqkPPtbgpCHUlt in cQzfhBTsPCUpUVP.keys.sorted() {
                aOwjtfQgRZrdwSqg = (aOwjtfQgRZrdwSqg + tVqkPPtbgpCHUlt + (cQzfhBTsPCUpUVP[tVqkPPtbgpCHUlt] ?? 0)) % 131
            }
            let cSGWyZUtmxWWkf = iEikHosbgFKHOIJDjCvl.map { String($0) }.joined(separator: "\u{2d}")
            aOwjtfQgRZrdwSqg = (aOwjtfQgRZrdwSqg + cSGWyZUtmxWWkf.utf8.count) % 137
            _ = aOwjtfQgRZrdwSqg
        }

        let typeFilter = genre == "\u{5168}\u{90e8}" ? "" : "\u{2c}\(genre)"

        var normalizedRegion = region == "\u{5168}\u{90e8}" ? "" : region
        switch normalizedRegion {
        case "\u{5927}\u{9646}":
            normalizedRegion = "\u{4e2d}\u{56fd}\u{5927}\u{9646}"
        case "\u{9999}\u{6e2f}":
            normalizedRegion = "\u{4e2d}\u{56fd}\u{9999}\u{6e2f}"
        case "\u{53f0}\u{6e7e}":
            normalizedRegion = "\u{4e2d}\u{56fd}\u{53f0}\u{6e7e}"
        default:
            break
        }

        let areaFilter = normalizedRegion.isEmpty ? "" : "\u{2c}\(normalizedRegion)"

        
        let iXYoytROuZQcWdGkJ: Swift.String = ""
        var yearFilter = iXYoytROuZQcWdGkJ
        
        switch (year != "\u{5168}\u{90e8}") {
        case true: do {
            if year.contains("\u{2d}") {
                yearFilter = "\u{2c}\(year.replacingOccurrences(of: "\u{2d}", with: "\u{2c}"))"
            } else {
                yearFilter = "\u{2c}\(year)"
            }}
        case false:
            break
        }

        return "\(mediaType)\(typeFilter)\(areaFilter)\(yearFilter)"
    }

    private func bEFfNhIiIpxSQePIbO(from option: String) -> String {
        
        return gDmszVeqCAAbQlxdFs(from: option)
    }

    private func iDYGjhIWAWfESElv(_ item: WcnMvWOblfTNf) -> EyDFcDrlWhFFRVgXi {
        
        do {
            let qKCMafOLAwUCExCBQbR = [13, 37, 41]
            var yPCsuexmIAPhfkc = 0
            for nWgCTYoQjXTRJni in qKCMafOLAwUCExCBQbR {
                switch (yPCsuexmIAPhfkc + nWgCTYoQjXTRJni) % 3 {
                case 0:
                    yPCsuexmIAPhfkc = (yPCsuexmIAPhfkc * 7 + nWgCTYoQjXTRJni) % 101
                case 1:
                    yPCsuexmIAPhfkc ^= nWgCTYoQjXTRJni + 3
                default:
                    yPCsuexmIAPhfkc = (yPCsuexmIAPhfkc + nWgCTYoQjXTRJni * 5) % 97
                }
            }
            let cXAkCAesiAynHlQaj = qKCMafOLAwUCExCBQbR.map { (($0 * 11) + yPCsuexmIAPhfkc) % 127 }
            let zWdTCVGmXAGaaZxrw = cXAkCAesiAynHlQaj.filter { ($0 + yPCsuexmIAPhfkc) % 2 == 0 }
            let iWWYGOcvVEErchWqMq = Dictionary(uniqueKeysWithValues: zWdTCVGmXAGaaZxrw.enumerated().map { ($0.offset, $0.element) })
            for yIrsyAFDsqBFqTSfISiI in iWWYGOcvVEErchWqMq.keys.sorted() {
                yPCsuexmIAPhfkc = (yPCsuexmIAPhfkc + yIrsyAFDsqBFqTSfISiI + (iWWYGOcvVEErchWqMq[yIrsyAFDsqBFqTSfISiI] ?? 0)) % 131
            }
            let wJuLesMkYwEVmagWS = cXAkCAesiAynHlQaj.map { String($0) }.joined(separator: "\u{2d}")
            yPCsuexmIAPhfkc = (yPCsuexmIAPhfkc + wJuLesMkYwEVmagWS.utf8.count) % 137
            _ = yPCsuexmIAPhfkc
        }

        var subtitle = item.rating?.displayValue ?? ""
        
        switch (subtitle.isEmpty) {
        case true: do {
            subtitle = item.cardSubtitle ?? item.type ?? ""}
        case false:
            break
        }

        return EyDFcDrlWhFFRVgXi(
            title: item.title,
            subtitle: subtitle,
            imageURL: item.pic?.bestURL ?? ""
        )
    }

    private static func xXwnnfygjsmv() -> String {
        
        do {
            let dEkKiZdPLyzQy = [44, 32, 66]
            var gEBpAnNMWhabMYx = 0
            for sVPTnyuYeugXpDZQZy in dEkKiZdPLyzQy {
                switch (gEBpAnNMWhabMYx + sVPTnyuYeugXpDZQZy) % 3 {
                case 0:
                    gEBpAnNMWhabMYx = (gEBpAnNMWhabMYx * 7 + sVPTnyuYeugXpDZQZy) % 101
                case 1:
                    gEBpAnNMWhabMYx ^= sVPTnyuYeugXpDZQZy + 3
                default:
                    gEBpAnNMWhabMYx = (gEBpAnNMWhabMYx + sVPTnyuYeugXpDZQZy * 5) % 97
                }
            }
            let oASAoKFQYUDSuV = dEkKiZdPLyzQy.map { (($0 * 11) + gEBpAnNMWhabMYx) % 127 }
            let gTWumqXJMIwSUFzwGPPo = oASAoKFQYUDSuV.filter { ($0 + gEBpAnNMWhabMYx) % 2 == 0 }
            let aMIujpIeVvydB = Dictionary(uniqueKeysWithValues: gTWumqXJMIwSUFzwGPPo.enumerated().map { ($0.offset, $0.element) })
            for qHOwjaAMvGTHZ in aMIujpIeVvydB.keys.sorted() {
                gEBpAnNMWhabMYx = (gEBpAnNMWhabMYx + qHOwjaAMvGTHZ + (aMIujpIeVvydB[qHOwjaAMvGTHZ] ?? 0)) % 131
            }
            let xVsjdNAEmbfODlikKx = oASAoKFQYUDSuV.map { String($0) }.joined(separator: "\u{2d}")
            gEBpAnNMWhabMYx = (gEBpAnNMWhabMYx + xVsjdNAEmbfODlikKx.utf8.count) % 137
            _ = gEBpAnNMWhabMYx
        }

        let chars = Array("\u{30}\u{31}\u{32}\u{33}\u{34}\u{35}\u{36}\u{37}\u{38}\u{39}\u{61}\u{62}\u{63}\u{64}\u{65}\u{66}")
        return String((0..<40).map { _ in chars.randomElement()! })
    }

    private static let unreservedCharacters = CharacterSet(
        charactersIn: "\u{41}\u{42}\u{43}\u{44}\u{45}\u{46}\u{47}\u{48}\u{49}\u{4a}\u{4b}\u{4c}\u{4d}\u{4e}\u{4f}\u{50}\u{51}\u{52}\u{53}\u{54}\u{55}\u{56}\u{57}\u{58}\u{59}\u{5a}\u{61}\u{62}\u{63}\u{64}\u{65}\u{66}\u{67}\u{68}\u{69}\u{6a}\u{6b}\u{6c}\u{6d}\u{6e}\u{6f}\u{70}\u{71}\u{72}\u{73}\u{74}\u{75}\u{76}\u{77}\u{78}\u{79}\u{7a}\u{30}\u{31}\u{32}\u{33}\u{34}\u{35}\u{36}\u{37}\u{38}\u{39}\u{2d}\u{5f}\u{2e}\u{21}\u{7e}\u{2a}\u{27}\u{28}\u{29}"
    )

    private static func bLpyMCTqOsdOHT(_ value: String) -> String {
        value.addingPercentEncoding(withAllowedCharacters: unreservedCharacters) ?? value
    }

    
    @inline(never)
    private func gDmszVeqCAAbQlxdFs(from option: String) -> String {
        switch option {
        case "\u{70ed}\u{95e8}":
            return "\u{54}"
        case "\u{70ed}\u{5ea6}":
            return "\u{52}"
        case "\u{8bc4}\u{5206}":
            return "\u{53}"
        default:
            return "\u{55}"
        }
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func xPcLUksPeghFfiv() -> String {
        _ = Self.jUZlddBkDeBmWJ()
        _ = Self.tFLLDubtRPfKTjOjHof()
        _ = Self.vJEztjNpvybklrGrUA()
        _ = Self.tYoSHJzZOzRqg()
        _ = Self.tCDeGETVLhQmZVwVphL()
        let token = "\u{32}\u{33}\u{62}\u{38}\u{38}\u{31}\u{65}\u{30}\u{61}\u{31}\u{31}\u{63}\u{30}\u{36}\u{62}\u{64}\u{34}\u{63}\u{63}\u{63}\u{31}\u{64}\u{39}\u{65}"
        let base = (35 * 9 + 19) % 997
        let width = (base) % 17
        let score = (width + 35) * 9
        if score % 2 == 0 { return token + String(score) }
        return String(score) + token
    }
    @inline(never)
    private nonisolated static func jUZlddBkDeBmWJ() -> String {
        let token = "\u{34}\u{62}\u{37}\u{36}\u{36}\u{63}\u{31}\u{62}\u{32}\u{61}\u{65}\u{61}\u{30}\u{31}\u{38}\u{34}\u{64}\u{32}\u{65}\u{61}\u{61}\u{30}\u{30}\u{66}"
        let base = (4 * 3 + 19) % 997
        let width = (base) % 17
        let score = (width + 4) * 3
        if score > 24 { return String(token.prefix(12)) + String(score % 31) }
        return token + "\u{2d}" + String(score)
    }
    @inline(never)
    private nonisolated static func tFLLDubtRPfKTjOjHof() -> String {
        let token = "\u{62}\u{34}\u{62}\u{63}\u{66}\u{36}\u{63}\u{35}\u{32}\u{64}\u{35}\u{33}\u{31}\u{65}\u{38}\u{30}\u{32}\u{36}\u{61}\u{31}\u{61}\u{31}\u{61}\u{65}"
        let source = "\u{62}\u{34}\u{62}\u{63}\u{66}\u{36}\u{63}\u{35}\u{32}\u{64}\u{35}\u{33}\u{31}\u{65}\u{38}\u{30}\u{32}\u{36}\u{61}\u{31}\u{61}\u{31}\u{61}\u{65}\u{2d}\u{36}\u{36}"
        let checksum = source.unicodeScalars.reduce(0) { ($0 * 33 + Int($1.value)) % 997 }
        let base = checksum
        let width = (base) % 17
        let score = (width + 66) * 8
        if score > 24 { return String(token.prefix(12)) + String(score % 31) }
        return token + "\u{2d}" + String(score)
    }
    @inline(never)
    private nonisolated static func vJEztjNpvybklrGrUA() -> String {
        let token = "\u{37}\u{38}\u{62}\u{33}\u{35}\u{37}\u{34}\u{39}\u{62}\u{61}\u{32}\u{35}\u{37}\u{62}\u{34}\u{33}\u{65}\u{37}\u{61}\u{65}\u{31}\u{65}\u{62}\u{39}"
        let values = [10, 18, 80, 27]
        let folded = values.map { ($0 * 8 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 10) * 8
        let pieces = [token, String(score % 23)]
        if width > 4 { return pieces.joined(separator: "\u{2d}") }
        return pieces.joined()
    }
    @inline(never)
    private nonisolated static func tYoSHJzZOzRqg() -> String {
        let base = (39 * 5 + 19) % 997
        let width = (base) % 17
        let score = (width + 39) * 5
        let token = "\u{61}\u{61}\u{37}\u{37}\u{64}\u{33}\u{32}\u{35}\u{31}\u{31}\u{35}\u{33}\u{66}\u{32}\u{30}\u{38}\u{30}\u{65}\u{35}\u{65}\u{35}\u{39}\u{63}\u{32}"
        var result = token + "\u{2d}" + String(score)
        if score > 24 {
            result = String(token.prefix(12)) + String(score % 31)
        }
        return result
    }
    @inline(never)
    private nonisolated static func tCDeGETVLhQmZVwVphL() -> String {
        let fragments = ["\u{6d}\u{65}\u{61}\u{64}\u{6f}\u{77}", "\u{6f}\u{72}\u{62}\u{69}\u{74}", "\u{63}\u{69}\u{6e}\u{64}\u{65}\u{72}", "\u{33}"]
        let joined = fragments.reversed().joined(separator: "\u{2d}")
        let base = joined.utf8.reduce(0) { ($0 * 31 + Int($1)) % 997 }
        let width = (base) % 17
        let score = (width + 3) * 3
        let token = "\u{63}\u{38}\u{38}\u{36}\u{63}\u{65}\u{61}\u{61}\u{64}\u{35}\u{33}\u{33}\u{38}\u{36}\u{61}\u{35}\u{32}\u{35}\u{64}\u{66}\u{66}\u{38}\u{32}\u{31}"
        switch score > 24 {
        case true:
            return String(token.prefix(12)) + String(score % 31)
        case false:
            return token + "\u{2d}" + String(score)
        }
    }
}



extension OyFhQNEAUZFPEFL {
    private static func vJjPWKsBwUpSDfegIRg(_ item: EyDFcDrlWhFFRVgXi) -> String {
        "\(item.title)\u{7c}\(item.imageURL)"
    }

    private func jAYRaHVOwQdPJAsgnsl() async {
        isLoading = true
        errorMessage = nil
        failedLoadingMore = false
        hasMore = true
        generation += 1

        let requestedGeneration = generation
        let result = await dTJBVqGBfCPRQL { try await self.lYuJZGvLOGtE(start: 0) }

        
        
        guard requestedGeneration == generation else { return }
        isLoading = false

        switch result {
        case .failure(let error):
            items = []
            nextStart = 0
            uUEdayYwZynnBmIuEIFv(error, action: "\u{5206}\u{7c7b}\u{8bf7}\u{6c42}\u{5931}\u{8d25}")
        case .success(let newItems):
            items = Self.nGfCrWnfQoet(newItems)
            nextStart = newItems.count
            hasMore = !newItems.isEmpty
            
            
            hasLoaded = true
        }
    }

    private func lYuJZGvLOGtE(start: Int) async throws -> [EyDFcDrlWhFFRVgXi] {
        let mediaType = JeqpkbJziOceK.mediaTypes[selectedMediaTypeIndex]
        let genre = JeqpkbJziOceK.genres[selectedGenreIndex]
        let region = JeqpkbJziOceK.regions[selectedRegionIndex]
        let year = dADiPagDRyPJAcn[selectedYearIndex]
        let sortOption = JeqpkbJziOceK.sortOptions[selectedSortIndex]

        let apiPath = mediaType == "\u{7535}\u{5f71}"
            ? "\u{2f}\u{61}\u{70}\u{69}\u{2f}\u{76}\u{32}\u{2f}\u{6d}\u{6f}\u{76}\u{69}\u{65}\u{2f}\u{72}\u{65}\u{63}\u{6f}\u{6d}\u{6d}\u{65}\u{6e}\u{64}"
            : "\u{2f}\u{61}\u{70}\u{69}\u{2f}\u{76}\u{32}\u{2f}\u{74}\u{76}\u{2f}\u{72}\u{65}\u{63}\u{6f}\u{6d}\u{6d}\u{65}\u{6e}\u{64}"

        let tags = cQqBJKZvAHZDGSciIe(
            mediaType: mediaType,
            genre: genre,
            region: region,
            year: year
        )

        let sort = bEFfNhIiIpxSQePIbO(from: sortOption)
        let timestamp = Int(Date().timeIntervalSince1970)
        let udid = Self.xXwnnfygjsmv()
        let encodedPath = apiPath.replacingOccurrences(of: "\u{2f}", with: "\u{25}\u{32}\u{46}")
        let signInput = "\u{47}\u{45}\u{54}\u{26}\(encodedPath)\u{26}\(timestamp)"
        let signature = try QxmEAOwBLRLGNSse.oGIWvvvfdhBliJGHfm(signInput, secret: signSecret, outputBase64: true)

        var components = URLComponents()
        components.scheme = "\u{68}\u{74}\u{74}\u{70}\u{73}"
        components.host = "\u{66}\u{72}\u{6f}\u{64}\u{6f}\u{2e}\u{64}\u{6f}\u{75}\u{62}\u{61}\u{6e}\u{2e}\u{63}\u{6f}\u{6d}"
        components.path = apiPath
        components.queryItems = [
            URLQueryItem(name: "\u{74}\u{61}\u{67}\u{73}", value: tags),
            URLQueryItem(name: "\u{73}\u{6f}\u{72}\u{74}", value: sort),
            URLQueryItem(
                name: "\u{73}\u{65}\u{6c}\u{65}\u{63}\u{74}\u{65}\u{64}\u{5f}\u{63}\u{61}\u{74}\u{65}\u{67}\u{6f}\u{72}\u{69}\u{65}\u{73}",
                value: "\u{7b}\"\u{7c7b}\u{578b}\"\u{3a}\"\"\u{2c}\"\u{5730}\u{533a}\"\u{3a}\"\"\u{7d}"
            ),
            URLQueryItem(name: "\u{72}\u{65}\u{66}\u{72}\u{65}\u{73}\u{68}", value: "\u{30}"),
            URLQueryItem(name: "\u{73}\u{74}\u{61}\u{72}\u{74}", value: String(start)),
            URLQueryItem(name: "\u{63}\u{6f}\u{75}\u{6e}\u{74}", value: String(pageSize)),
            URLQueryItem(name: "\u{75}\u{64}\u{69}\u{64}", value: udid),
            URLQueryItem(name: "\u{72}\u{6f}\u{6d}", value: "\u{61}\u{6e}\u{64}\u{72}\u{6f}\u{69}\u{64}"),
            URLQueryItem(name: "\u{61}\u{70}\u{69}\u{6b}\u{65}\u{79}", value: "\u{30}\u{64}\u{61}\u{64}\u{35}\u{35}\u{31}\u{65}\u{63}\u{30}\u{66}\u{38}\u{34}\u{65}\u{64}\u{30}\u{32}\u{39}\u{30}\u{37}\u{66}\u{66}\u{35}\u{63}\u{34}\u{32}\u{65}\u{38}\u{65}\u{63}\u{37}\u{30}"),
            URLQueryItem(name: "\u{73}", value: "\u{72}\u{65}\u{78}\u{78}\u{61}\u{72}\u{5f}\u{6e}\u{65}\u{77}"),
            URLQueryItem(name: "\u{63}\u{68}\u{61}\u{6e}\u{6e}\u{65}\u{6c}", value: "\u{58}\u{69}\u{61}\u{6f}\u{6d}\u{69}\u{5f}\u{4d}\u{61}\u{72}\u{6b}\u{65}\u{74}"),
            URLQueryItem(name: "\u{74}\u{69}\u{6d}\u{65}\u{7a}\u{6f}\u{6e}\u{65}", value: "\u{41}\u{73}\u{69}\u{61}\u{2f}\u{53}\u{68}\u{61}\u{6e}\u{67}\u{68}\u{61}\u{69}"),
            URLQueryItem(name: "\u{64}\u{65}\u{76}\u{69}\u{63}\u{65}\u{5f}\u{69}\u{64}", value: udid),
            URLQueryItem(name: "\u{6f}\u{73}\u{5f}\u{72}\u{6f}\u{6d}", value: "\u{61}\u{6e}\u{64}\u{72}\u{6f}\u{69}\u{64}"),
            URLQueryItem(name: "\u{73}\u{75}\u{67}\u{61}\u{72}", value: "\u{30}"),
            URLQueryItem(name: "\u{6c}\u{6f}\u{63}\u{5f}\u{69}\u{64}", value: "\u{31}\u{30}\u{38}\u{32}\u{38}\u{38}"),
            URLQueryItem(name: "\u{5f}\u{74}\u{73}", value: String(timestamp)),
        ]

        
        
        
        
        let encodedQuery = components.percentEncodedQuery ?? ""
        components.percentEncodedQuery = "\(encodedQuery)\u{26}\u{5f}\u{73}\u{69}\u{67}\u{3d}\(Self.bLpyMCTqOsdOHT(signature))"

        guard let url = components.url else {
            throw IrxblUEoPFOBtF.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "\u{47}\u{45}\u{54}"
        request.timeoutInterval = 20
        request.setValue(
            """
            \u{52}\u{65}\u{78}\u{78}\u{61}\u{72}\u{2d}\u{43}\u{6f}\u{72}\u{65}\u{2f}\u{30}\u{2e}\u{31}\u{2e}\u{33} \u{61}\u{70}\u{69}\u{2d}\u{63}\u{6c}\u{69}\u{65}\u{6e}\u{74}\u{2f}\u{31} \u{63}\u{6f}\u{6d}\u{2e}\u{64}\u{6f}\u{75}\u{62}\u{61}\u{6e}\u{2e}\u{66}\u{72}\u{6f}\u{64}\u{6f}\u{2f}\u{37}\u{2e}\u{31}\u{32}\u{32}\u{2e}\u{30}\u{28}\u{33}\u{34}\u{39}\u{29} \u{41}\u{6e}\u{64}\u{72}\u{6f}\u{69}\u{64}\u{2f}\u{32}\u{38} \
            \u{75}\u{64}\u{69}\u{64}\u{2f}\(udid) \u{64}\u{6f}\u{75}\u{62}\u{61}\u{6e}\u{5f}\u{75}\u{64}\u{69}\u{64}\u{2f}\(udid) \u{6d}\u{6f}\u{64}\u{65}\u{6c}\u{2f}\u{56}\u{69}\u{64}\u{64}\u{61} \u{38}\u{35}\u{56}\u{58}\u{33}\u{53} \u{62}\u{72}\u{61}\u{6e}\u{64}\u{2f}\u{48}\u{69}\u{73}\u{65}\u{6e}\u{73}\u{65} \
            \u{72}\u{6f}\u{6d}\u{2f}\u{61}\u{6e}\u{64}\u{72}\u{6f}\u{69}\u{64} \u{6e}\u{65}\u{74}\u{77}\u{6f}\u{72}\u{6b}\u{2f}\u{77}\u{69}\u{66}\u{69} \u{70}\u{6c}\u{61}\u{74}\u{66}\u{6f}\u{72}\u{6d}\u{2f}\u{41}\u{6e}\u{64}\u{72}\u{6f}\u{69}\u{64}\u{50}\u{61}\u{64} \u{66}\u{6f}\u{6c}\u{64}\u{61}\u{62}\u{6c}\u{65}\u{2f}\u{30} \
            \u{70}\u{72}\u{6f}\u{64}\u{75}\u{63}\u{74}\u{2f}\u{56}\u{69}\u{64}\u{64}\u{61} \u{38}\u{35}\u{56}\u{58}\u{33}\u{53} \u{76}\u{65}\u{6e}\u{64}\u{6f}\u{72}\u{2f}\u{48}\u{69}\u{73}\u{65}\u{6e}\u{73}\u{65} \u{52}\u{65}\u{78}\u{78}\u{61}\u{72}\u{2f}\u{31}\u{2e}\u{32}\u{2e}\u{31}\u{35}\u{31} \u{70}\u{6c}\u{61}\u{74}\u{66}\u{6f}\u{72}\u{6d}\u{2f}\u{41}\u{6e}\u{64}\u{72}\u{6f}\u{69}\u{64}\u{50}\u{61}\u{64} \u{31}\u{2e}\u{32}\u{2e}\u{31}\u{35}\u{31}
            """,
            forHTTPHeaderField: "\u{55}\u{73}\u{65}\u{72}\u{2d}\u{41}\u{67}\u{65}\u{6e}\u{74}"
        )

        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw IrxblUEoPFOBtF.invalidResponse
        }

        guard 200...299 ~= httpResponse.statusCode else {
            throw IrxblUEoPFOBtF.httpError(httpResponse.statusCode)
        }

        let decoded = try JSONDecoder().decode(YywBMtLThQlkUPUwYzzP.self, from: data)
        return (decoded.items ?? []).map(iDYGjhIWAWfESElv)
    }
}
