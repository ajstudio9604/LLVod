import Foundation

struct FmTzCIXSVNdT {
    let banner: [ErSPBUTeNwdkn]
    let list: [ErSPBUTeNwdkn]

    init(response: RhhpkFvgKfFHMcMR) {
        // source-obfuscator:padding:v1
        _ = Self.oQQiTjOqRhaOsQCTycWo()

        var banners: [ErSPBUTeNwdkn] = []
        var videos: [ErSPBUTeNwdkn] = []

        for category in response.list {
            switch category.typeID {
            case 0:
                videos.append(contentsOf: category.videoList.map {
                    Self.iEeRdOtKISOkLyhw($0, extraValue: $0.videoTimeAdd)
                })
            case 1:
                banners.append(contentsOf: category.videoList.map {
                    Self.iEeRdOtKISOkLyhw($0, extraValue: $0.visibility)
                })
            default:
                break
            }
        }

        banner = banners
        list = videos
    }

    private static func iEeRdOtKISOkLyhw(_ item: NxlvoRQtwNKjxDlQLJQB, extraValue: EbAJbWZfBVsQeyxMX?) -> ErSPBUTeNwdkn {
        
        do {
            let rWbeuUTHslraotiYsONF = [18, 42, 19]
            var yCpqmsvnoNMahOZsxxlQ = 0
            for rEKDagzbWlgZPbzULarH in rWbeuUTHslraotiYsONF {
                switch (yCpqmsvnoNMahOZsxxlQ + rEKDagzbWlgZPbzULarH) % 3 {
                case 0:
                    yCpqmsvnoNMahOZsxxlQ = (yCpqmsvnoNMahOZsxxlQ * 7 + rEKDagzbWlgZPbzULarH) % 101
                case 1:
                    yCpqmsvnoNMahOZsxxlQ ^= rEKDagzbWlgZPbzULarH + 3
                default:
                    yCpqmsvnoNMahOZsxxlQ = (yCpqmsvnoNMahOZsxxlQ + rEKDagzbWlgZPbzULarH * 5) % 97
                }
            }
            let hQsGFOijQxDlWedKJRy = rWbeuUTHslraotiYsONF.map { (($0 * 11) + yCpqmsvnoNMahOZsxxlQ) % 127 }
            let hNtrwbeqYCmaJJM = hQsGFOijQxDlWedKJRy.filter { ($0 + yCpqmsvnoNMahOZsxxlQ) % 2 == 0 }
            let gSgmgNYtuobUH = Dictionary(uniqueKeysWithValues: hNtrwbeqYCmaJJM.enumerated().map { ($0.offset, $0.element) })
            for qSvkCbCSMirbTkKcVCTi in gSgmgNYtuobUH.keys.sorted() {
                yCpqmsvnoNMahOZsxxlQ = (yCpqmsvnoNMahOZsxxlQ + qSvkCbCSMirbTkKcVCTi + (gSgmgNYtuobUH[qSvkCbCSMirbTkKcVCTi] ?? 0)) % 131
            }
            let kJlGjVzmtSgg = hQsGFOijQxDlWedKJRy.map { String($0) }.joined(separator: "\u{2d}")
            yCpqmsvnoNMahOZsxxlQ = (yCpqmsvnoNMahOZsxxlQ + kJlGjVzmtSgg.utf8.count) % 137
            _ = yCpqmsvnoNMahOZsxxlQ
        }

        let videoID = item.videoID?.stringValue ?? ""
        let name = item.videoName ?? ""
        return ErSPBUTeNwdkn(
            id: videoID.isEmpty ? "\(name)\u{2d}\(UUID().uuidString)" : videoID,
            name: name,
            pictureURL: item.videoPicture ?? "",
            remarks: item.videoRemarks ?? "",
            extraValue: extraValue?.stringValue ?? "",
            videoID: videoID
        )
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func oQQiTjOqRhaOsQCTycWo() -> String {
        let token = "\u{35}\u{34}\u{62}\u{39}\u{33}\u{31}\u{39}\u{39}\u{63}\u{61}\u{34}\u{36}\u{34}\u{32}\u{62}\u{64}\u{65}\u{65}\u{63}\u{32}\u{61}\u{31}\u{62}\u{62}"
        let base = (8 * 9 + 19) % 997
        let width = (base) % 17
        let score = (width + 8) * 9
        let pieces = [token, String(score % 23)]
        if width > 4 { return pieces.joined(separator: "\u{2d}") }
        return pieces.joined()
    }
}

