import SwiftUI

struct AppBootstrapGate<Content: View>: View {
    @ObservedObject private var appSetup = AppBootstrap.shared
    private let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        Group {
            switch appSetup.state {
            case .idle, .failed:
                AHChannelVerifyView()
            case .loading:
                ProgressView("")
            case .ready:
                content
            }
        }
        .task {
            appSetup.setup()
        }
    }
}
