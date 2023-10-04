//
//  EditInitiative.swift
//  dnd-character-sheet
//
//  Created by Benaja on 01.10.2023.
//

import SwiftUI

struct EditPassiveWis: View {
    @Binding var character: DndCharacter
    @State var showSheet = false
    @State var passiveWisBonus: Int? = 0
    @Environment(\.modelContext) private var context
    
    var formattedPasiveWis: String {
        String(10 + character.wis.modifier + character.passivePerceptionBonus + character.perception.bonus + (character.perception.prof ? character.profBonus : 0) + (character.perception.exp ? character.profBonus * 2 : 0))
    }
    
    var currentFormattedPassiveWis: String {
        String(10 + character.wis.modifier + (passiveWisBonus ?? 0))
    }
    
    func stringModifier(_ value: Int) -> String {
        if (value >= 0) {
            return "+\(value)"
        }
        
        return String(value)
    }
    
    var body: some View {
        Button (action: {
            showSheet = true
        }){
            VStack {
                Text("Passive Wis")
                    .font(.caption)
                Text(formattedPasiveWis)
                    .font(.title)
            }
            
        }
        .editSheet(isPresented: $showSheet,
                   applyChanges: applyChanges,
                   presentationDetents: [.height(300)]
        ) {
            VStack(alignment: .leading, spacing: 0) {
                Text("10 + Perception Mod + Bonus (10 + \(character.wis.modifier) + \(passiveWisBonus ?? 0))")
                    .padding(.bottom, 5)
                Text(currentFormattedPassiveWis)
                    .font(.title)
                    .padding(.bottom, 30)
                
                Text("Bonus")
                    .font(.caption)
                NumberField("", value: $passiveWisBonus)
            }
            .onAppear() {
                passiveWisBonus = character.passivePerceptionBonus
            }
            .navigationTitle("Passive Wis (Perception)")
            
        }
    }
    
    func applyChanges() {
        character.passivePerceptionBonus = passiveWisBonus ?? 0
        do {
            try context.save()
            showSheet = false
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}

#Preview {
    let container = previewContainer()
    @State var character = DndCharacter.sampleData[0]
    
    return EditPassiveWis(character: $character)
        .modelContainer(container)
}
