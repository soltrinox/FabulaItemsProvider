// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P179
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

public struct FabulaExample179_FoldUnfold: View {
    
    @State private var height: CGFloat = 70
    @State private var rowMaxHeight: CGFloat = 100
    
    public init() {}
    public var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            VStack(spacing: 0) {
                PaperView(maxHeight: rowMaxHeight, height: $height)
                PaperView(maxHeight: rowMaxHeight, height: $height)
            }
            .frame(height: rowMaxHeight * 2)
            
            Divider().padding()
            Spacer()
            VStack(alignment: .leading, spacing: 3) {
                Text("Row Height:")
                    .font(.caption)
                    .opacity(0.5)
                Slider(value: $rowMaxHeight.animation(), in: 70...200)
                Text("Fold - Unfold:")
                    .font(.caption)
                    .opacity(0.5)
                Slider(value: $height, in: 0...rowMaxHeight)
            }
            
            HStack {
                Text("Fold")
                    .bold()
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .background(LocalTheme.primary)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 1)) {
                            height = 0
                        }
                    }
                Text("Unfold")
                    .bold()
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .background(LocalTheme.primary)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 1)) {
                            height = rowMaxHeight
                        }
                    }
            }
            .padding(.bottom)
        }
        .padding()
        .frame(maxWidth: 500)
    }
}

fileprivate
struct RowView: View {
    
    let maxHeight: CGFloat
    
    var body: some View {
        ZStack {
            Color.clear
            VStack {
                Text("Row Title")
                    .font(.callout)
                    .bold()
                Spacer()
            }
            .foregroundColor(Color.white)
            .padding()
        }
        .frame(height: maxHeight)
        .clipped()
        .background(LocalTheme.primary)
    }
}

fileprivate
struct PaperView: View {
    
    let maxHeight: CGFloat
    @Binding var height: CGFloat
    
    var body: some View {
        VStack(spacing: 0) {
            RowView(maxHeight: maxHeight)
                .overlay(
                    LinearGradient(colors: [Color.black.opacity(0.8), Color.black.opacity(0.6)], startPoint: .topLeading, endPoint: .bottomTrailing)
                        .compositingGroup()
                        .opacity((1.0 - (height / maxHeight)))
                )
                .rotation3DEffect(Angle(degrees: -90 * (1.0 - (height / maxHeight))), axis: (x: 1, y: 0, z: 0), anchor: .top)
                .frame(height: height * 0.5, alignment: .top)
                .clipShape(Rectangle())
            
            RowView(maxHeight: maxHeight)
                .overlay(
                    LinearGradient(colors: [Color.black.opacity(0.4), Color.black.opacity(0.3)], startPoint: .bottomTrailing, endPoint: .topLeading)
                        .compositingGroup()
                        .opacity((1.0 - (height / maxHeight)))
                )
                .rotation3DEffect(Angle(degrees: 90 * (1.0 - (height / maxHeight))), axis: (x: 1, y: 0, z: 0), anchor: .bottom)
                .frame(height: height * 0.5, alignment: .bottom)
                .clipShape(Rectangle())
        }
    }
}

struct FabulaExample179_FoldUnfold_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample179_FoldUnfold()
    }
}

