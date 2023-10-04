//
//  InventoryView.swift
//  dnd-character-sheet
//
//  Created by Benaja on 29.09.2023.
//

import SwiftUI

struct InventoryView: View {
    @EnvironmentObject var character: DndCharacter
//    @State private var editMode = EditMode.active
    
    var body: some View {
        VStack (alignment: .leading) {
            Text("Inventory")
            List {
                Section(header: VStack {
                    Text("Inventory")
                }) {
                    ForEach(character.weapons, id: \.name) { weapon in
                        Text(weapon.name)
                    }.onMove { from, to in
                        character.weapons.move(fromOffsets: from, toOffset: to)
                        // TODO: move the data source.
                    }

                }
                
                Section(header: Text("Items")) {
                    ForEach(0 ..< 40) {item in
                            Text(String(item))
                    }
                }
            }
        }
//            .environment(\.editMode, $editMode)


    }
}

#Preview {
    let container = previewContainer()
    @State var character = DndCharacter.sampleData[0]
    
    character.weapons = [
        DndCharacter.Weapon(name: "Axe"),
        DndCharacter.Weapon(name: "Sword"),
        DndCharacter.Weapon(name: "Crossbow")
    ]
    
    return InventoryView()
        .environmentObject(character)
}
