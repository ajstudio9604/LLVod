import UIKit
import Combine
import AnyThinkSDK

final class TADSelfRenderView: UIView {

    static let preferredSize = CGSize(width: UIScreen.main.bounds.width, height: 150)

    override var intrinsicContentSize: CGSize { Self.preferredSize }

    let advertiserLabel = UILabel()
    let textLabel = UILabel()
    let titleLabel = UILabel()
    let ctaLabel = UILabel()
    let ratingLabel = UILabel()
    let iconImageView = UIImageView()
    let mainImageView = UIImageView()
    let logoImageView = UIImageView()
    let dislikeButton = UIButton(type: .custom)
    let domainLabel = UILabel()
    let warningLabel = UILabel()
    let mediaContainer = UIView()

    private(set) var mediaView: UIView?

    func attachMediaView(_ view: UIView) {
        mediaView?.removeFromSuperview()
        view.removeFromSuperview()
        view.translatesAutoresizingMaskIntoConstraints = true
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.clipsToBounds = true
        mediaContainer.addSubview(view)
        view.frame = mediaContainer.bounds
        mediaView = view
        mainImageView.isHidden = true
        iconImageView.isHidden = true
    }

    private let adBadge = UILabel()

    init(offer: ATNativeAdOffer) {
        super.init(frame: CGRect(origin: .zero, size: Self.preferredSize))
        setupViews()
        setupLayout()
        bind(offer: offer)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        backgroundColor = .systemBackground
        clipsToBounds = true

        mediaContainer.clipsToBounds = true
        mediaContainer.layer.cornerRadius = 6
        mediaContainer.backgroundColor = UIColor.secondarySystemFill
        addSubview(mediaContainer)

        iconImageView.contentMode = .scaleAspectFill
        iconImageView.clipsToBounds = true
        iconImageView.isUserInteractionEnabled = true
        mediaContainer.addSubview(iconImageView)

        mainImageView.contentMode = .scaleAspectFill
        mainImageView.clipsToBounds = true
        mainImageView.isUserInteractionEnabled = true
        mediaContainer.addSubview(mainImageView)

        titleLabel.font = .systemFont(ofSize: 13, weight: .bold)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 1
        titleLabel.isUserInteractionEnabled = true
        titleLabel.layer.shadowColor = UIColor.black.cgColor
        titleLabel.layer.shadowOpacity = 0.6
        titleLabel.layer.shadowRadius = 2
        titleLabel.layer.shadowOffset = .zero
        addSubview(titleLabel)

        adBadge.text = "广告"
        adBadge.font = .systemFont(ofSize: 9, weight: .bold)
        adBadge.textColor = .secondaryLabel
        adBadge.textAlignment = .center
        adBadge.layer.borderColor = UIColor.tertiaryLabel.cgColor
        adBadge.layer.borderWidth = 1 / UIScreen.main.scale
        adBadge.layer.cornerRadius = 2
        addSubview(adBadge)

        advertiserLabel.font = .systemFont(ofSize: 11, weight: .bold)
        advertiserLabel.textColor = .systemRed
        advertiserLabel.numberOfLines = 1
        advertiserLabel.isUserInteractionEnabled = true
        addSubview(advertiserLabel)

        textLabel.font = .systemFont(ofSize: 11, weight: .bold)
        textLabel.textColor = .white
        textLabel.numberOfLines = 1
        textLabel.isUserInteractionEnabled = true
        textLabel.isHidden = true
        addSubview(textLabel)

        ctaLabel.font = .systemFont(ofSize: 11, weight: .bold)
        ctaLabel.textColor = .white
        ctaLabel.backgroundColor = .systemRed
        ctaLabel.textAlignment = .center
        ctaLabel.layer.cornerRadius = 4
        ctaLabel.clipsToBounds = true
        ctaLabel.isUserInteractionEnabled = true
        addSubview(ctaLabel)

        ratingLabel.font = .systemFont(ofSize: 11, weight: .bold)
        ratingLabel.textColor = .white
        ratingLabel.isUserInteractionEnabled = true
        ratingLabel.isHidden = true
        addSubview(ratingLabel)

        domainLabel.font = .systemFont(ofSize: 9)
        domainLabel.textColor = .tertiaryLabel
        domainLabel.isUserInteractionEnabled = true
        addSubview(domainLabel)

        warningLabel.font = .systemFont(ofSize: 9)
        warningLabel.textColor = .tertiaryLabel
        warningLabel.isUserInteractionEnabled = true
        addSubview(warningLabel)

        logoImageView.contentMode = .scaleAspectFit
        logoImageView.isUserInteractionEnabled = true
        addSubview(logoImageView)

        let closeImage = UIImage(
            systemName: "xmark",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 13, weight: .bold)
        )
        dislikeButton.setImage(closeImage, for: .normal)
        dislikeButton.tintColor = .white
        dislikeButton.backgroundColor = UIColor.black.withAlphaComponent(0.01)
        dislikeButton.alpha = 0.01
        addSubview(dislikeButton)

