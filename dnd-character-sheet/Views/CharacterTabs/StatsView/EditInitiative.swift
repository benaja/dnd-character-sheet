//
//  EditInitiative.swift
//  dnd-character-sheet
//
//  Created by Benaja on 01.10.2023.
//

import SwiftUI

struct EditInitiative: View {
    @Binding var character: DndCharacter
    @State var showSheet = false
    @State var initiativeBonus = 0
    @Environment(\.modelContext) private var context
    
    var initiative: String {
        stringModifier(character.dex.modifier + character.initiativeBonus)
    }
    
    var currentInitiative: String {
        stringModifier(character.dex.modifier + initiativeBonus)
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
                Text("Initiative")
                    .font(.caption)
                Text(initiative)
                    .font(.title)
            }
            
        }
        .editSheet(isPresented: $showSheet, 
                   applyChanges: applyChanges,
                   presentationDetents: [.height(300)]
        ) {
            VStack(alignment: .leading, spacing: 0) {
                Text("Dex mod + bonus (\(character.dex.modifier) + \(initiativeBonus))")
                    .padding(.bottom, 5)
                Text(currentInitiative)
                    .font(.title)
                    .padding(.bottom, 30)
                
                Text("Bonus")
                    .font(.caption)
                NumberField("", value: Binding(
                    get: {initiativeBonus},
                    set: { initiativeBonus = $0 ?? 0 }
                ))
            }
            .onAppear() {
                initiativeBonus = character.initiativeBonus
            }
            .navigationTitle("Initiative")
            
        }
    }
    
    func applyChanges() {
        character.initiativeBonus = initiativeBonus
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
    
    return EditInitiative(character: $character)
        .modelContainer(container)
}
