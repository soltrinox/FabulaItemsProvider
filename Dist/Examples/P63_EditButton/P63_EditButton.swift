// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P63
// Adapted: local theme; print removed; no third-party.

import SwiftUI


import SwiftUI

public struct FabulaExample63_EditButton: View {
    
    let foodStr: String = "🍏🍎🍐🍊🍋🍌🍉🍇🍓🫐🍈🍒🍑🥭🍍🥥🥝🍅🍆🥑🥦🥬🥒🌶🫑🌽🥕🫒🧄🧅🥔🍠🥐🥯🍞🥖🥨🧀🥚🍳🧈🥞🧇🥓🥩🍗🍖🦴🌭🍔🍟🍕🫓🥪🥙🧆🌮🌯🫔🥗🥘🫕"
    @State var foods = [String]()
    
    public init() {}
    public var body: some View {
        List {
            ForEach(self.foods, id: \.self) { food in
                Text(food)
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
        
#if os(iOS)
        .navigationViewStyle(StackNavigationViewStyle())
        .toolbar {
            EditButton()
        }
#endif
    }
}

struct FabulaExample63_EditButton_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample63_EditButton()
    }
}
