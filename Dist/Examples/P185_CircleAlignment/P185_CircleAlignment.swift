// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P185
// Adapted: local theme; print removed; no third-party.

import SwiftUI

fileprivate enum LocalTheme {
    static let primary = Color(red: 0.969, green: 0.475, blue: 0.278)
    static let secondary = Color(red: 0.122, green: 0.753, blue: 0.843)
    static let back0 = Color(red: 0.980, green: 0.980, blue: 0.980)
    static let back1 = Color(red: 0.941, green: 0.941, blue: 0.941)
    static let back2 = Color(red: 0.902, green: 0.902, blue: 0.902)
    static let fore1 = Color(red: 0.125, green: 0.125, blue: 0.196)
    static let fore2 = Color(red: 0.565, green: 0.561, blue: 0.580)
    static let bar1 = Color(red: 0.952, green: 0.952, blue: 0.956)
    static let bar2 = Color(red: 0.894, green: 0.897, blue: 0.895)
    static let foreWB100 = Color.black
    static let backWB100 = Color.white
}


import SwiftUI

public struct FabulaExample185_CircleAlignment: View {
    
    @State private var isCircle: Bool = true
    @State private var angle: Angle = .zero
    @State private var keyword: String = "Touch"
    @Namespace private var namespace
    let words: [String]
    
    public init() {
        self.words = "Labyrinth,Ineffable,Incendiary,Ephemeral,Cynosure,Propinquity,Infatuation,Incandescent,Eudaemonia,Raconteur,Petrichor,Sumptuous,Aesthete,Nadir,Miraculous,Lassitude,Gossamer,Bungalow,Aurora,Inure,Mellifluous,Euphoria,Cherish,Demure,Elixir,Eternity,Felicity,Languor,Love,Solitude,Epiphany,Quintessential,Plethora,Nemesis,Lithe,Tranquility,Elegance,Renaissance,Eloquence,Sequoia,Peace,Lullaby,Paradox,Pristine,Effervescent,Opulence,Ethereal,Sanguine,Panacea,Bodacious,Axiom,Silhouette,Surreptitious,Ingenue,Dulcet,Tryst,Ebullience".components(separatedBy: ",")
    }
    
    public var body: some View {
        ZStack {
            GeometryReader { proxy in
                let midX = Int(proxy.size.width / 2.0)
                let midY = Int(proxy.size.height / 2.0)
                ZStack {
                    Color.clear
                    ZStack {
                        Color.clear
                        ForEach(Array(self.words.enumerated()), id: \.offset) { index, word in
                            if isCircle {
                                RowView(word: word, width: CGFloat(min(midX, midY)))
                                    .matchedGeometryEffect(id: index, in: namespace)
                                    .frame(width: min(proxy.size.width, proxy.size.height))
                                    .foregroundColor(index%2 == 0 ? Color.secondary : LocalTheme.primary)
                                    .rotationEffect(.degrees(Double(index) / Double(self.words.count)) * 360)
                                
                            }else {
                                let opacity = CGFloat.random(in: 0.2...1.0)
                                RowView(word: word, width: CGFloat(min(midX, midY)))
                                    .matchedGeometryEffect(id: index, in: namespace)
                                    .frame(width: min(proxy.size.width, proxy.size.height))
                                    .foregroundColor(Color.secondary)
                                    .rotationEffect(Angle(degrees: CGFloat(Int.random(in: 0...270))))
                                    .offset(x: CGFloat(Int.random(in: -midX...midX)),
                                            y: CGFloat(Int.random(in: -midY...midY)))
                                    .scaleEffect(index%2 == 0 ? opacity * 2.0 : opacity * 5.0)
                                    .opacity(opacity)
                            }
                        }
                        .rotationEffect(angle)
                        
                        Text(keyword)
                            .bold()
                            .shadow(color: Color.black.opacity(0.5), radius: 6, x: 0, y: 0)
#if os(iOS)
                            .font(.title)
#else
                            .font(.largeTitle)
#endif
                            .animation(.easeInOut(duration: 0.24), value: keyword)
                    }
                }
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation(.easeInOut(duration: 2.0)) {
                isCircle.toggle()
                if !isCircle {
                    keyword = self.words[Int.random(in: 0..<self.words.count)]
                }
            }
            withAnimation(.easeInOut(duration: 3.0)) {
                angle = Angle(degrees: CGFloat(Int.random(in: 0...270)))
            }
        }
        .padding()
    }
    
    private func getCircularValue(_ current: Double, _ total: Double) -> CGFloat {
        let x = Double(current) / Double(total)
        let y = (sin(-1 * .pi * x - (.pi / 1)) + 1) / 2.0
        return y
    }
    
    private func getFontSize(_ proxy: GeometryProxy) -> CGFloat {
        return proxy.minSize / 2 * 0.1
    }
}

fileprivate
struct RowView: View {
    let word: String
    let width: CGFloat
    var body: some View {
        HStack {
            Text(word)
#if os(iOS)
                .font(.caption)
#else
                .font(.title)
#endif
                .fontWeight(.bold)
                .fixedSize()
            Rectangle()
                .frame(width: width, height: 1)
            Circle()
                .frame(width: 5, height: 5)
                .offset(x: -3)
            Spacer()
        }
    }
}

struct FabulaExample185_CircleAlignment_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample185_CircleAlignment()
    }
}
