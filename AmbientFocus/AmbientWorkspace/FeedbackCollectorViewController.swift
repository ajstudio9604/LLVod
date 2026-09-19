import MessageUI
import UIKit

/// 普通反馈由用户通过邮件确认发送，验证成功的内容不会进入邮件。
final class FeedbackCollectorViewController: UIViewController, UITextViewDelegate, MFMailComposeViewControllerDelegate {
    private let input = UITextView()
    private let placeholder = UILabel()
    private let counter = AmbientStyle.label("0 / 2000", size: 12)
    private let submit = UIButton(type: .system)
    private let inputPanel = UIView()
    // FB1 文字直接覆盖场景，辅助文案采用较高不透明度保持可读。
    private let secondaryText = AmbientStyle.text.withAlphaComponent(0.80)
    private var infoRows: [(stack: UIStackView, value: UILabel)] = []
    private var isSubmitting = false

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "意见与建议"
        // 从空间页推入后透出同一张场景封面，不再创建背景播放器或额外模糊层。
        view.backgroundColor = .clear
        AmbientPageUI.useTransparentNavigation(on: self)
        let heading = AmbientStyle.label("让专注体验更好一点", size: 25, weight: .semibold)
        heading.font = UIFontMetrics(forTextStyle: .title2).scaledFont(for: AmbientStyle.pingFang(size: 25, weight: .medium))
        heading.accessibilityTraits = .header
        let detail = AmbientStyle.label("欢迎留下使用感受或改进建议。点击下方按钮后，请在邮件界面确认收件人和内容，再发送反馈。", size: 14)
        detail.textColor = secondaryText

        // 通透输入区只保留细描边；计数单独占位，输入滚动时也不会覆盖它。
        inputPanel.layer.cornerRadius = 14
        inputPanel.layer.cornerCurve = .continuous
        inputPanel.layer.borderWidth = 1
        input.backgroundColor = .clear
        input.textColor = AmbientStyle.text
        input.tintColor = AmbientStyle.text
        input.font = .preferredFont(forTextStyle: .body)
        input.adjustsFontForContentSizeCategory = true
        input.textContainerInset = UIEdgeInsets(top: 14, left: 10, bottom: 8, right: 10)
        input.accessibilityLabel = "反馈内容"
        input.accessibilityHint = "请输入一到两千字的意见或建议"
        input.delegate = self
        input.autocorrectionType = .no
        input.smartQuotesType = .no
        input.smartDashesType = .no
        placeholder.text = "写下你遇到的问题，或希望改进的地方"
        placeholder.textColor = secondaryText
        placeholder.font = input.font
        placeholder.adjustsFontForContentSizeCategory = true
        placeholder.numberOfLines = 0
        placeholder.setContentCompressionResistancePriority(.required, for: .vertical)
        placeholder.isAccessibilityElement = false
        counter.textColor = secondaryText
        counter.textAlignment = .right
        counter.font = UIFontMetrics.default.scaledFont(for: .monospacedDigitSystemFont(ofSize: 12, weight: .regular))
        for item in [input, placeholder, counter] {
            item.translatesAutoresizingMaskIntoConstraints = false
            inputPanel.addSubview(item)
        }
        // 常规字号下接近预览的 190 点，大字号占位说明需要更多空间时可自然增高。
        let preferredInputHeight = inputPanel.heightAnchor.constraint(equalToConstant: 190)
        preferredInputHeight.priority = .defaultLow
        NSLayoutConstraint.activate([
            inputPanel.heightAnchor.constraint(greaterThanOrEqualToConstant: 190), preferredInputHeight,
            input.leadingAnchor.constraint(equalTo: inputPanel.leadingAnchor, constant: 6),
            input.trailingAnchor.constraint(equalTo: inputPanel.trailingAnchor, constant: -6),
            input.topAnchor.constraint(equalTo: inputPanel.topAnchor),
            input.bottomAnchor.constraint(equalTo: counter.topAnchor, constant: -8),
            input.heightAnchor.constraint(greaterThanOrEqualToConstant: 120),
            placeholder.leadingAnchor.constraint(equalTo: inputPanel.leadingAnchor, constant: 20),
            placeholder.trailingAnchor.constraint(equalTo: inputPanel.trailingAnchor, constant: -20),
            placeholder.topAnchor.constraint(equalTo: inputPanel.topAnchor, constant: 16),
            placeholder.bottomAnchor.constraint(lessThanOrEqualTo: input.bottomAnchor, constant: -8),
            counter.leadingAnchor.constraint(greaterThanOrEqualTo: inputPanel.leadingAnchor, constant: 16),
            counter.trailingAnchor.constraint(equalTo: inputPanel.trailingAnchor, constant: -16),
            counter.bottomAnchor.constraint(equalTo: inputPanel.bottomAnchor, constant: -12)
        ])

