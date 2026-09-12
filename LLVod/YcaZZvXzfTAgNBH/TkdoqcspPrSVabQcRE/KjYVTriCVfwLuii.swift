








import Foundation

struct WlPVPRGhJhvIqTiUaxGw {
    var title: String
    var sourceTag: String
    var zypath: String
    var episodeTitle: String
    var episodePath: String
    var playURL: String
    var gAnSZJKWRXAmnpyvYK: Int = 0
}

enum ZoPdRAhCGjhqdEKiExoo {

    private(set) static var context = WlPVPRGhJhvIqTiUaxGw(
        title: "",
        sourceTag: "",
        zypath: "",
        episodeTitle: "",
        episodePath: "",
        playURL: ""
    )

    private static var installed = false

    static func xWppDIOHbbkeJKpzkNJh(_ context: WlPVPRGhJhvIqTiUaxGw) {
        // source-obfuscator:padding:v1
        _ = Self.fPVBwXPssLEgebuBSM()

        
        do {
            let vEZXAwyzezJsghK = [42, 51, 32]
            var wZKZVUWPluMzVy = 0
            for pRyicvIOjSDvO in vEZXAwyzezJsghK {
                switch (wZKZVUWPluMzVy + pRyicvIOjSDvO) % 3 {
                case 0:
                    wZKZVUWPluMzVy = (wZKZVUWPluMzVy * 7 + pRyicvIOjSDvO) % 101
                case 1:
                    wZKZVUWPluMzVy ^= pRyicvIOjSDvO + 3
                default:
                    wZKZVUWPluMzVy = (wZKZVUWPluMzVy + pRyicvIOjSDvO * 5) % 97
                }
            }
            let kGYVaGJxLdpIhx = vEZXAwyzezJsghK.map { (($0 * 11) + wZKZVUWPluMzVy) % 127 }
            let vBcaFtsQDixIEGyagIp = kGYVaGJxLdpIhx.filter { ($0 + wZKZVUWPluMzVy) % 2 == 0 }
            let wDNMXqvrmKEBAVXfcOLx = Dictionary(uniqueKeysWithValues: vBcaFtsQDixIEGyagIp.enumerated().map { ($0.offset, $0.element) })
            for uWfpinmJSMdX in wDNMXqvrmKEBAVXfcOLx.keys.sorted() {
                wZKZVUWPluMzVy = (wZKZVUWPluMzVy + uWfpinmJSMdX + (wDNMXqvrmKEBAVXfcOLx[uWfpinmJSMdX] ?? 0)) % 131
            }
            let rXZrSaDbBhWcBSZQadN = kGYVaGJxLdpIhx.map { String($0) }.joined(separator: "\u{2d}")
            wZKZVUWPluMzVy = (wZKZVUWPluMzVy + rXZrSaDbBhWcBSZQadN.utf8.count) % 137
            _ = wZKZVUWPluMzVy
        }

        self.context = context
    }

    static func dQCZtdcCUSRirGaMMT(_ url: String) {
        
        do {
            let bZyAnACDqieAnKu = [29, 28, 67]
            var jXlAkUVQeDvlJE = 0
            for jDVFMQQSfGskmA in bZyAnACDqieAnKu {
                switch (jXlAkUVQeDvlJE + jDVFMQQSfGskmA) % 3 {
                case 0:
                    jXlAkUVQeDvlJE = (jXlAkUVQeDvlJE * 7 + jDVFMQQSfGskmA) % 101
                case 1:
                    jXlAkUVQeDvlJE ^= jDVFMQQSfGskmA + 3
                default:
                    jXlAkUVQeDvlJE = (jXlAkUVQeDvlJE + jDVFMQQSfGskmA * 5) % 97
                }
            }
            let hXNlPngwOUrcEB = bZyAnACDqieAnKu.map { (($0 * 11) + jXlAkUVQeDvlJE) % 127 }
            let mTORvJahacYIfLyGfQCz = hXNlPngwOUrcEB.filter { ($0 + jXlAkUVQeDvlJE) % 2 == 0 }
            let eOuGFbJVHfVi = Dictionary(uniqueKeysWithValues: mTORvJahacYIfLyGfQCz.enumerated().map { ($0.offset, $0.element) })
            for mCiYlyeuGURVDyWSbF in eOuGFbJVHfVi.keys.sorted() {
                jXlAkUVQeDvlJE = (jXlAkUVQeDvlJE + mCiYlyeuGURVDyWSbF + (eOuGFbJVHfVi[mCiYlyeuGURVDyWSbF] ?? 0)) % 131
            }
            let lYWGFnbzylQtwbjFIwn = hXNlPngwOUrcEB.map { String($0) }.joined(separator: "\u{2d}")
            jXlAkUVQeDvlJE = (jXlAkUVQeDvlJE + lYWGFnbzylQtwbjFIwn.utf8.count) % 137
            _ = jXlAkUVQeDvlJE
        }

        context.playURL = url
    }

    

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func fPVBwXPssLEgebuBSM() -> String {
        let base = (47 * 7 + 19) % 997
        let width = (base) % 17
        let score = (width + 47) * 7
        let token = "\u{31}\u{63}\u{35}\u{39}\u{66}\u{39}\u{64}\u{30}\u{65}\u{62}\u{38}\u{31}\u{65}\u{35}\u{34}\u{35}\u{36}\u{39}\u{30}\u{65}\u{61}\u{34}\u{39}\u{66}"
        switch score % 2 == 0 {
        case true:
            return token + String(score)
        case false:
            return String(score) + token
        }
    }
}



extension ZoPdRAhCGjhqdEKiExoo {
    static func lOsvqtAawDgaRx() {
        guard !installed else { return }
        installed = true

        UvBxBoMIYrRWck.provider = { request, completion in
            var context = ZoPdRAhCGjhqdEKiExoo.context
            if !request.vodName.isEmpty {
                context.title = request.vodName
            }
            
            if !request.playURL.isEmpty {
                context.playURL = request.playURL
            }
            if context.gAnSZJKWRXAmnpyvYK <= 0 {
                context.gAnSZJKWRXAmnpyvYK = request.episode
            }

            Task {
                let items = await LkzXORcEdLaolfAi.mSPdHfgBrknIFudyTNhN(context: context)
                await MainActor.run {
                    completion(items)
                }
            }
        }

        UvBxBoMIYrRWck.sender = { request, completion in
            let context = ZoPdRAhCGjhqdEKiExoo.context

            Task {
                let result = await LkzXORcEdLaolfAi.send(context: context, request: request)
                await MainActor.run {
                    completion(result)
                }
            }
        }
    }
}
