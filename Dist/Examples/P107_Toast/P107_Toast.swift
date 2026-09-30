// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P107
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

public struct FabulaExample107_Toast: View {
    
    @State private var showTopToast = false
    @State private var showBottomToast = false
    
    public init() {}
    public var body: some View {
        VStack {
            Button {
                withAnimation {
                    showTopToast = true
                }
            } label: {
                Text("Show Top Toast!")
            }
            .buttonStyle(PlainButtonStyle())
            
            Divider()
                .frame(width: 44)
                .padding()
            
            Button {
                withAnimation {
                    showBottomToast = true
                }
        // print removed
            } label: {
                Text("Show Bottom Toast!")
            }
            .buttonStyle(PlainButtonStyle())
        }
        .showToast(showToast: $showTopToast, content:
                    FabulaToast(showToast: $showTopToast,
                                toastData: FabulaToast.ToastData(title: "Title", message: "Messages", backgroundColor: Color.orange),
                                position: .top))
        .showToast(showToast: $showBottomToast, content:
                    FabulaToast(showToast: $showBottomToast,
                                toastData: FabulaToast.ToastData(title: "Title", message: "Messages", backgroundColor: Color.orange),
                                position: .bottom))
    }
}

fileprivate
struct ToastView: View {
    
    let toastData: FabulaToast.ToastData
    
    var body: some View {
        HStack {
            Image(systemName: "checkmark")
            VStack(alignment: .leading, spacing: 2) {
                Text(LocalizedStringKey(toastData.title))
                    .font(.subheadline)
                    .fontWeight(.bold)
                Text(LocalizedStringKey(toastData.message))
                    .font(.callout)
                    .opacity(0.9)
            }
            Spacer()
        }
        .foregroundColor(LocalTheme.back0)
        .padding(10)
    }
}

fileprivate
struct FabulaToastView: View {
    
    @State private var showToast = false
    
    var body: some View {
        VStack {
            Text("Show Toast!")
                .onTapGesture {
                    withAnimation {
                        showToast = true
                    }
                }
        }
        .showToast(showToast: $showToast.animation(), content: FabulaToast(showToast: $showToast.animation(), toastData: FabulaToast.ToastData(title: "Title", message: "your message", backgroundColor: Color.orange), position: .top))
        
#if os(macOS)
        .frame(width: 500, height: 500)
#endif
    }
}

fileprivate
struct FabulaToast: View {
    
    enum ToastPosition {
        case top
        case bottom
    }
    
    struct ToastData {
        var title: String
        var message: String
        var backgroundColor: Color
    }
    
    @Binding var showToast: Bool
    let toastData: ToastData
    var position: ToastPosition
    
    var body: some View {
        VStack {
            if position == .bottom {
                Spacer()
            }
            if #available(macOS 12.0, *) {
                ToastView(toastData: toastData)
                    .background(toastData.backgroundColor.opacity(0.3))
                    .background(.ultraThinMaterial)
                    .cornerRadius(10)
            } else {
                ToastView(toastData: toastData)
                    .background(toastData.backgroundColor.opacity(0.8))
                    .cornerRadius(10)
            }
            
            if position == .top {
                Spacer()
            }
        }
        .padding()
        .opacity(self.showToast ? 1.0 : 0)
        .transition(.move(edge: position == .top ? .top : .bottom))
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    self.showToast = false
                }
            }
        }
        .onTapGesture {
            withAnimation {
                self.showToast = false
            }
        }
    }
}

fileprivate
struct ToastModifier<T: View>: ViewModifier {
    
    @Binding var showToast: Bool
    let content: T
    
    func body(content: Content) -> some View {
        ZStack {
            content
            ZStack {
                if showToast {
                    self.content
                }else {
                    EmptyView()
                }
            }
        }
    }
}

fileprivate
extension View {
    func showToast<T: View>(showToast: Binding<Bool>, content: T) -> some View {
        self.modifier(ToastModifier(showToast: showToast, content: content))
    }
}

struct FabulaExample107_Toast_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample107_Toast()
    }
}
