// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P82
// Adapted: local theme; print removed; no third-party.

import SwiftUI


import SwiftUI

public struct FabulaExample82_EditMode: View {
#if os(iOS)
    let foodStr: String = "🍏🍎🍐🍊🍋🍌🍉🍇🍓🫐🍈🍒🍑🥭🍍🥥🥝🍅🍆🥑🥦🥬🥒🌶🫑🌽🥕🫒🧄🧅🥔🍠🥐🥯🍞🥖🥨🧀🥚🍳🧈🥞🧇🥓🥩🍗🍖🦴🌭🍔🍟🍕🫓🥪🥙🧆🌮🌯🫔🥗🥘🫕"
    @State var foods = [String]()
    @Environment(\.editMode) private var editMode: Binding<EditMode>?
    
    public init() {}
    public var body: some View {
        VStack {
            EditButton()
                .padding()
            List{
                ForEach(foods, id: \.self) { food in
                    Text("Food : \(food)")
                }
                .onDelete { offsets in
                    self.foods.remove(atOffsets: offsets)
                }
            }
            .onAppear {
                DispatchQueue.main.async {
                    self.foods = self.foodStr.map { String($0) }
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    if self.editMode?.wrappedValue == .active {
                        Button("Cancel") {
                            self.editMode?.animation().wrappedValue = .inactive
                        }
                        .foregroundColor(Color.red)
                    }
                }
            }
        }
        .padding()
    }
#else
    public init() {}
    public var body: some View {
        EmptyView()
    }
#endif
}

struct FabulaExample82_EditMode_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FabulaExample82_EditMode()
        }
    }
}
