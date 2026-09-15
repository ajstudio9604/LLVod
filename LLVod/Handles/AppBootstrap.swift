import SwiftUI
import Combine

@MainActor
final class AppBootstrap: ObservableObject {

    static let shared = AppBootstrap()
    private var channelStore = ChannelStore.shared
    private var cancellables = Set<AnyCancellable>()
    
    enum State {
        case idle
        case loading
        case ready
        case failed
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
 

    func setup() {
        let isSuccess: Bool = channelStore.validateSuccess()
        if isSuccess {
            setupLoadingSuccess()
        } else {
            state = .idle
        }
    }
    
    func setupLoading() {
        state = .loading

    }
    
    func setupLoadingFailed() {
        state = .failed
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
