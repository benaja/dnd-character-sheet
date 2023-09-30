//
//  CharacterView.swift
//  dnd-character-sheet
//
//  Created by Benaja on 27.09.23.
//

import SwiftUI

struct CharacterView: View {
    @Binding var character: DndCharacter
    @State var selection = TabViews.stats
    
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
    
    var body: some View {
        TabView(selection: $selection) {
            StatsView(character: $character)
                .tabItem {
                    Label("Stats", systemImage: "chart.bar")
                }.tag(TabViews.stats)
            InventoryView()
                .tabItem {
                    Label("Inventory", systemImage: "backpack")
                }.tag(TabViews.inventory)
            CombatView()
                .tabItem {
                    Label("Combat", systemImage: "xmark.shield")
                }.tag(TabViews.combat)
            Spellsview()
                .tabItem {
                    Label("Spells", systemImage: "flame")
                }.tag(TabViews.spells)
            GeneralCharacterInfo(character: $character)
                .tabItem {
                    Label("Character", systemImage: "figure.stand")
                }.tag(TabViews.character)
            
        }
        .navigationTitle(navigationTitle)
        .padding()
    }
}

#Preview {
    NavigationStack {
        CharacterView(character: .constant(DndCharacter.sampleData[0]))
    }
}
