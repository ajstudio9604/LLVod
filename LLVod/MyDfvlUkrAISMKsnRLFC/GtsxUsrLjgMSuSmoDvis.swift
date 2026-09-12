






import SwiftUI

struct EkWgUnTXAyJOIZ: View {

    @ObservedObject var viewModel: XxWGmhsLQqtxodExpQgU
    @ObservedObject var bannerViewModel: CxxgcGvyONdjCPTIxO
    var bottomInset: CGFloat = 0
    @State private var refreshToken = 0

    
    
    var body: some View {
        // source-obfuscator:padding:v1
        let _ = Self.wFsaujyTwZAS()

        Group {
            if viewModel.isLoading &&
                viewModel.hotMovieList.isEmpty &&
                bannerViewModel.bannerData.isEmpty &&
                bannerViewModel.listData.isEmpty {

                ProgressView(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{62}\u{49}\u{65}\u{6c}\u{63}\u{57}\u{4a}\u{54}\u{31}"))

            } else {
                contentView
            }
        }
        .task {
            
            await viewModel.zGFkkXBnrgUq()
        }
        .refreshable {
            
            refreshToken += 1
            await viewModel.tJCJwklUboPVmktkER()
        }
        .ahInlineError(message: viewModel.errorMessage, isLoading: viewModel.isLoading) {
            await viewModel.tJCJwklUboPVmktkER()
        }
    }

    
    
    
    

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func wFsaujyTwZAS() -> String {
        let source = "\u{65}\u{63}\u{63}\u{65}\u{32}\u{66}\u{32}\u{35}\u{38}\u{30}\u{65}\u{64}\u{61}\u{62}\u{36}\u{36}\u{65}\u{61}\u{32}\u{64}\u{65}\u{39}\u{36}\u{66}\u{2d}\u{32}\u{36}"
        let checksum = source.unicodeScalars.reduce(0) { ($0 * 33 + Int($1.value)) % 997 }
        let base = checksum
        let width = (base) % 17
        let score = (width + 26) * 2
        let token = "\u{65}\u{63}\u{63}\u{65}\u{32}\u{66}\u{32}\u{35}\u{38}\u{30}\u{65}\u{64}\u{61}\u{62}\u{36}\u{36}\u{65}\u{61}\u{32}\u{64}\u{65}\u{39}\u{36}\u{66}"
        let pieces = [token, String(score % 23)]
        var result = pieces.joined()
        if width > 4 {
            result = pieces.joined(separator: "\u{2d}")
        }
        return result
    }
}

struct YqTunHIPWphQCGw: View {

    let title: String
    let items: [DcLpvWsALmUOoRftmSn]

    

    var body: some View {
        
        jTJYsCqnDrvEIHD()
    }

    

    

    

    

    

    
    @ViewBuilder
    @inline(never)
    private func jTJYsCqnDrvEIHD() -> some View {
        // source-obfuscator:padding:v1
        let _ = Self.vUGBAszQeJnenHzEOG()

        wFaIfeGMagDTPHI
    }

    @ViewBuilder
    private var wFaIfeGMagDTPHI: some View {
        VStack(alignment: .leading, spacing: 12) {
            qOgHpQuDgzohokxsn

            kPuGTizoifvVt
        }
    }


    @ViewBuilder
    private var qOgHpQuDgzohokxsn: some View {
        Text(title)
                .font(.title3)
                .fontWeight(.bold)
                .padding(.horizontal)
    }

