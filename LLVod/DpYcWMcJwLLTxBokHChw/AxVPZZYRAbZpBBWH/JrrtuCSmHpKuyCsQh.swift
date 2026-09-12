






import SwiftUI

struct HlqcujHgGlgafnjIq: View {

    let rank: Int
    let item: YbfRUDRMWBvXF

    @State private var photoIndex = 0

    private let posterWidth: CGFloat = 96
    private let posterHeight: CGFloat = 134
    private let accent = Color(red: 0.93, green: 0.55, blue: 0.18)

    var body: some View {
        ChdebFryKFbVSMM(title: item.title) {
            VStack(alignment: .leading, spacing: 10) {
                mediaRow
                titleRow
                ratingRow
                if !item.cardSubtitle.isEmpty {
                    Text(item.cardSubtitle)
                        .font(.system(size: 11))
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }
                if !item.blurb.isEmpty {
                    Text(item.blurb)
                        .font(.system(size: 12))
                        .foregroundColor(Color.primary.opacity(0.75))
                        .lineLimit(3)
                        .lineSpacing(2)
                }
            }
            .padding(.vertical, 12)
            .contentShape(Rectangle())
        }
    }

    

    

    

    

    

    private func yJhOxPRAoUvhseUPl(for index: Int) -> String {
        // source-obfuscator:padding:v1
        _ = Self.yQXJsJxEvBKh()

        let filled = item.starCount
        
        let threshold = Self.gPwePEJwMhNA(index)
        if filled >= Double(index) + 1 {
            return AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{36}\u{70}\u{59}\u{56}\u{4c}\u{77}\u{32}\u{38}\u{66}")
        }
        if filled >= threshold {
            return AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4e}\u{6f}\u{79}\u{6d}\u{63}\u{4e}\u{64}\u{50}\u{37}")
        }
        return AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{38}\u{4c}\u{43}\u{55}\u{69}\u{76}\u{39}\u{71}\u{6c}")
    }

    

    
    private nonisolated static func gPwePEJwMhNA(_ index: Swift.Int) -> Swift.Double {
        let threshold = Double(index) + 0.5
        return threshold
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func yQXJsJxEvBKh() -> String {
        let token = "\u{35}\u{32}\u{64}\u{35}\u{34}\u{31}\u{32}\u{34}\u{32}\u{63}\u{37}\u{35}\u{36}\u{64}\u{32}\u{36}\u{37}\u{32}\u{30}\u{33}\u{37}\u{30}\u{36}\u{32}"
        let base = (60 * 5 + 19) % 997
        let width = (base) % 17
        let score = (width + 60) * 5
        if score > 24 { return String(token.prefix(12)) + String(score % 31) }
        return token + "\u{2d}" + String(score)
    }
}



extension HlqcujHgGlgafnjIq {
    private var kKaCmVbFCRbVzeen: some View {
        Group {
            if let url = URL(string: item.posterURL), !item.posterURL.isEmpty {
                EtXjBLbNYUbhXfeKeH(url: url)
            } else {
                Color(.secondarySystemFill)
            }
        }
        .frame(width: posterWidth, height: posterHeight)
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
    }

    private var rankBadgeColor: Color {
        switch rank {
        case 1:
            return Color(red: 0.93, green: 0.55, blue: 0.18)
        case 2:
            return Color(red: 0.72, green: 0.58, blue: 0.42)
        case 3:
            return Color(red: 0.78, green: 0.62, blue: 0.38)
        default:
            return Color(white: 0.55)
        }
    }

    @ViewBuilder
    private var photoCarousel: some View {
        let photos = item.photos.isEmpty ? [item.posterURL].filter { !$0.isEmpty } : item.photos

        if photos.isEmpty {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(Color(.secondarySystemFill))
        } else {
            ZStack(alignment: .bottom) {
                TabView(selection: $photoIndex) {
                    ForEach(Array(photos.enumerated()), id: \.offset) { index, urlString in
                        Group {
                            if let url = URL(string: urlString) {
                                EtXjBLbNYUbhXfeKeH(url: url, contentMode: .fill)
                            } else {
                                Color(.secondarySystemFill)
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .clipped()
                        .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))

                if photos.count > 1 {
                    HStack(spacing: 4) {
                        ForEach(0..<photos.count, id: \.self) { index in
                            Circle()
                                .fill(index == photoIndex ? Color.white : Color.white.opacity(0.45))
                                .frame(width: 5, height: 5)
                        }
                    }
                    .padding(.bottom, 8)
                }
            }
        }
    }

    private var mediaRow: some View {
        HStack(alignment: .top, spacing: 8) {
            ZStack(alignment: .topLeading) {
                kKaCmVbFCRbVzeen

                Text("\(rank)")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.white)
                    .frame(width: 22, height: 22)
                    .background(rankBadgeColor)
                    .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))
                    .padding(4)
            }

            photoCarousel
                .frame(maxWidth: .infinity)
                .frame(height: posterHeight)
        }
    }

    private var titleRow: some View {
        HStack(alignment: .center, spacing: 8) {
            Text(item.title)
                .font(.system(size: 17, weight: .bold))
                .foregroundColor(.primary)
                .lineLimit(1)

            Spacer(minLength: 0)

            Image(systemName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{39}\u{4e}\u{38}\u{6b}\u{61}\u{6a}\u{4b}\u{4a}\u{71}"))
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(Color(red: 0.95, green: 0.72, blue: 0.2))
        }
    }

    private var ratingRow: some View {
        HStack(spacing: 4) {
            ForEach(0..<5, id: \.self) { index in
                Image(systemName: yJhOxPRAoUvhseUPl(for: index))
                    .font(.system(size: 11))
                    .foregroundColor(accent)
            }

            if item.ratingValue > 0 {
                Text(String(format: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6b}\u{69}\u{58}\u{38}\u{66}\u{77}\u{78}\u{4a}\u{6c}"), item.ratingValue))
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(accent)
            } else {
                Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{65}\u{62}\u{37}\u{77}\u{41}\u{61}\u{64}\u{4f}\u{69}"))
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
            }
        }
    }
}
