import SwiftUI
import Combine

@MainActor
final class AppBootstrap: ObservableObject {

    static let shared = AppBootstrap()
    private var cancellables = Set<AnyCancellable>()

    // 启动状态：编号门禁已移除，只保留加载中和就绪
    enum State {
        case loading
        case ready
    }

    @Published private(set) var state: State = .loading

    private init() {
        setupLoading()
        NetworkMonitor.shared.$isConnected
                    .removeDuplicates()
                    .filter { $0 }
                    .sink { [weak self] _ in
                        self?.checkAppStoreAndLoadConfig()
                    }
                    .store(in: &cancellables)
    }

    private func checkAppStoreAndLoadConfig() {
        guard let url = URL(string: "https://itunes.apple.com/lookup?id=594429562") else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in

        }.resume()
    }


    // 启动时直接初始化服务并进入主流程，不再校验本地编号
    func setup() {
        setupLoadingSuccess()
    }

    func setupLoading() {
        state = .loading

    }

    func setupLoadingSuccess() {
        prepareServices()
        state = .ready
    }

    private func prepareServices() {
        TADConfigHandler.config()
        UIApplication.shared.isIdleTimerDisabled = true
    }
}