        // 发送信息采用开放式键值列表，与空间页保持相同的标题层级和细分隔线。
        let infoTitle = AmbientStyle.label("发送信息", size: 17, weight: .semibold)
        infoTitle.textColor = AmbientStyle.accent
        infoTitle.accessibilityTraits = .header
        let rows = UIStackView()
        rows.axis = .vertical
        let items = [("收件邮箱", FeedbackMailConfiguration.recipient)] + FeedbackMailConfiguration.diagnosticItems
        for item in items {
            rows.addArrangedSubview(makeInfoRow(title: item.0, value: item.1))
        }
        let infoNote = AmbientStyle.label("以上信息会附在邮件末尾，你可以在邮件界面删改。", size: 12)
        infoNote.textColor = secondaryText

        configureSubmitButton()
        submit.heightAnchor.constraint(greaterThanOrEqualToConstant: 52).isActive = true
        submit.addTarget(self, action: #selector(submitFeedback), for: .touchUpInside)
        let stack = UIStackView(arrangedSubviews: [heading, detail, inputPanel, infoTitle, rows, infoNote, submit])
        stack.axis = .vertical
        stack.alignment = .fill
        stack.spacing = 12
        stack.setCustomSpacing(6, after: heading)
        stack.setCustomSpacing(18, after: detail)
        stack.setCustomSpacing(22, after: inputPanel)
        stack.setCustomSpacing(8, after: infoTitle)
        stack.setCustomSpacing(8, after: rows)
        stack.setCustomSpacing(20, after: infoNote)
        stack.translatesAutoresizingMaskIntoConstraints = false
        let scroll = UIScrollView()
        scroll.keyboardDismissMode = .interactive
        // 点击输入框以外的空白处收起键盘；不拦截触摸，按钮和文本框照常响应。
        let dismissTap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        dismissTap.cancelsTouchesInView = false
        scroll.addGestureRecognizer(dismissTap)
        scroll.contentInsetAdjustmentBehavior = .never
        scroll.showsVerticalScrollIndicator = false
        scroll.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scroll)
        // 内容容器四边连接滚动内容区，宽度固定为可视区，避免横向尺寸由多行文字反推。
        let content = UIView()
        content.translatesAutoresizingMaskIntoConstraints = false
        scroll.addSubview(content)
        content.addSubview(stack)
        // 页面宽度优先于文字的抗压缩约束，仅在达到宽屏上限时让步。
        let width = stack.widthAnchor.constraint(equalTo: content.widthAnchor, constant: -40)
        width.priority = UILayoutPriority(999)
        // 优先铺到内容安全区底部，键盘出现时再上移，邮件按钮始终可滚动到浮动底栏上方。
        let bottom = scroll.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        bottom.priority = .defaultHigh
        NSLayoutConstraint.activate([
            scroll.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scroll.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scroll.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            bottom,
            scroll.bottomAnchor.constraint(lessThanOrEqualTo: view.keyboardLayoutGuide.topAnchor),
            content.leadingAnchor.constraint(equalTo: scroll.contentLayoutGuide.leadingAnchor),
            content.trailingAnchor.constraint(equalTo: scroll.contentLayoutGuide.trailingAnchor),
            content.topAnchor.constraint(equalTo: scroll.contentLayoutGuide.topAnchor),
            content.bottomAnchor.constraint(equalTo: scroll.contentLayoutGuide.bottomAnchor),
            content.widthAnchor.constraint(equalTo: scroll.frameLayoutGuide.widthAnchor),
            stack.topAnchor.constraint(equalTo: content.topAnchor, constant: 16),
            stack.bottomAnchor.constraint(equalTo: content.bottomAnchor, constant: -24),
            stack.centerXAnchor.constraint(equalTo: content.centerXAnchor),
            stack.leadingAnchor.constraint(greaterThanOrEqualTo: content.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(lessThanOrEqualTo: content.trailingAnchor, constant: -20),
            width, stack.widthAnchor.constraint(lessThanOrEqualToConstant: 620)
        ])
        updateAppearance()
        updateInfoLayout()
        textViewDidChange(input)
    }

