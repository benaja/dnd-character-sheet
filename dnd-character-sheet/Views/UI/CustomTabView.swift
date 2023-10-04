//
//  CustomTabView.swift
//  dnd-character-sheet
//
//  Created by Benaja on 04.10.2023.
//

import SwiftUI

class TabViewItem: ObservableObject, Identifiable {
    var id: any Hashable = UUID().uuidString
    var view: Label<Text, Image>
    
    init(view: Label<Text, Image>, id: any Hashable) {
        self.view = view
        self.id = id
    }
}

class TabViewObject: ObservableObject {
    @Published var tabViews: [TabViewItem] = []
    @Published var selectedId: any Hashable = 0
    
    func addTab(_ tab: TabViewItem) {
//        if tabViews.count == 0 && selectedId == nil {
//            selectedId = tab.id
//        }
        tabViews.append(tab)
    }
}

struct CustomTabView<SelectionValue: Hashable, Content: View>: View {
    @Binding var selection: SelectionValue
    var content: () -> Content
        
    @ObservedObject var tabViewObject = TabViewObject()
    
//    init(selection: Binding)
    
    init (selection: Binding<SelectionValue>?, @ViewBuilder _ content: @escaping () -> Content) {
        self.content = content
        self._selection = selection ?? Binding.constant(0 as! SelectionValue)
    }
//
    var body: some View {
        VStack {
            ScrollView {
                content()
            }.frame(maxWidth: .infinity)
                .environmentObject(tabViewObject)
            
            Spacer()
            
            
            HStack {
                ForEach(tabViewObject.tabViews) { tabView in
                    Button(action: {
                        selectItem(tabView)
                    }) {
                        tabView.view
                    }.frame(maxWidth: .infinity)
                        .foregroundColor(tabView.id.hashValue == tabViewObject.selectedId.hashValue ? .blue : .gray)
                }
                
                //                            Label("Combat", systemImage: "xmark.shield")
                //                            Label("Spells", systemImage: "flame")
                //                            Label("Character", systemImage: "figure.stand")
            }.frame(maxWidth: .infinity)
                .labelStyle(CustomLabelStyle())
                .background(Color(UIColor.systemGray6))
        }
    }
    
    func selectItem(_ tabView: TabViewItem) {
        tabViewObject.selectedId = tabView.id
    }
}

extension CustomTabView where SelectionValue == Int {
    init(@ViewBuilder _ content: @escaping () -> Content) {
        self.init(selection: Binding.constant(0), content)
    }
}

struct CustomTabItem: ViewModifier {
    @EnvironmentObject var tabview: TabViewObject
    var tag: any Hashable
    
    var label: Label<Text, Image>
    var item: TabViewItem?
    
   
    init(_ label: Label<Text, Image>, tag: any Hashable) {
        self.label = label
        self.tag = tag
    }
    
    func body(content: Content)-> some View {
        let item = tabview.tabViews.first(where:{ $0.id.hashValue == tag.hashValue})
        if item == nil {
            tabview.addTab(TabViewItem(view: label, id: tag))
        }
               
        
        return Group {
            if tabview.selectedId.hashValue == tag.hashValue {
                content
            } else {
                EmptyView()
            }
        }
    }
}

extension View {
//    @EnvironmentObject var tabview: TabViewObject
    
    func customTabItem(_ content: Label<Text, Image>, tag: any Hashable) -> some View {
        modifier(
            CustomTabItem(content, tag: tag))
    }
}

#Preview {
    @State var selection: Int = 0
    
    return CustomTabView() {
        VStack {
            ForEach(0 ..< 40) { item in
                Text("hey there")
            }
        }.customTabItem(Label("Stats", systemImage: "chart.bar.fill"), tag: 0)
        
        VStack {
            Text("Second")
        }.customTabItem(Label("Inventory", systemImage: "backpack.fill"), tag: 1)

    }
}
