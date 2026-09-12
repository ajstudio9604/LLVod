






import SwiftUI

struct UuEWVnpfCwzLUqS: View {

    @ObservedObject var viewModel: HjMioZPzBLELiDyx
    let comment: RvGGzFHfQwFzCOaegZ
    let nSNDGzfjraUKxmGGgWas: () -> Void

    @State private var isExpanded = false

    private let collapsedReplyLimit = 2

    var body: some View {
        
        uJgrtcvaEuKXOaQX()
    }

    

    

    

    

    @ViewBuilder
    private func gFKEZyuJiQAMMIvcKK(for target: RvGGzFHfQwFzCOaegZ) -> some View {
        // source-obfuscator:padding:v1
        let _ = Self.rSCVNoMKOugKVhZiW()

        if viewModel.tMTijFKLXjIBLvzGKyPo(target) {
            Button(role: .destructive) {
                Task { await viewModel.delete(target) }
            } label: {
                Label(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6b}\u{67}\u{41}\u{45}\u{63}\u{4d}\u{48}\u{48}\u{73}"), systemImage: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{53}\u{6b}\u{79}\u{6b}\u{6c}\u{74}\u{49}\u{33}\u{58}"))
            }
        }
    }

    
    @ViewBuilder
    @inline(never)
    private func uJgrtcvaEuKXOaQX() -> some View {
        aComoxfbePATbm
    }

    @ViewBuilder
    private var aComoxfbePATbm: some View {
        VStack(alignment: .leading, spacing: 10) {
            kFvmNbjuGSNu

            rKvSxOWIecjeZKRNz

            gJkCcTsmFCinGxlLHHcC

            wBGMdGpxglaCPPtzCbHw
        }
        .contextMenu {
            gFKEZyuJiQAMMIvcKK(for: comment)
        }
        .task {
            
            guard comment.replyCount > 0, replyList.isEmpty else { return }
            await viewModel.qMUmNUaVEghpJHunb(forRootId: comment.id)
        }
    }


    @ViewBuilder
    private var gJkCcTsmFCinGxlLHHcC: some View {
        HStack {
                Text(comment.relativeTime)
                    .font(.system(size: 11))
                    .foregroundColor(.secondary)

                Spacer(minLength: 0)

                uQUbdicRkEWRtZ(for: comment, showsIcon: true)
            }
    }

    @ViewBuilder
    private var kFvmNbjuGSNu: some View {
        HStack(spacing: 10) {
                GlMabcCxtASnmbkI(url: comment.avatarURL, size: 30)

                Text(comment.displayName)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.primary)
                    .lineLimit(1)

                Spacer(minLength: 0)
            }
    }

    @ViewBuilder
    private var wBGMdGpxglaCPPtzCbHw: some View {
        if !replyList.isEmpty {
                repliesSection
            }
    }

    @ViewBuilder
    private var rKvSxOWIecjeZKRNz: some View {
        Text(comment.content)
                .font(.system(size: 14))
                .foregroundColor(.primary)
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity, alignment: .leading)
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func rSCVNoMKOugKVhZiW() -> String {
        let base = (43 * 8 + 19) % 997
        let width = (base) % 17
        let score = (width + 43) * 8
        let token = "\u{32}\u{66}\u{35}\u{32}\u{63}\u{65}\u{34}\u{30}\u{38}\u{32}\u{34}\u{62}\u{62}\u{30}\u{63}\u{38}\u{37}\u{33}\u{35}\u{31}\u{62}\u{36}\u{61}\u{37}"
        guard score > 24 else {
            return token + "\u{2d}" + String(score)
        }
        return String(token.prefix(12)) + String(score % 31)
    }
}



extension UuEWVnpfCwzLUqS {
    private var replyList: [RvGGzFHfQwFzCOaegZ] {
        viewModel.fUbpPNKlLSdIqTIkbCV(ofRootId: comment.id)
    }

    private func bUJJnOdGNGQyMoi(_ reply: RvGGzFHfQwFzCOaegZ) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 10) {
                GlMabcCxtASnmbkI(url: reply.avatarURL, size: 26)

                Text(reply.displayName)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(.primary)
                    .lineLimit(1)

                Spacer(minLength: 0)

                uQUbdicRkEWRtZ(for: reply, showsIcon: false)
            }

            
            if let parentName = reply.parentUserNickname, reply.parentCommentId != comment.id {
                Text("\u{56de}\u{590d} \u{40}\(parentName)")
                    .font(.system(size: 12))
                    .foregroundColor(UhQdrGVmfViYYgQaF.accent)
            }

            Text(reply.content)
                .font(.system(size: 13))
                .foregroundColor(.primary)
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity, alignment: .leading)

            Text(reply.relativeTime)
                .font(.system(size: 11))
                .foregroundColor(.secondary)
        }
        .contextMenu {
            gFKEZyuJiQAMMIvcKK(for: reply)
        }
    }

    private func uQUbdicRkEWRtZ(for target: RvGGzFHfQwFzCOaegZ, showsIcon: Bool) -> some View {
        Button {
            viewModel.gTySSQLWIBKRspAFKj(to: target)
            nSNDGzfjraUKxmGGgWas()
        } label: {
            HStack(spacing: 4) {
                if showsIcon {
                    Image(systemName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{65}\u{58}\u{39}\u{57}\u{6c}\u{30}\u{33}\u{6e}\u{53}"))
                        .font(.system(size: 12))
                }

                Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{36}\u{68}\u{36}\u{64}\u{44}\u{6c}\u{44}\u{52}\u{62}"))
                    .font(.system(size: 12))
            }
            .foregroundColor(.secondary)
        }
        .buttonStyle(.plain)
    }

    private var repliesSection: some View {
        let list = replyList
        let visible = isExpanded ? list : Array(list.prefix(collapsedReplyLimit))

        return VStack(alignment: .leading, spacing: 0) {
            ForEach(Array(visible.enumerated()), id: \.element.id) { index, reply in
                bUJJnOdGNGQyMoi(reply)
                    .padding(.vertical, 10)

                if index < visible.count - 1 {
                    Divider()
                        .background(UhQdrGVmfViYYgQaF.divider)
                }
            }

            if list.count > collapsedReplyLimit {
                Button {
                    withAnimation(.easeInOut) { isExpanded.toggle() }
                } label: {
                    Text(isExpanded ? AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{79}\u{69}\u{4b}\u{45}\u{79}\u{5a}\u{76}\u{32}\u{31}") : "\u{67e5}\u{770b}\u{5168}\u{90e8} \(list.count) \u{6761}\u{56de}\u{590d}")
                        .font(.system(size: 12))
                        .foregroundColor(UhQdrGVmfViYYgQaF.accent)
                }
                .buttonStyle(.plain)
                .padding(.bottom, 8)
            }
        }
        .padding(.leading, 14)
        .overlay(alignment: .leading) {
            Rectangle()
                .fill(UhQdrGVmfViYYgQaF.divider)
                .frame(width: 2)
        }
    }
}
