//
//  CustomTabView.swift
//  dnd-character-sheet
//
//  Created by Benaja on 04.10.2023.
//

import SwiftUI

class TabViewItem: ObservableObject {
    var id: any Hashable = UUID().uuidString
    var view: Label<Text, Image>
    @Published var isSelected: Bool = false
    
    init(view: Label<Text, Image>, isSelected: Bool = false) {
        self.view = view
        self.isSelected = isSelected
    }
}

class TabViewObject: ObservableObject {
    @Published var tabViews: [TabViewItem] = []
    @Published var selectedId: any Hashable = 0
}

struct CustomTabView<Content: View>: View {
    @ViewBuilder var content: Content
        
    @ObservedObject var tabViewObject = TabViewObject()
    
//    init (_ content: () -> Content) {
//        self.content = content
//    }
//    
    var body: some View {
        VStack {
            ScrollView {
                content
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
                        .foregroundColor(tabView.isSelected ? .blue : .gray)
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

struct CustomTabItem: ViewModifier {
    @EnvironmentObject var tabview: TabViewObject
    
    @ObservedObject var label: TabViewItem

    init(_ label: Label<Text, Image>) {
        self.label = TabViewItem(view: label)
    }
    
    func body(content: Content)-> some View {
        let item = tabview.tabViews.first(where:{ $0.id == label.id})
        if item == nil {
            tabview.tabViews.append(label)
        }
        
        print(tabview.tabViews.count)
        
        return Group {
            if label.id == tabview.selectedId {
                content
            } else {
                EmptyView()
            }
        }
    }
}

extension View {
    func customTabItem(_ content: Label<Text, Image>) -> some View {
        modifier(
            CustomTabItem(content))
    }
}


#Preview {
    CustomTabView() {
        VStack {
            ForEach(0 ..< 40) { item in
                Text("hey there")
            }
        }.customTabItem(Label("Stats", systemImage: "chart.bar.fill"))
        
        VStack {
            Text("Second")
        }.customTabItem(Label("Inventory", systemImage: "backpack.fill"))

    }
}
