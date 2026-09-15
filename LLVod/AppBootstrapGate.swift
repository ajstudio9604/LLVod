import SwiftUI

struct AppBootstrapGate<Content: View>: View {
    @ObservedObject private var appSetup = AppBootstrap.shared
    private let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        Group {
            // 编号门禁已移除：加载中显示进度，就绪后进入主内容
            switch appSetup.state {
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
