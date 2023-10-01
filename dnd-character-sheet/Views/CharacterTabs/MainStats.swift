//
//  MainStats.swift
//  dnd-character-sheet
//
//  Created by Benaja on 01.10.2023.
//

import SwiftUI
import SwiftData

struct MainStats: View {
    @Binding var character: DndCharacter
    
    var body: some View {
        HStack {
            LabelTextField("Speed", value: $character.speed, alignment: .center, textFont: .title)
                .frame(minWidth: 0, maxWidth: .infinity)
            
            VStack {
                Text("Initiative")
                    .font(.caption)
                Text(String(character.dex.value + character.initiativeBonus))
                    .font(.title)
            }.frame(minWidth: 0, maxWidth: .infinity)
            
            LabelTextField("Proficeny", value: $character.speed, alignment: .center, textFont: .title)
                .frame(minWidth: 0, maxWidth: .infinity)
            
            EditInitiative(character: $character)
                .frame(minWidth: 0, maxWidth: .infinity)
        }.keyboardType(.numberPad)
    }
}

#Preview {
    let container = previewContainer()
   
    return MainStats(character: .constant(DndCharacter.sampleData[0]))
        .modelContainer(container)
}
