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
    
    var body: some View {
        EditSheet(showSheet: $showSheet, 
                  applyChanges: {},
                  button: {
            VStack {
                Text("Initiative")
                    .font(.caption)
                Text(String(character.dex.value + character.initiativeBonus))
                    .font(.title)
            }
        }) {
            VStack() {
                
            }
            .navigationTitle("Initiative")
        }
    }
}

#Preview {
    let container = previewContainer()
    @State var character = DndCharacter.sampleData[0]
    
    return EditInitiative(character: $character)
}