    func textViewDidChange(_ textView: UITextView) {
        let count = textView.text.count
        placeholder.isHidden = count > 0
        counter.text = "\(count) / 2000"
        counter.textColor = count > 2000 ? .systemRed : secondaryText
        submit.isEnabled = !isSubmitting && isSubmittable(textView.text)
    }

    /// 不含空白字符的有效长度至少 3 个字符且总长不超过 2000 时才允许提交。
    private func isSubmittable(_ text: String) -> Bool {
        let effective = text.filter { !$0.isWhitespace && !$0.isNewline }.count
        return effective >= 3 && text.count <= 2000
    }

    @objc private func submitFeedback() {
        guard !isSubmitting, presentedViewController == nil,
              let text = input.text, isSubmittable(text) else { return }
        isSubmitting = true
        submit.isEnabled = false
        input.resignFirstResponder()
        // 邮件发送尚未正式启用：先模拟提交，延时 1.5 秒后提示成功。正式接入时把 simulatesSubmission 改为 false 即回到邮件流程。
        if FeedbackMailConfiguration.simulatesSubmission {
            simulateSubmission()
            return
        }
        let recipient = FeedbackMailConfiguration.recipient.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !recipient.isEmpty, !recipient.lowercased().hasSuffix(".invalid") else {
            finishSubmission()
            AmbientStyle.message(on: self, title: "暂时无法发送", text: "反馈邮箱暂未开放，请稍后再试。你的输入已保留。")
            return
        }
        // 正文末尾附上诊断信息，用户在邮件界面可见并可删改。
        let body = FeedbackMailConfiguration.body(feedback: text)
        guard MFMailComposeViewController.canSendMail() else {
            openMailApplication(recipient: recipient, body: body)
            return
        }
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients([recipient])
        composer.setSubject(FeedbackMailConfiguration.subject)
        composer.setMessageBody(body, isHTML: false)
        // 通过明确的取消、保存或发送操作退出，确保提交状态得到对应回调。
        composer.isModalInPresentation = true
        present(composer, animated: true)
    }

    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true) { [weak self] in
            guard let self else { return }
            if error != nil {
                self.finishSubmission()
                AmbientStyle.message(on: self, title: "发送未完成", text: "邮件未能提交，请稍后重试。你的输入已保留。")
                return
            }
            // 系统的发送结果仅代表邮件进入发件箱，不能视为收件人已经收到。
            if result == .sent { self.input.text = "" }
            self.finishSubmission()
            switch result {
            case .sent:
                AmbientStyle.message(on: self, title: "感谢你的反馈", text: "邮件已交由系统发送，请在邮件应用中查看发送状态。")
            case .saved:
                AmbientStyle.message(on: self, title: "草稿已保存", text: "反馈尚未发送，你可以在邮件应用的草稿箱中继续编辑。")
            case .cancelled:
                break
            case .failed:
                AmbientStyle.message(on: self, title: "发送未完成", text: "邮件未能提交，请稍后重试。你的输入已保留。")
            @unknown default:
                AmbientStyle.message(on: self, title: "请确认发送状态", text: "暂时无法确认结果，请在邮件应用中查看。你的输入已保留。")
            }
        }
    }

    /// 描边邮件按钮沿用系统状态管理，空内容及提交期间显示禁用样式。
    private func configureSubmitButton() {
        var configuration = UIButton.Configuration.plain()
        configuration.title = "通过邮件反馈"
        configuration.image = UIImage(systemName: "envelope")
        configuration.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 18, weight: .light)
        configuration.imagePadding = 10
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 14, leading: 20, bottom: 14, trailing: 20)
        configuration.cornerStyle = .fixed
        configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { attributes in
            var result = attributes
            result.font = UIFontMetrics(forTextStyle: .headline).scaledFont(for: .systemFont(ofSize: 17, weight: .medium))
            return result
        }
        submit.configuration = configuration
        submit.titleLabel?.numberOfLines = 0
        submit.titleLabel?.adjustsFontForContentSizeCategory = true
        submit.configurationUpdateHandler = { button in
            guard var configuration = button.configuration else { return }
            // 可用态与"发送信息"标题同用强调色，文字、图标和描边一起变色；禁用态保持淡色。
            configuration.baseForegroundColor = button.isEnabled ? AmbientStyle.accent : AmbientStyle.text.withAlphaComponent(0.40)
            configuration.background.backgroundColor = button.isHighlighted ? AmbientStyle.accent.withAlphaComponent(0.12) : .clear
            configuration.background.cornerRadius = 14
            configuration.background.strokeWidth = 1
            configuration.background.strokeColor = button.isEnabled ? AmbientStyle.accent : AmbientStyle.text.withAlphaComponent(0.28)
            button.configuration = configuration
        }
    }

    /// 图层颜色需要在主题切换后重新解析，避免深浅主题之间残留旧描边。
    private func updateAppearance() {
        inputPanel.layer.borderColor = AmbientStyle.text.withAlphaComponent(0.60).resolvedColor(with: traitCollection).cgColor
        submit.setNeedsUpdateConfiguration()
    }

    /// 辅助功能大字号下上下排列键值，避免邮箱与系统信息被窄屏挤压。
    private func updateInfoLayout() {
        let usesVerticalLayout = traitCollection.preferredContentSizeCategory.isAccessibilityCategory
        for row in infoRows {
            row.stack.axis = usesVerticalLayout ? .vertical : .horizontal
            row.stack.alignment = usesVerticalLayout ? .leading : .firstBaseline
            row.stack.spacing = usesVerticalLayout ? 4 : 16
            row.value.textAlignment = usesVerticalLayout ? .left : .right
        }
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard isViewLoaded else { return }
        updateAppearance()
        updateInfoLayout()
    }

    /// 键值行：左侧标题用次要色，右侧值右对齐可换行，行间用细线分隔。
    private func makeInfoRow(title: String, value: String) -> UIView {
        let row = UIView()
        let titleLabel = AmbientStyle.label(title, size: 14)
        titleLabel.textColor = secondaryText
        titleLabel.setContentHuggingPriority(.required, for: .horizontal)
        titleLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        let valueLabel = AmbientStyle.label(value, size: 14)
        valueLabel.textAlignment = .right
        valueLabel.font = UIFontMetrics.default.scaledFont(for: .monospacedDigitSystemFont(ofSize: 14, weight: .regular))
        let line = UIStackView(arrangedSubviews: [titleLabel, valueLabel])
        line.alignment = .firstBaseline
        line.spacing = 16
        line.translatesAutoresizingMaskIntoConstraints = false
        row.addSubview(line)
        infoRows.append((stack: line, value: valueLabel))
        NSLayoutConstraint.activate([
            line.leadingAnchor.constraint(equalTo: row.leadingAnchor),
            line.trailingAnchor.constraint(equalTo: row.trailingAnchor),
            line.topAnchor.constraint(equalTo: row.topAnchor, constant: 8),
            line.bottomAnchor.constraint(equalTo: row.bottomAnchor, constant: -8)
        ])
        let divider = UIView()
        divider.backgroundColor = AmbientStyle.hairline
        divider.translatesAutoresizingMaskIntoConstraints = false
        row.addSubview(divider)
        NSLayoutConstraint.activate([
            divider.leadingAnchor.constraint(equalTo: row.leadingAnchor),
            divider.trailingAnchor.constraint(equalTo: row.trailingAnchor),
            divider.bottomAnchor.constraint(equalTo: row.bottomAnchor),
            divider.heightAnchor.constraint(equalToConstant: 1 / UIScreen.main.scale)
        ])
        row.isAccessibilityElement = true
        row.accessibilityLabel = "\(title)，\(value)"
        return row
    }

    private func finishSubmission() {
        isSubmitting = false
        submit.configuration?.showsActivityIndicator = false
        submit.configuration?.title = "通过邮件反馈"
        textViewDidChange(input)
    }

    @objc private func dismissKeyboard() { view.endEditing(true) }

    /// 模拟提交：按钮进入加载态，1.5 秒后清空输入并提示成功。
    private func simulateSubmission() {
        submit.configuration?.showsActivityIndicator = true
        submit.configuration?.title = "提交中"
        Task { @MainActor [weak self] in
            try? await Task.sleep(nanoseconds: 1_500_000_000)
            guard let self, self.viewIfLoaded?.window != nil else { return }
            self.input.text = ""
            self.finishSubmission()
            AmbientStyle.message(on: self, title: "反馈成功", text: "感谢你的反馈，我们会认真阅读每一条建议。")
        }
    }

    /// 未配置系统邮件账户时，尝试交给邮件应用；打开成功不代表邮件已经发出。
    private func openMailApplication(recipient: String, body: String) {
        var components = URLComponents()
        components.scheme = "mailto"
        components.path = recipient
        components.queryItems = [
            URLQueryItem(name: "subject", value: FeedbackMailConfiguration.subject),
            URLQueryItem(name: "body", value: body)
        ]
        // 显式编码加号，避免部分邮件客户端将其解释为空格。
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        guard let url = components.url else {
            finishSubmission()
            showMailUnavailable(body: body)
            return
        }
        UIApplication.shared.open(url, options: [:]) { [weak self] opened in
            Task { @MainActor in
                guard let self else { return }
                // 外部应用没有发送结果回调，因此始终保留原文供用户返回后继续使用。
                self.finishSubmission()
                if !opened { self.showMailUnavailable(body: body) }
            }
        }
    }

    private func showMailUnavailable(body: String) {
        guard viewIfLoaded?.window != nil, presentedViewController == nil else { return }
        let alert = UIAlertController(title: "无法打开邮件",
                                      message: "请安装邮件应用并配置账户后重试，也可以先复制反馈内容。",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "复制反馈内容", style: .default) { _ in
            // 仅在用户主动选择复制时写入剪贴板。
            UIPasteboard.general.string = body
        })
        alert.addAction(UIAlertAction(title: "返回", style: .cancel))
        present(alert, animated: true)
    }
}