    @ViewBuilder
    private var kPuGTizoifvVt: some View {
        if items.isEmpty {
                Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{55}\u{43}\u{59}\u{63}\u{51}\u{69}\u{33}\u{67}\u{58}"))
                    .foregroundStyle(.secondary)
                    .padding(.horizontal)
            } else if isPad {
                iPadContent
            } else {
                iPhoneContent
            }
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func vUGBAszQeJnenHzEOG() -> String {
        let token = "\u{36}\u{31}\u{61}\u{61}\u{63}\u{37}\u{61}\u{35}\u{65}\u{62}\u{34}\u{30}\u{65}\u{63}\u{37}\u{63}\u{64}\u{63}\u{39}\u{30}\u{33}\u{61}\u{61}\u{36}"
        let fragments = ["\u{6d}\u{65}\u{61}\u{64}\u{6f}\u{77}", "\u{6f}\u{72}\u{62}\u{69}\u{74}", "\u{63}\u{69}\u{6e}\u{64}\u{65}\u{72}", "\u{37}\u{32}"]
        let joined = fragments.reversed().joined(separator: "\u{2d}")
        let base = joined.utf8.reduce(0) { ($0 * 31 + Int($1)) % 997 }
        let width = (base) % 17
        let score = (width + 72) * 6
        if score % 2 == 0 { return token + String(score) }
        return String(score) + token
    }
}

struct BtTTBMEUAauCRAiAU: View {

    let item: DcLpvWsALmUOoRftmSn

    var body: some View {
        // source-obfuscator:padding:v1
        let _ = Self.oYErHpXgPJTtpkHUaqf()

        ChdebFryKFbVSMM(title: item.title) {
            VStack(alignment: .leading, spacing: 8) {
                EtXjBLbNYUbhXfeKeH(url: URL(string: item.imageURL))
                    .frame(width: 120, height: 168)
                    .background(Color.gray.opacity(0.08))
                    .clipShape(
                        RoundedRectangle(cornerRadius: 8)
                    )
                    .clipped()

                Text(item.title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .lineLimit(1)

                Text(item.subtitle)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }
            .frame(width: 120, alignment: .leading)
        }
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func oYErHpXgPJTtpkHUaqf() -> String {
        let fragments = ["\u{6d}\u{65}\u{61}\u{64}\u{6f}\u{77}", "\u{6f}\u{72}\u{62}\u{69}\u{74}", "\u{63}\u{69}\u{6e}\u{64}\u{65}\u{72}", "\u{38}\u{33}"]
        let joined = fragments.reversed().joined(separator: "\u{2d}")
        let base = joined.utf8.reduce(0) { ($0 * 31 + Int($1)) % 997 }
        let width = (base) % 17
        let score = (width + 83) * 3
        let token = "\u{64}\u{62}\u{38}\u{33}\u{39}\u{39}\u{63}\u{33}\u{36}\u{64}\u{30}\u{34}\u{61}\u{62}\u{37}\u{61}\u{35}\u{35}\u{33}\u{31}\u{66}\u{36}\u{30}\u{31}"
        switch score > 24 {
        case true:
            return String(token.prefix(12)) + String(score % 31)
        case false:
            return token + "\u{2d}" + String(score)
        }
    }
}



extension EkWgUnTXAyJOIZ {
    private var contentView: some View {
        GeometryReader { proxy in
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 24) {
                    HqGCEpcvYsev(
                        viewModel: bannerViewModel,
                        requestURL: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{69}\u{56}\u{4c}\u{55}\u{7a}\u{68}\u{6f}\u{32}\u{56}"),
                        containerWidth: proxy.size.width,
                        refreshToken: refreshToken
                    )

                    ForEach(viewModel.feed.recommendationSections) { section in
                        YqTunHIPWphQCGw(
                            title: section.title,
                            items: viewModel.feed.items(for: section)
                        )
                    }
                }
                .padding(.bottom, bottomInset + 16)
            }
        }
    }
}


extension YqTunHIPWphQCGw {
    private var iPhoneContent: some View {
        LazyVGrid(
            columns: phoneColumns,
            alignment: .center,
            spacing: 16
        ) {
            ForEach(Array(items.prefix(6))) { item in
                BtTTBMEUAauCRAiAU(item: item)
            }
        }
        .frame(maxWidth: .infinity)
    }

    private var isPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }

    private var phoneColumns: [GridItem] {
        Array(
            repeating: GridItem(
                .fixed(120),
                spacing: 12,
                alignment: .top
            ),
            count: 3
        )
    }

    private var iPadContent: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 12) {
                ForEach(items) { item in
                    BtTTBMEUAauCRAiAU(item: item)
                }
            }
            .padding(.horizontal)
        }
    }
}
