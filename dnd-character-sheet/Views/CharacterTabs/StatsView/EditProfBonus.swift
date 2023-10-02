//
//  EditProfBonus.swift
//  dnd-character-sheet
//
//  Created by Benaja on 02.10.2023.
//

import SwiftUI

struct EditProfBonus: View {
        @Binding var character: DndCharacter
        @State var showSheet = false
    @State var profBonus: Int? = 0
        @Environment(\.modelContext) private var context
        
        var formattedProfBonus: String {
            stringModifier(character.profBonus)
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
                    Text("Proficeny")
                        .font(.caption)
                    Text(formattedProfBonus)
                        .font(.title)
                }
                
            }
            .editSheet(isPresented: $showSheet,
                       applyChanges: applyChanges,
                       presentationDetents: [.height(200)]
            ) {
                VStack(spacing: 0) {
                    NumberField("", value: $profBonus)
                }
                .onAppear() {
                    profBonus = character.profBonus
                }
                .navigationTitle("Proficeny")
                
            }
    }
    
    func applyChanges() {
        character.profBonus = profBonus ?? 0
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
    
    return EditProfBonus(character: $character)
        .modelContainer(container)
}
