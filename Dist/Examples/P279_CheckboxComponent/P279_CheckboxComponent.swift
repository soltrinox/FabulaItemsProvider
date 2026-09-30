// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P279
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

public struct FabulaExample279_CheckboxComponent: View {
    @State private var tags = [0]
    public init() {}
    public var body: some View {
        Checkbox(tags: $tags) {
           VStack(alignment: .leading) {
              itemView(0)
              itemView(1)
              itemView(2)
           }
        } onTapReceive: { value in
        // print removed
        }
    }
    
    private func itemView(_ tag: Int) -> some View {
       HStack(spacing: 20) {
          CheckItem(tag: tag, size: 50)
          Text("Item \(tag + 1)")
             .font(.system(size: 50))
       }
       .padding()
       .checkTag(tag)
    }
}

struct FabulaExample279_CheckboxComponent_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample279_CheckboxComponent()
    }
}

//MARK: - CheckStore
fileprivate
class CheckStore<T: Hashable>: ObservableObject {
   @Binding var tags: [T]
   var onTapReceive: ((T) -> Void)?
   init(_ tags: Binding<[T]>,
        _ onTapReceive: ((T) -> Void)? = nil) {
      self._tags = tags
      self.onTapReceive = onTapReceive
   }
   func toggleTag(_ tag: T) {
      if tags.contains(tag) {
         removeTag(tag)
      } else {
         addTag(tag)
      }
   }
   private func addTag(_ tag: T) {
      if !tags.contains(tag) {
         tags.append(tag)
      }
   }
   private func removeTag(_ tag: T) {
      if let index = tags.firstIndex(of: tag) {
         tags.remove(at: index)
      }
   }
}

//MARK: - CheckItemModifier
fileprivate
struct CheckItemModifier<T: Hashable>: ViewModifier {
   @EnvironmentObject private var store: CheckStore<T>
   private let tag: T
   func body(content: Content) -> some View {
      content
         .contentShape(Rectangle())
         .onTapGesture {
            store.toggleTag(tag)
            store.onTapReceive?(tag)
         }
   }
}

fileprivate
extension CheckItemModifier where T: Hashable {
   init(_ tag: T) {
      self.tag = tag
   }
}

fileprivate
extension View {
   func checkTag<T: Hashable>(_ tag: T) -> some View {
      self.modifier(CheckItemModifier(tag))
   }
}

//MARK: - CheckItem
fileprivate
struct CheckItem<T: Hashable>: View {
   @EnvironmentObject private var store: CheckStore<T>
   let tag: T
   var size: CGFloat = 24
   var body: some View {
      ZStack {
         if store.tags.contains(tag) {
            RoundedRectangle(cornerRadius: 2)
               .fill(LocalTheme.primary)
            Image(systemName: "checkmark")
               .resizable()
               .scaledToFit()
               .foregroundColor(LocalTheme.foreWB100)
               .padding(size * 0.15)
               .transition(.scale)
         } else {
            RoundedRectangle(cornerRadius: 2)
               .stroke()
               .fill(LocalTheme.fore2)
         }
      }
      .frame(width: size, height: size)
      .animation(.default, value: store.tags)
   }
}

//MARK: - Checkbox
fileprivate
struct Checkbox<T: Hashable, Content: View>: View {
   private let store: CheckStore<T>
   private let content: () -> Content
   var body: some View {
      content()
         .environmentObject(store)
   }
}

fileprivate
extension Checkbox where T: Hashable, Content: View {
   init(tags: Binding<[T]>,
        @ViewBuilder _ content: @escaping () -> Content) {
      self.store = CheckStore(tags)
      self.content = content
   }
   init(tags: Binding<[T]>,
        @ViewBuilder _ content: @escaping () -> Content,
        onTapReceive: ((T) -> Void)? = nil) {
      self.store = CheckStore(tags, onTapReceive)
      self.content = content
   }
}
