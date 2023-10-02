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
            VStack (spacing: 0) {
                Text("Speed")
                    .font(.caption)
                AutoSavingTextField("", text: $character.speed)
                    .multilineTextAlignment(.center)
                
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            
            
            EditInitiative(character: $character)
                .frame(minWidth: 0, maxWidth: .infinity)
            
            EditProfBonus(character: $character)
                .frame(minWidth: 0, maxWidth: .infinity)
            
            EditPassiveWis(character: $character)
                .frame(minWidth: 0, maxWidth: .infinity)
//
//            VStack {
//                Text("Passive Wis")
//                    .font(.caption)
//                Text(String(character.dex.value + character.initiativeBonus))
//                    .font(.title)
//            }.frame(minWidth: 0, maxWidth: .infinity)
            
        }.keyboardType(.numberPad)
    }
}

#Preview {
    let container = previewContainer()
   
    return MainStats(character: .constant(DndCharacter.sampleData[0]))
        .modelContainer(container)
}
