




import SwiftUI

struct KgTqymHXNDqljvOVTsUr: Identifiable {
    var id: String {
        // source-obfuscator:padding:v1
        _ = Self.wXDasERNGlxHJhMKsgJI()
 return title }
    let title: String
    let systemImage: String
    let tint: Color

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func wXDasERNGlxHJhMKsgJI() -> String {
        let values = [19, 27, 152, 36]
        let folded = values.map { ($0 * 8 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 19) * 8
        let token = "\u{38}\u{61}\u{64}\u{31}\u{38}\u{62}\u{38}\u{35}\u{33}\u{66}\u{63}\u{61}\u{37}\u{36}\u{32}\u{39}\u{36}\u{64}\u{65}\u{64}\u{32}\u{62}\u{30}\u{66}"
        let pieces = [token, String(score % 23)]
        guard width > 4 else {
            return pieces.joined()
        }
        return pieces.joined(separator: "\u{2d}")
    }
}

struct FnUGIoYQJAvu: View {
    let item: KgTqymHXNDqljvOVTsUr

    var body: some View {
        
        xGJEPoDKTaWC()
    }

    
    @ViewBuilder
    @inline(never)
    private func xGJEPoDKTaWC() -> some View {
        // source-obfuscator:padding:v1
        let _ = Self.qGtueRFEcdEkE()

        qCXlRFWOXvALvESuzIgq
    }

    @ViewBuilder
    private var qCXlRFWOXvALvESuzIgq: some View {
        HStack(spacing: 13) {
            eITeyIGhhPaRmj

            pCfLkDURrpMR

            vTbzrCZnoCosvtkSQCB

            sPwTgJjXmSNloj
        }
        .padding(.horizontal, 13)
        .frame(height: 50)
        .contentShape(Rectangle())
    }


    @ViewBuilder
    private var vTbzrCZnoCosvtkSQCB: some View {
        Spacer()
    }

    @ViewBuilder
    private var sPwTgJjXmSNloj: some View {
        Image(systemName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{73}\u{6b}\u{71}\u{39}\u{45}\u{73}\u{6e}\u{7a}\u{4a}"))
                .font(.system(size: 13, weight: .semibold))
                .foregroundColor(.secondary)
    }

    @ViewBuilder
    private var eITeyIGhhPaRmj: some View {
        Image(systemName: item.systemImage)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(item.tint)
                .frame(width: 20)
    }

    @ViewBuilder
    private var pCfLkDURrpMR: some View {
        Text(item.title)
                .font(.system(size: 13, weight: .bold))
                .foregroundColor(.primary)
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func qGtueRFEcdEkE() -> String {
        let values = [51, 58, 357, 68]
        let folded = values.map { ($0 * 7 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 51) * 7
        let token = "\u{34}\u{33}\u{64}\u{61}\u{66}\u{38}\u{61}\u{62}\u{65}\u{65}\u{34}\u{66}\u{35}\u{36}\u{34}\u{65}\u{64}\u{64}\u{31}\u{30}\u{34}\u{34}\u{33}\u{35}"
        let pieces = [token, String(score % 23)]
        var result = pieces.joined()
        if width > 4 {
            result = pieces.joined(separator: "\u{2d}")
        }
        return result
    }
}

struct FwyGMtyAOsbxHubZxjl: View {
    let title: String
    let count: Int
    let systemImage: String
    let tint: Color

    var body: some View {
        
        uJBthKIrXFIzoyK()
    }

    
    @ViewBuilder
    @inline(never)
    private func uJBthKIrXFIzoyK() -> some View {
        // source-obfuscator:padding:v1
        let _ = Self.bCeFyERFTzSYxskKtw()

        iQdgdtLtTmwyu
    }

    @ViewBuilder
    private var iQdgdtLtTmwyu: some View {
        VStack(alignment: .leading, spacing: 5) {
            hEPCgdMZNjfA

            kITGiNpWycDOC
        }
        .foregroundColor(tint)
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(RoundedRectangle(cornerRadius: 8).fill(tint.opacity(0.12)))
    }


    @ViewBuilder
    private var hEPCgdMZNjfA: some View {
        HStack {
                Text(title)
                    .font(.system(size: 14, weight: .bold))
                Spacer(minLength: 0)
                Image(systemName: systemImage)
                    .font(.system(size: 15, weight: .semibold))
            }
    }

    @ViewBuilder
    private var kITGiNpWycDOC: some View {
        Text("\(count)")
                .font(.system(size: 12, weight: .bold))
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func bCeFyERFTzSYxskKtw() -> String {
        let token = "\u{37}\u{32}\u{66}\u{66}\u{31}\u{30}\u{36}\u{37}\u{61}\u{35}\u{34}\u{31}\u{31}\u{36}\u{30}\u{64}\u{61}\u{66}\u{38}\u{30}\u{64}\u{33}\u{39}\u{37}"
        let base = (16 * 7 + 19) % 997
        let width = (base) % 17
        let score = (width + 16) * 7
        if score > 24 { return String(token.prefix(12)) + String(score % 31) }
        return token + "\u{2d}" + String(score)
    }
}