        let topLine = UIView()
        topLine.backgroundColor = UIColor.separator
        topLine.translatesAutoresizingMaskIntoConstraints = false
        addSubview(topLine)
        NSLayoutConstraint.activate([
            topLine.topAnchor.constraint(equalTo: topAnchor),
            topLine.leadingAnchor.constraint(equalTo: leadingAnchor),
            topLine.trailingAnchor.constraint(equalTo: trailingAnchor),
            topLine.heightAnchor.constraint(equalToConstant: 1 / UIScreen.main.scale)
        ])
    }

    private func setupLayout() {
        [
            mediaContainer, iconImageView, mainImageView, titleLabel, adBadge,
            advertiserLabel, textLabel, ctaLabel, ratingLabel, domainLabel,
            warningLabel, logoImageView, dislikeButton
        ].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

        NSLayoutConstraint.activate([
            mediaContainer.topAnchor.constraint(equalTo: topAnchor),
            mediaContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            mediaContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            mediaContainer.bottomAnchor.constraint(equalTo: bottomAnchor),

            iconImageView.topAnchor.constraint(equalTo: mediaContainer.topAnchor),
            iconImageView.leadingAnchor.constraint(equalTo: mediaContainer.leadingAnchor),
            iconImageView.trailingAnchor.constraint(equalTo: mediaContainer.trailingAnchor),
            iconImageView.bottomAnchor.constraint(equalTo: mediaContainer.bottomAnchor),

            mainImageView.topAnchor.constraint(equalTo: mediaContainer.topAnchor),
            mainImageView.leadingAnchor.constraint(equalTo: mediaContainer.leadingAnchor),
            mainImageView.trailingAnchor.constraint(equalTo: mediaContainer.trailingAnchor),
            mainImageView.bottomAnchor.constraint(equalTo: mediaContainer.bottomAnchor),

            dislikeButton.topAnchor.constraint(equalTo: topAnchor),
            dislikeButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            dislikeButton.widthAnchor.constraint(equalToConstant: 44),
            dislikeButton.heightAnchor.constraint(equalToConstant: 44),

            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: ctaLabel.leadingAnchor, constant: -8),

            adBadge.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            adBadge.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -4),
            adBadge.widthAnchor.constraint(equalToConstant: 28),
            adBadge.heightAnchor.constraint(equalToConstant: 14),

            advertiserLabel.leadingAnchor.constraint(equalTo: adBadge.trailingAnchor, constant: 6),
            advertiserLabel.centerYAnchor.constraint(equalTo: adBadge.centerYAnchor),
            advertiserLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -44),

            ctaLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            ctaLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            ctaLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 56),
            ctaLabel.heightAnchor.constraint(equalToConstant: 24),

            logoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            logoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            logoImageView.widthAnchor.constraint(equalToConstant: 20),
            logoImageView.heightAnchor.constraint(equalToConstant: 20),

            domainLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            domainLabel.bottomAnchor.constraint(equalTo: adBadge.topAnchor, constant: -2),
            warningLabel.leadingAnchor.constraint(equalTo: domainLabel.trailingAnchor, constant: 6),
            warningLabel.centerYAnchor.constraint(equalTo: domainLabel.centerYAnchor),
            warningLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -44),

            textLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            textLabel.topAnchor.constraint(equalTo: topAnchor),
            textLabel.widthAnchor.constraint(equalToConstant: 0),
            textLabel.heightAnchor.constraint(equalToConstant: 0),
            ratingLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            ratingLabel.topAnchor.constraint(equalTo: topAnchor),
            ratingLabel.widthAnchor.constraint(equalToConstant: 0),
            ratingLabel.heightAnchor.constraint(equalToConstant: 0)
        ])

        bringSubviewToFront(logoImageView)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        if let mediaView {
            mediaView.frame = mediaContainer.bounds
        }
    }

    private func bind(offer: ATNativeAdOffer) {
        let material = offer.nativeAd

        titleLabel.text = material.title
        textLabel.text = material.mainText
        advertiserLabel.text = material.advertiser
        ctaLabel.text = {
            let text = material.ctaText?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            return text.isEmpty ? "查看" : text
        }()
        if let rating = material.rating, rating.doubleValue > 0 {
            ratingLabel.text = String(format: "%.1f", rating.doubleValue)
        } else {
            ratingLabel.text = nil
        }

        domainLabel.text = material.domain
        domainLabel.isHidden = (material.domain ?? "").isEmpty
        warningLabel.text = material.warning
        warningLabel.isHidden = (material.warning ?? "").isEmpty

        if let icon = material.icon {
            iconImageView.image = icon
        } else {
            loadImage(material.iconUrl, into: iconImageView)
        }

        if let mainImage = material.mainImage {
            mainImageView.image = mainImage
        } else {
            loadImage(material.imageUrl, into: mainImageView)
        }

        if let logo = material.logo {
            logoImageView.image = logo
        } else if let logoUrl = material.logoUrl, !logoUrl.isEmpty {
            loadImage(logoUrl, into: logoImageView)
        }
    }

    private func loadImage(_ urlString: String?, into imageView: UIImageView) {
        guard let urlString, !urlString.isEmpty, let url = URL(string: urlString) else { return }
        ATImageLoader.share().loadImage(with: url) { image, _ in
            DispatchQueue.main.async {
                imageView.image = image
            }
        }
    }
}