/// 收件邮箱与主题在此维护；若临时停用，把收件人改为 .invalid 结尾的占位地址即可阻止发送。
private enum FeedbackMailConfiguration {
    /// 为 true 时不发邮件，只模拟提交；正式接入时改为 false。
    static let simulatesSubmission = true
    static let recipient = "lseoabylg.mdheotqau153@gmx.com"
    static var subject: String { AmbientAppInfo.name + "使用反馈" }

    /// 诊断信息：应用版本、系统版本、设备型号与语言；页面键值行与邮件正文共用同一份数据。
    static var diagnosticItems: [(String, String)] {
        [("应用", "\(AmbientAppInfo.name) \(AmbientAppInfo.version)"),
         ("系统", "iOS \(UIDevice.current.systemVersion)"),
         ("设备", deviceModel)]
    }

    static var diagnostics: String {
        diagnosticItems.map { "\($0.0)：\($0.1)" }.joined(separator: "\n")
    }

    /// 反馈原文加分隔线与诊断信息。
    static func body(feedback: String) -> String {
        "\(feedback)\n\n——\n\(diagnostics)"
    }

    /// 读取硬件型号标识，例如 iPhone16,2；模拟器上返回 x86_64 或 arm64。
    private static var deviceModel: String {
        var system = utsname()
        uname(&system)
        return withUnsafePointer(to: &system.machine) {
            $0.withMemoryRebound(to: CChar.self, capacity: 1) { String(cString: $0) }
        }
    }
}
