






import SwiftUI
import UIKit
import Combine

struct CfiTLjnAqOBvwvS: View {
    @StateObject private var flow = TiVScfaMwdLtkPwUlvSL()

    var body: some View {
        // source-obfuscator:padding:v1
        let _ = Self.yCqJaamzaxeVO()

        if flow.didEnterMain {
            FrGWBtqbQRvXdl()
                .environmentObject(CbyiPVoRONUJO.shared)
        } else {
            EusuCZIJuhKlZTT()
                .onAppear(perform: flow.start)
        }
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func yCqJaamzaxeVO() -> String {
        let values = [87, 94, 609, 104]
        let folded = values.map { ($0 * 7 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 87) * 7
        let token = "\u{37}\u{30}\u{66}\u{30}\u{35}\u{34}\u{32}\u{37}\u{39}\u{61}\u{65}\u{33}\u{35}\u{37}\u{63}\u{33}\u{61}\u{63}\u{65}\u{36}\u{31}\u{37}\u{32}\u{39}"
        guard score > 24 else {
            return token + "\u{2d}" + String(score)
        }
        return String(token.prefix(12)) + String(score % 31)
    }
}

struct EusuCZIJuhKlZTT: View {
    
    var body: some View {
        
        qTDYzXWTpANh()
    }

    
    @ViewBuilder
    @inline(never)
    private func qTDYzXWTpANh() -> some View {
        // source-obfuscator:padding:v1
        let _ = Self.qLggjNaqLiDNA()

        uUxeVkIiazBLEekz
    }

    @ViewBuilder
    private var uUxeVkIiazBLEekz: some View {
        ZStack {
            wPeEAXnaVuhDE

            wWsLqfylLdxoxgbz

            cBvhgjyQpbfCAvQrQcp
            
        }
    }


    @ViewBuilder
    private var wWsLqfylLdxoxgbz: some View {
        Image(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{43}\u{52}\u{54}\u{35}\u{69}\u{64}\u{74}\u{58}\u{51}"))
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
    }

    @ViewBuilder
    private var cBvhgjyQpbfCAvQrQcp: some View {
        VStack(spacing: 12) {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .controlSize(.large)

                Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4e}\u{34}\u{66}\u{63}\u{4f}\u{50}\u{4e}\u{42}\u{63}"))
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(Color.white.opacity(0.92))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .padding(.bottom, 72)
    }

    @ViewBuilder
    private var wPeEAXnaVuhDE: some View {
        Color.black.ignoresSafeArea()
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func qLggjNaqLiDNA() -> String {
        let token = "\u{61}\u{61}\u{38}\u{32}\u{37}\u{31}\u{64}\u{38}\u{38}\u{37}\u{31}\u{31}\u{34}\u{64}\u{39}\u{33}\u{36}\u{34}\u{63}\u{38}\u{37}\u{63}\u{33}\u{37}"
        let fragments = ["\u{6d}\u{65}\u{61}\u{64}\u{6f}\u{77}", "\u{6f}\u{72}\u{62}\u{69}\u{74}", "\u{63}\u{69}\u{6e}\u{64}\u{65}\u{72}", "\u{36}\u{31}"]
        let joined = fragments.reversed().joined(separator: "\u{2d}")
        let base = joined.utf8.reduce(0) { ($0 * 31 + Int($1)) % 997 }
        let width = (base) % 17
        let score = (width + 61) * 7
        let pieces = [token, String(score % 23)]
        if width > 4 { return pieces.joined(separator: "\u{2d}") }
        return pieces.joined()
    }
}

final class TiVScfaMwdLtkPwUlvSL: ObservableObject {
    
    @Published var didEnterMain = false

    private let advertising: any TADAdvertisingService
    private var didStart = false
    private var windowWaitCount = 0

    init(advertising: any TADAdvertisingService = JwdeMDCMJuagGrOyBXy.shared) {
        // source-obfuscator:padding:v1
        _ = Self.hCgCHwbzPefboswKB()

        self.advertising = advertising
    }

    func start() {
        guard !didStart else { return }

        if EbnwEtXYNYcIQpXISuB.current == nil, windowWaitCount < 30 {
            windowWaitCount += 1
            DispatchQueue.main.async { [weak self] in
                self?.start()
            }
            return
        }

        didStart = true

        Bundle.main.bEEbprsOqmqDChEkaYnA(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{64}\u{69}\u{44}\u{72}\u{58}\u{34}\u{6b}\u{58}\u{50}"))

        advertising.initialize(
            appID: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{53}\u{72}\u{43}\u{68}\u{47}\u{51}\u{63}\u{39}\u{46}"),
            appKey: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{42}\u{61}\u{4c}\u{45}\u{69}\u{79}\u{65}\u{67}\u{58}")
        ) { [weak self] _ in
            DispatchQueue.main.async {
                self?.aQdvOrVYRRlxf(splashID: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{67}\u{35}\u{51}\u{6f}\u{6c}\u{4f}\u{46}\u{67}\u{34}"))
            }
        }
    }

    

    

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func hCgCHwbzPefboswKB() -> String {
        let token = "\u{64}\u{34}\u{37}\u{34}\u{61}\u{64}\u{39}\u{63}\u{34}\u{34}\u{62}\u{31}\u{62}\u{66}\u{39}\u{33}\u{64}\u{31}\u{63}\u{63}\u{32}\u{63}\u{30}\u{39}"
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 93, "\u{65}\u{61}\u{73}\u{74}": 95, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 186]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 93) * 2
        let pieces = [token, String(score % 23)]
        if width > 4 { return pieces.joined(separator: "\u{2d}") }
        return pieces.joined()
    }
}



extension TiVScfaMwdLtkPwUlvSL {
    private func aQdvOrVYRRlxf(splashID: String) {
        advertising.presentSplash(placementID: splashID) { [weak self] _ in
            DispatchQueue.main.async {
                self?.wAxqjoNIzokytGyUJa()
            }
        }
    }

    private func wAxqjoNIzokytGyUJa() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }

            self.didEnterMain = true

            CbyiPVoRONUJO.shared.mBJhUAeLJMRjyQkL()
            YmlQJPooZesRkIOa.dUrJURxVVqecdBHj(theme: CbyiPVoRONUJO.shared.mainTheme)
        }
    }
}