final class TADSelfRenderFeedHandle: NSObject, ObservableObject, ATNativeADDelegate {

    @Published private(set) var adView: ATNativeADView?
    @Published private(set) var overlayHeight: CGFloat = 0

    private var placementID = TADConfigHandler.selfRenderFeedPlacementID
    private var retryAttempt = 0
    private var isLoading = false
    private var selfRenderView: TADSelfRenderView?
    private var nativeAdOffer: ATNativeAdOffer?

    override init() {
        super.init()
    }

    deinit {
        adView?.destroyNative()
    }

    func load(placementID: String = TADConfigHandler.selfRenderFeedPlacementID) {
        guard !placementID.isEmpty else { return }
        guard !isLoading, adView == nil else { return }
        isLoading = true
        self.placementID = placementID
        let size = TADSelfRenderView.preferredSize
        ATAdManager.shared().loadAD(
            withPlacementID: placementID,
            extra: [
                kATExtraInfoNativeAdSizeKey: NSValue(cgSize: size),
                kATExtraInfoNativeAdTypeKey: NSNumber(value: ATGDTNativeAdType.selfRendering.rawValue)
            ],
            delegate: self
        )
    }

    func destroy() {
        adView?.destroyNative()
        adView?.removeFromSuperview()
        adView = nil
        overlayHeight = 0
        selfRenderView = nil
        nativeAdOffer = nil
        isLoading = false
    }

    func didFinishLoadingAD(withPlacementID placementID: String) {
        retryAttempt = 0
        DispatchQueue.main.async { [weak self] in
            self?.showAd()
        }
    }

