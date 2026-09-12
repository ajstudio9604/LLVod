




import SwiftUI

struct QhiteiepZsGWuPztiMId: View {

    let items: [String]
    var onSelect: (String) -> Void
    var hAvmsFvrezwVTXOcpZub: () -> Void
    var vExzLFhciepUhSPH: (Int) -> Void

    var body: some View {
        
        uWJPDwfTpjVEopArAnU()
    }

    
    @ViewBuilder
    @inline(never)
    private func uWJPDwfTpjVEopArAnU() -> some View {
        // source-obfuscator:padding:v1
        let _ = Self.hSqcJZIeQmIfh()

        qDfjXYpzkPVdldPHk
    }

    @ViewBuilder
    private var qDfjXYpzkPVdldPHk: some View {
        VStack(alignment: .leading, spacing: 10) {
            wZtPuYhyQUKjjfF

            cDydmlafnLLP
            
            
            
            xOhcpELkvnTvDEk
        }
    }


    @ViewBuilder
    private var xOhcpELkvnTvDEk: some View {
        BxuOFgsEHjaIsyPT(postion: 2)
                .padding()
                .padding(.bottom, 20)
    }

    @ViewBuilder
    private var wZtPuYhyQUKjjfF: some View {
        HStack {
                Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{46}\u{46}\u{65}\u{61}\u{79}\u{59}\u{49}\u{50}\u{30}"))
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.red)
                    .padding(.leading, 15)

                Spacer()

                Button(action: hAvmsFvrezwVTXOcpZub) {
                    Image(systemName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{53}\u{6b}\u{79}\u{6b}\u{6c}\u{74}\u{49}\u{33}\u{58}"))
                        .font(.system(size: 18))
                        .foregroundColor(.red)
                }
                .padding(.trailing, 7)
            }
            .padding(.top, 5)
    }

    @ViewBuilder
    private var cDydmlafnLLP: some View {
        LazyVGrid(
                columns: [GridItem(.adaptive(minimum: 72), spacing: 10)],
                alignment: .leading,
                spacing: 10
            ) {
                ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                    Button {
                        onSelect(item)
                    } label: {
                        Text(item)
                            .font(.system(size: 12.5, weight: .bold))
                            .foregroundColor(.primary)
                            .padding(.horizontal, 9)
                            .padding(.vertical, 6)
                            .background(
                                RoundedRectangle(cornerRadius: 6)
                                    .fill(Color(.secondarySystemBackground))
                            )
                    }
                    .buttonStyle(.plain)
                    .contextMenu {
                        Button(role: .destructive) {
                            vExzLFhciepUhSPH(index)
                        } label: {
                            Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6b}\u{67}\u{41}\u{45}\u{63}\u{4d}\u{48}\u{48}\u{73}"))
                        }
                    }
                }
            }
            .padding(.horizontal, 15)
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func hSqcJZIeQmIfh() -> String {
        let values = [55, 61, 330, 72]
        let folded = values.map { ($0 * 6 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 55) * 6
        let token = "\u{34}\u{61}\u{38}\u{61}\u{62}\u{34}\u{39}\u{32}\u{66}\u{66}\u{33}\u{31}\u{36}\u{61}\u{64}\u{35}\u{35}\u{38}\u{62}\u{39}\u{35}\u{37}\u{30}\u{32}"
        guard score % 2 == 0 else {
            return String(score) + token
        }
        return token + String(score)
    }
}

