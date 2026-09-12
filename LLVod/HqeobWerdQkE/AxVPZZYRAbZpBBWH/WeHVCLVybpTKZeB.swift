




import SwiftUI

struct OawsHVdaYNMQmC: View {

    let item: EyDFcDrlWhFFRVgXi
    var xSLUGkvoolmZhuvwt: CGFloat

    

    var body: some View {
        // source-obfuscator:padding:v1
        let _ = Self.qQwQbwaQyFBvGFDs()

        ChdebFryKFbVSMM(title: item.title) {
            VStack(alignment: .leading, spacing: 8) {
                EtXjBLbNYUbhXfeKeH(url: URL(string: item.imageURL))
                    .frame(width: xSLUGkvoolmZhuvwt, height: itemHeight - 44)
                    .background(Color.gray.opacity(0.08))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .clipped()

                Text(item.title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                    .lineLimit(1)

                if !item.subtitle.isEmpty {
                    Text(item.subtitle)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }
            }
            .frame(width: xSLUGkvoolmZhuvwt, alignment: .leading)
        }
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func qQwQbwaQyFBvGFDs() -> String {
        let token = "\u{31}\u{39}\u{63}\u{33}\u{64}\u{36}\u{65}\u{35}\u{38}\u{62}\u{36}\u{64}\u{35}\u{36}\u{31}\u{63}\u{66}\u{64}\u{30}\u{65}\u{35}\u{62}\u{35}\u{66}"
        let values = [64, 71, 448, 81]
        let folded = values.map { ($0 * 7 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 64) * 7
        if score % 2 == 0 { return token + String(score) }
        return String(score) + token
    }
}



extension OawsHVdaYNMQmC {
    private var itemHeight: CGFloat {
        xSLUGkvoolmZhuvwt / 0.6
    }
}
