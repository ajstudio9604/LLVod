import SwiftUI
import Kingfisher

struct CachedAsyncImageView: View {
    let url: URL?
    var contentMode: SwiftUI.ContentMode = .fill
    @State private var failed = false
    
    var body: some View {
        Group {
            if let url, !failed {
                KFImage(url)
                    .requestModifier(
                        AnyModifier { request in
                            var request = request
                            
                            request.setValue(
                                "PostmanRuntime/7.37.0",
                                forHTTPHeaderField: "User-Agent"
                            )
                            
                            if url.absoluteString.contains("douban") {
                                request.setValue(
                                    "https://movie.douban.com",
                                    forHTTPHeaderField: "Referer"
                                )
                            }
                            return request
                        }
                    )
                    .placeholder {
                        placeholderView
                    }
                    .onFailure { _ in
                        failed = true
                    }
                    .fade(duration: 0.3)
                    .resizable()
                    .aspectRatio(contentMode: contentMode)
            } else {
                placeholderView
            }
        }
    }
    
    private var placeholderView: some View {
        // 加载中、地址为空或请求失败时使用纯色占位，避免以空名称查找图片资源。
        Color(.secondarySystemFill)
    }
}

#Preview {
    CachedAsyncImageView(url: URL(string: ""))
}
