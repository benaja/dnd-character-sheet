//
//  CharacterView.swift
//  dnd-character-sheet
//
//  Created by Benaja on 27.09.23.
//

import SwiftUI

struct CharacterView: View {
    var character: DndCharacter
    @State var selection = TabViews.stats
    
    
    @State private var offset = CGFloat.zero

    
    enum TabViews {
        case stats
        case inventory
        case combat
        case spells
        case character
    }
    
    var navigationTitle: String  {
        switch(selection) {
        case .stats:
            "Stats"
        case .inventory:
            "Inventory"
        case .combat:
            "Combat"
        case .spells:
            "Spells"
        case .character:
            "Character"
        }
    }
    
    
    init(character: DndCharacter) {
        self.character = character
    }
    
    var body: some View {
        ZStack {
            Colors.PrimaryBackground.color.ignoresSafeArea()
            CustomTabView() {
                //            ScrollView {
                //                VStack (spacing: 20) {
                //                    ForEach(0 ..< 20) { child in
                //                        Text(String(child))
                //                    }.tabItem {
                //                        Text("Tab 1")
                //                    }
                //                }
                //            }
                //
                //            List(0 ..< 6) { child in
                //                Text("Child \(child)")
                //            }.tabItem {
                //                Text("Tab 1")
                //            }
                StatsView(character: .constant(character))
                    .customTabItem(
                        Label("Stats", systemImage: "chart.bar.fill")
                    ).tag(TabViews.stats)
                InventoryView()
                    .customTabItem (
                        Label("Inventory", systemImage: "backpack.fill")
                    ).tag(TabViews.inventory)
    //                CombatView()
    //                    .tabItem {
    //                        Label("Combat", systemImage: "xmark.shield")
    //                    }.tag(TabViews.combat)
    //                Spellsview()
    //                    .tabItem {
    //                        Label("Spells", systemImage: "flame")
    //                    }.tag(TabViews.spells)
    //                GeneralCharacterInfo(character: .constant(character))
    //                    .tabItem {
    //                        Label("Character", systemImage: "figure.stand")
    //                    }.tag(TabViews.character)
                
            }
            .listRowBackground(Colors.PrimaryBackground.color)
    //        .navigationBarTitleDisplayMode(.inline)
            .navigationViewStyle(.columns)
            .navigationBarHidden(false)
            .environmentObject(character)
        .navigationTitle(character.name)
        }
        
            
    }
}

#Preview {
    var cotnainer = previewContainer()
    
    return NavigationStack {
        CharacterView(character: DndCharacter.sampleData[0])
    }
}
