// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P1
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

public struct FabulaExample1_Timer: View {
    
    @StateObject var intervalStore = TimeIntervalStore()
    
    public init() {}
    public var body: some View {
        ClockView()
            .environmentObject(intervalStore)
            .padding()
            .animation(.default, value: intervalStore.time)
            .onAppear() {
                DispatchQueue.main.async {
                    intervalStore.start()
                }
            }
    }
}

fileprivate
struct ClockTickView: View {
    
    var sec: Double
    var tickCount = 60
    
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .center) {
                ForEach(0..<tickCount, id: \.self) { tick in
                    Circle()
                        .fill(tick % 5 == 0 ? LocalTheme.fore1 : LocalTheme.fore2)
                        .frame(width: tick % 5 == 0 ? 5 : 2, height: tick % 5 == 0 ? 5 : 2)
                        .offset(x: proxy.size.width <= proxy.size.height ? -(proxy.size.width / 2 - 50) : -(proxy.size.height / 2 - 50))
                        .rotationEffect(.degrees(Double(tick) / Double(tickCount)) * 360)
                        .offset(x: -2.5, y: -2.5)
                }
            }
            .offset(x: proxy.size.width / 2, y: proxy.size.height / 2)
        }
    }
}

fileprivate
struct ClockHandView: View {
    
    var sec: Double
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Color.clear
                Group {
                    Capsule()
                        .fill(LocalTheme.primary)
                        .frame(width: 3, height: getHandViewSize(proxy) * 1.07)
                        .offset(y: -(getHandViewSize(proxy) / 2.17))
                        .rotationEffect(.degrees(sec / 60 / 60 * 360))
                    
                    Capsule()
                        .fill(LocalTheme.secondary)
                        .frame(width: 3, height: getHandViewSize(proxy) * 1.07)
                        .offset(y: -(getHandViewSize(proxy) / 2.17))
                        .rotationEffect(.degrees(sec / 60 * 360))
                    
                    Circle()
                        .fill(LocalTheme.fore1)
                        .frame(width: 12, height: 12)
                    
                    Circle()
                        .frame(width: 5, height: 5)
                        .offset(y: -(getHandViewSize(proxy) + 5))
                        .rotationEffect(.degrees(sec / 60 * 60 * 360))
                }
            }
        }
    }
    
    func getHandViewSize(_ proxy: GeometryProxy) -> CGFloat {
        return proxy.size.width < proxy.size.height ? (proxy.size.width / 2 - 55) : (proxy.size.height / 2 - 55)
    }
}

extension P1_Timer {
    
    struct ClockView : View {
        
        @EnvironmentObject var store: TimeIntervalStore
        
        var body: some View {
            ZStack {
                ClockTickView(sec: store.time)
                ClockHandView(sec: store.time)
            }
        }
    }
    
    class TimeIntervalStore: ObservableObject {
        
        @Published var isStart: Bool = false
        @Published var time: Double = 0
        @Published var circleTime: Double = 0
        @Published var prevImage: Image = Image(systemName: "network")
        @Published var nextImage: Image = Image(systemName: "globe.asia.australia.fill")
        
        @Published var prevColor: Color = Color(hex: 0x000000)
        @Published var nextColor: Color = Color(hex: 0x5586A2)
        @Published var interval: Double = 0.1
        
        private var currentImageIndex: Int = 0
        private var images = ["globe.asia.australia.fill", "globe.americas", "network"]
        private var colors = [Color(hex: 0x5586A2), Color(hex: 0xF6D256), Color(hex: 0x0C4C89), Color(hex: 0xEF562D), Color(hex: 0x97D5E0)]
        
        
        private var timer: Timer?
        
        init(interval: Double = 0.1) {
            self.interval = interval
        }
        
        func start() {
            timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(run), userInfo: nil, repeats: true)
        }
        
        func stop() {
            time = 0
        }
        
        func pause() {
            timer?.invalidate()
        }
        
        func changeImage() {
            prevImage = Image(systemName: images[0])
            nextImage = Image(systemName: images[1])
            
            let imageName = images.remove(at: 0)
            images.append(imageName)
            
            prevColor = colors[0]
            nextColor = colors[1]
            
            let imageColor = colors.remove(at: 0)
            colors.append(imageColor)
        }
        
        @objc private func run() {
            time += interval
            circleTime += interval
            if Int(circleTime) == 60 {
                circleTime = 0
                DispatchQueue.main.async {
                    self.changeImage()
                }
            }
        }
        
        deinit {
            timer?.invalidate()
        }
    }
}

struct FabulaExample1_Timer_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample1_Timer()
    }
}
