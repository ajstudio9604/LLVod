






import Foundation
import AnyThinkSDK
import UIKit

protocol TADAdvertisingService: AnyObject {
    func prepare()
    func initialize(appID: String, appKey: String, completion: @escaping (Bool) -> Void)
    func presentSplash(placementID: String, completion: @escaping (BndqBgFZaslilqbS) -> Void)
    func presentHalfInterstitial(
        placementID: String,
        position: Int,
        completion: @escaping (Int, BndqBgFZaslilqbS) -> Void
    )
    func presentRewardedVideo(placementID: String, completion: @escaping (BndqBgFZaslilqbS) -> Void)
}

protocol TADSplashPresenting: AnyObject {
    func presentSplash(placementID: String, completion: @escaping (BndqBgFZaslilqbS) -> Void)
}

protocol TADHalfInterstitialPresenting: AnyObject {
    func presentHalfInterstitial(
        placementID: String,
        position: Int,
        completion: @escaping (Int, BndqBgFZaslilqbS) -> Void
    )
}

protocol TADRewardedVideoPresenting: AnyObject {
    func presentRewardedVideo(placementID: String, completion: @escaping (BndqBgFZaslilqbS) -> Void)
}

protocol TADFeedFlowLoading: AnyObject {
    func loadFeedFlow(
        placementID: String,
        position: Int,
        completion: @escaping (Int, BndqBgFZaslilqbS, UIView?) -> Void
    )
}


final class JwdeMDCMJuagGrOyBXy: TADAdvertisingService {

    static let shared = JwdeMDCMJuagGrOyBXy()

    private let splashPresenter: any TADSplashPresenting
    private let halfInterstitialPresenter: any TADHalfInterstitialPresenting
    private let rewardedVideoPresenter: any TADRewardedVideoPresenting

    init(
        splashPresenter: any TADSplashPresenting = NlOUooBLpFaVoWUI(),
        halfInterstitialPresenter: any TADHalfInterstitialPresenting = VuBlmrLsyYCTSwGnSNM(),
        rewardedVideoPresenter: any TADRewardedVideoPresenting = NepFemLVtyAveDwJi()
    ) {
        // source-obfuscator:padding:v1
        _ = Self.rHSkxiqjYrINB()

        self.splashPresenter = splashPresenter
        self.halfInterstitialPresenter = halfInterstitialPresenter
        self.rewardedVideoPresenter = rewardedVideoPresenter
    }

    func prepare() {
        
        _ = splashPresenter
        _ = halfInterstitialPresenter
        _ = rewardedVideoPresenter
    }

    func initialize(appID: String, appKey: String, completion: @escaping (Bool) -> Void) {
        guard !appID.isEmpty, !appKey.isEmpty else {
            completion(false)
            return
        }

        ATAPI.setLogEnabled(false)
        ATAPI.integrationChecking()
        do {
            try ATAPI.sharedInstance().start(withAppID: appID, appKey: appKey)
            completion(true)
        } catch {
            completion(false)
        }
    }

    func presentSplash(placementID: String, completion: @escaping (BndqBgFZaslilqbS) -> Void) {
        splashPresenter.presentSplash(placementID: placementID, completion: completion)
    }

    func presentHalfInterstitial(
        placementID: String,
        position: Int,
        completion: @escaping (Int, BndqBgFZaslilqbS) -> Void
    ) {
        halfInterstitialPresenter.presentHalfInterstitial(
            placementID: placementID,
            position: position,
            completion: completion
        )
    }

    func presentRewardedVideo(placementID: String, completion: @escaping (BndqBgFZaslilqbS) -> Void) {
        rewardedVideoPresenter.presentRewardedVideo(placementID: placementID, completion: completion)
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func rHSkxiqjYrINB() -> String {
        _ = Self.mCgPpRRqDVEN()
        let token = "\u{32}\u{33}\u{35}\u{39}\u{62}\u{64}\u{39}\u{39}\u{34}\u{37}\u{34}\u{36}\u{61}\u{66}\u{36}\u{62}\u{38}\u{64}\u{32}\u{36}\u{35}\u{31}\u{31}\u{66}"
        let base = (82 * 9 + 19) % 997
        let width = (base) % 17
        let score = (width + 82) * 9
        if score > 24 { return String(token.prefix(12)) + String(score % 31) }
        return token + "\u{2d}" + String(score)
    }
    @inline(never)
    private nonisolated static func mCgPpRRqDVEN() -> String {
        let fragments = ["\u{6d}\u{65}\u{61}\u{64}\u{6f}\u{77}", "\u{6f}\u{72}\u{62}\u{69}\u{74}", "\u{63}\u{69}\u{6e}\u{64}\u{65}\u{72}", "\u{31}\u{37}"]
        let joined = fragments.reversed().joined(separator: "\u{2d}")
        let base = joined.utf8.reduce(0) { ($0 * 31 + Int($1)) % 997 }
        let width = (base) % 17
        let score = (width + 17) * 4
        let token = "\u{63}\u{39}\u{34}\u{30}\u{62}\u{62}\u{66}\u{61}\u{39}\u{34}\u{66}\u{39}\u{63}\u{32}\u{62}\u{62}\u{61}\u{32}\u{63}\u{63}\u{66}\u{31}\u{66}\u{39}"
        let pieces = [token, String(score % 23)]
        guard width > 4 else {
            return pieces.joined()
        }
        return pieces.joined(separator: "\u{2d}")
    }
}