    func didFailToLoadAD(withPlacementID placementID: String, error: Error) {
        guard retryAttempt < 3 else {
            DispatchQueue.main.async { [weak self] in
                self?.isLoading = false
            }
            return
        }
        retryAttempt += 1
        let delaySec = Int(pow(2.0, Double(min(3, retryAttempt))))
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delaySec)) { [weak self] in
            guard let self else { return }
            self.isLoading = false
            self.load(placementID: self.placementID)
        }
    }

    func didRevenue(forPlacementID placementID: String, extra: [AnyHashable: Any]) {}

    func didShowNativeAd(in adView: ATNativeADView, placementID: String, extra: [AnyHashable: Any]) {}

    func didTapCloseButton(in adView: ATNativeADView, placementID: String, extra: [AnyHashable: Any]) {
        DispatchQueue.main.async { [weak self] in
            self?.destroy()
        }
    }

    func didStartPlayingVideo(in adView: ATNativeADView, placementID: String, extra: [AnyHashable: Any]) {}

    func didEndPlayingVideo(in adView: ATNativeADView, placementID: String, extra: [AnyHashable: Any]) {}

    func didClickNativeAd(in adView: ATNativeADView, placementID: String, extra: [AnyHashable: Any]) {}

    func didDeepLinkOrJump(in adView: ATNativeADView, placementID: String, extra: [AnyHashable: Any], result: Bool) {}

    func didEnterFullScreenVideo(in adView: ATNativeADView, placementID: String, extra: [AnyHashable: Any]) {}

    func didExitFullScreenVideo(in adView: ATNativeADView, placementID: String, extra: [AnyHashable: Any]) {}

    func didCloseDetail(in adView: ATNativeADView, placementID: String, extra: [AnyHashable: Any]) {}

    private func showAd() {
        
        ATAdManager.shared().entryNativeScenario(withPlacementID: placementID, scene: "")
        guard ATAdManager.shared().nativeAdReady(forPlacementID: placementID) else {
            isLoading = false
            load(placementID: placementID)
            return
        }
        guard let offer = ATAdManager.shared().getNativeAdOffer(withPlacementID: placementID, scene: "") else {
            isLoading = false
            return
        }

        nativeAdOffer = offer
        let size = TADSelfRenderView.preferredSize
        ATAPI.sharedInstance().preferredAdLogoPosition = .bottomRightCorner

        let config = ATNativeADConfiguration()
        config.adFrame = CGRect(origin: .zero, size: size)
        config.mediaViewFrame = CGRect(origin: .zero, size: size)
        config.logoViewFrame = CGRect(x: 8, y: 8, width: 20, height: 20)
        config.delegate = self
        config.rootViewController = curController()
        config.sizeToFit = false

        let renderView = TADSelfRenderView(offer: offer)
        selfRenderView = renderView

        let nativeADView = ATNativeADView(
            configuration: config,
            currentOffer: offer,
            placementID: placementID
        )

        // 必须调用 getMediaView，否则 SDK 会走自动兜底渲染
        if let mediaView = nativeADView.getMediaView() {
            renderView.attachMediaView(mediaView)
        }

        var clickable: [UIView] = [
            renderView.iconImageView,
            renderView.titleLabel,
            renderView.textLabel,
            renderView.ctaLabel,
            renderView.mainImageView
        ]
        if renderView.advertiserLabel.text?.isEmpty == false {
            clickable.append(renderView.advertiserLabel)
        }
        nativeADView.registerClickableViewArray(clickable)

        let info = ATNativePrepareInfo.load { prepareInfo in
            prepareInfo.titleLabel = renderView.titleLabel
            prepareInfo.textLabel = renderView.textLabel
            prepareInfo.advertiserLabel = renderView.advertiserLabel
            prepareInfo.ctaLabel = renderView.ctaLabel
            prepareInfo.ratingLabel = renderView.ratingLabel
            prepareInfo.iconImageView = renderView.iconImageView
            prepareInfo.mainImageView = renderView.mainImageView
            prepareInfo.logoImageView = renderView.logoImageView
            prepareInfo.dislikeButton = renderView.dislikeButton
            prepareInfo.domainLabel = renderView.domainLabel
            prepareInfo.warningLabel = renderView.warningLabel
            if let mediaView = renderView.mediaView {
                prepareInfo.mediaView = mediaView
            }
        }
        nativeADView.prepare(with: info)

        offer.renderer(with: config, selfRenderView: renderView, nativeADView: nativeADView)

        if let mediaView = nativeADView.getMediaView() {
            renderView.attachMediaView(mediaView)
        }
        nativeADView.clipsToBounds = true
        nativeADView.frame = CGRect(origin: .zero, size: size)
        isLoading = false
        adView = nativeADView
        overlayHeight = size.height
    }
    
    private func curController() -> UIViewController? {
        let window = AppWindow.current
        var topViewController = window?.rootViewController

        while true {
            if let topVC = topViewController?.presentedViewController {
                topViewController = topVC
            } else if let topNavi = topViewController as? UINavigationController, let topVC = topNavi.topViewController {
                topViewController = topVC
            } else if let topTab = topViewController as? UITabBarController {
                topViewController = topTab.selectedViewController
            } else {
                break
            }
        }
        
        return topViewController
    }
}
