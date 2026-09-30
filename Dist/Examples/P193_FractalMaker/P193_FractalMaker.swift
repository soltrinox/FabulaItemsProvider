// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P193
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

public struct FabulaExample193_FractalMaker: View {
    
    @State private var toggle: Bool = false
    @Namespace var namespace
    
    var item: some View {
        ZStack {
            if toggle {
                Item(count: 2, shapeIndex: 0)
            }else {
                Item(count: 2, shapeIndex: 0)
            }
        }
    }
    
    var button: some View {
        Button {
            withAnimation {
                toggle.toggle()
            }
        } label: {
            Text("Create")
                .padding()
                .background(LocalTheme.primary)
                .foregroundColor(Color.white)
                .cornerRadius(12)
                .padding()
        }
        .buttonStyle(PlainButtonStyle())
        .padding()
    }
    
    public init() {}
    public var body: some View {
        GeometryReader { proxy in
            ZStack {
                Color.clear
                if proxy.size.width < proxy.size.height {
                    VStack(spacing: 0) {
                        item.border(LocalTheme.primary, width: 1)
                        button.padding()
                    }
                }else {
                    HStack(spacing: 0) {
                        item.border(LocalTheme.primary, width: 1)
                        button.padding()
                    }
                }
            }
        }
        .padding()
    }
}

fileprivate
struct Triangle: Shape {
    let rotateIndex: Int
    func path(in rect: CGRect) -> Path {
        var p = Path()
        switch rotateIndex {
        case 0:
            p.move(to: CGPoint(x: 0, y: 0))
            p.addLines([CGPoint(x: rect.width, y: rect.height),
                        CGPoint(x: 0, y: rect.height),
                        CGPoint(x: 0, y: 0)
                       ])
        case 1:
            p.move(to: CGPoint(x: rect.width, y: 0))
            p.addLines([CGPoint(x: rect.width, y: rect.height),
                        CGPoint(x: 0, y: rect.height),
                        CGPoint(x: rect.width, y: 0)
                       ])
        case 2:
            p.move(to: CGPoint(x: 0, y: 0))
            p.addLines([CGPoint(x: rect.width, y: 0),
                        CGPoint(x: rect.width, y: rect.height),
                        CGPoint(x: 0, y: 0)
                       ])
        case 3:
            p.move(to: CGPoint(x: 0, y: 0))
            p.addLines([CGPoint(x: rect.width, y: 0),
                        CGPoint(x: 0, y: rect.height),
                        CGPoint(x: 0, y: 0)
                       ])
        default:
            break
        }
        
        return p
    }
}

fileprivate
struct RowView: View {
    
    let shapeIndex: Int
    
    var body: some View {
        ZStack {
            switch shapeIndex {
            case 0:
                Triangle(rotateIndex: Int.random(in: 0..<4))
                    .aspectRatio(1, contentMode: .fit)
                    .opacity(0.5)
            case 1:
                Rectangle()
                    .aspectRatio(1, contentMode: .fit)
                    .foregroundColor(LocalTheme.primary)
            default:
                EmptyView()
            }
        }
    }
}

fileprivate
struct Item: View {
    let count: Int
    let shapeIndex: Int
    var body: some View {
        if count <= 0 {
            RowView(shapeIndex: shapeIndex)
        }else {
            VStack(spacing: 0) {
                randomItems()
                randomItems()
                randomItems()
            }
        }
    }
    
    private func randomItems() -> some View {
        ZStack {
            switch Int.random(in: 0...2) {
            case 0:
                HStack(spacing: 0) {
                    Item(count: count - (Bool.random() ? 1 : 2), shapeIndex: Int.random(in: 0..<2))
                    Item(count: count - (Bool.random() ? 1 : 2), shapeIndex: 0)
                    Item(count: count - (Bool.random() ? 1 : 2), shapeIndex: 0)
                }
            case 1:
                HStack(spacing: 0) {
                    Item(count: count - (Bool.random() ? 1 : 2), shapeIndex: 0)
                    Item(count: count - (Bool.random() ? 1 : 2), shapeIndex: 0)
                    Item(count: count - (Bool.random() ? 1 : 2), shapeIndex: 0)
                }
            case 2:
                HStack(spacing: 0) {
                    Item(count: count - (Bool.random() ? 1 : 2), shapeIndex: 0)
                    Item(count: count - (Bool.random() ? 1 : 2), shapeIndex: 0)
                    Item(count: count - (Bool.random() ? 1 : 2), shapeIndex: 0)
                }
            default:
                EmptyView()
            }
        }
    }
}

struct FabulaExample193_FractalMaker_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample193_FractalMaker()
    }
}
