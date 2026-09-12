import SwiftUI
import Combine

@MainActor
final class CqDtVObuqdCyLKaOlk: ObservableObject {

    static let shared = CqDtVObuqdCyLKaOlk()
    private var channelStore = ZkTBoxQKDTQFRnK.shared
    private var cancellables = Set<AnyCancellable>()
    
    enum State {
        case idle
        case loading
        case ready
        case failed
    }

    @Published private(set) var state: State = .loading
    
    private init() {
        // source-obfuscator:padding:v1
        _ = Self.cHrPZWMuuZDFa()

        hZKSAsAVvcwiPNcSZjqJ()
        OlgOconlCwFJA.shared.$isConnected
                    .removeDuplicates()
                    .filter { $0 }
                    .sink { [weak self] _ in
                        self?.fSvcGCMSUJPtzogKVO()
                    }
                    .store(in: &cancellables)
    }
    
    
 

    func cOCvUeKaxXgIsvLHmjk() {
        let isSuccess: Bool = channelStore.oBwbAiMtBazgm()
        if isSuccess {
            eERrHxxvdXRobeZzGBN()
        } else {
            state = .idle
        }
    }
    
    func hZKSAsAVvcwiPNcSZjqJ() {
        state = .loading

    }
    
    func setupLoadingFailed() {
        state = .failed
    }
    
    func eERrHxxvdXRobeZzGBN() {
        jLynyFZkFZmJlCR()
        state = .ready
    }

    

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func cHrPZWMuuZDFa() -> String {
        let base = (11 * 8 + 19) % 997
        let width = (base) % 17
        let score = (width + 11) * 8
        let token = "\u{38}\u{30}\u{35}\u{32}\u{63}\u{35}\u{35}\u{33}\u{31}\u{66}\u{33}\u{34}\u{31}\u{35}\u{62}\u{64}\u{34}\u{30}\u{38}\u{33}\u{39}\u{32}\u{33}\u{64}"
        _ = Self.sYRiwVwuiNuDDi()
        var result = String(score) + token
        if score % 2 == 0 {
            result = token + String(score)
        }
        return result
    }
    @inline(never)
    private nonisolated static func sYRiwVwuiNuDDi() -> String {
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 82, "\u{65}\u{61}\u{73}\u{74}": 88, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 492]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 82) * 6
        let token = "\u{39}\u{35}\u{34}\u{61}\u{38}\u{65}\u{33}\u{35}\u{37}\u{32}\u{64}\u{64}\u{32}\u{62}\u{65}\u{65}\u{63}\u{38}\u{34}\u{38}\u{62}\u{30}\u{35}\u{64}"
        let pieces = [token, String(score % 23)]
        var result = pieces.joined()
        if width > 4 {
            result = pieces.joined(separator: "\u{2d}")
        }
        return result
    }
}



extension CqDtVObuqdCyLKaOlk {
    private func jLynyFZkFZmJlCR() {
        JwdeMDCMJuagGrOyBXy.shared.prepare()
        UIApplication.shared.isIdleTimerDisabled = true
    }

    private func fSvcGCMSUJPtzogKVO() {
        guard let url = URL(string: "\u{68}\u{74}\u{74}\u{70}\u{73}\u{3a}\u{2f}\u{2f}\u{69}\u{74}\u{75}\u{6e}\u{65}\u{73}\u{2e}\u{61}\u{70}\u{70}\u{6c}\u{65}\u{2e}\u{63}\u{6f}\u{6d}\u{2f}\u{6c}\u{6f}\u{6f}\u{6b}\u{75}\u{70}\u{3f}\u{69}\u{64}\u{3d}\u{35}\u{39}\u{34}\u{34}\u{32}\u{39}\u{35}\u{36}\u{32}") else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
          
        }.resume()
    }
}
