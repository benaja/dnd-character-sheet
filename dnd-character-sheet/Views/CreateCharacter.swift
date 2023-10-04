//
//  CreateCharacter.swift
//  dnd-character-sheet
//
//  Created by Benaja on 26.09.23.
//

import SwiftUI

struct CreateCharacter: View {
    @Binding var isPresentingNewCharacterView: Bool
    @ObservedObject var character: DndCharacter = DndCharacter.emptyCharacter()
    @Environment(\.modelContext) private var context
//    @EnvironmentObject var store: CharacterStore
    
    var body: some View {
        NavigationStack {
            VStack (alignment: .leading) {
                LabelTextField("Name", value: $character.name, placeholder: "My Character")
                    .padding(.bottom)
                LabelTextField("Race", value: $character.race, placeholder: "Human")
                    .padding(.bottom)
                LabelTextField("Class", value: $character.dndClass, placeholder: "Elf")
                    .padding(.bottom)
                LabelTextField("Level", value: Binding(
                    get: { String(character.totalLevel)},
                    set: { character.totalLevel = Int($0) ?? 0}
                ), placeholder: "Elf")
                .keyboardType(.numberPad)
                
                EditableCircularProfileImage(imagePath: Binding(get: {character.profileImagePath}, set: {
                    print($0 ?? "")
                    character.profileImagePath = $0
                }))
                Spacer()
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Dismiss") {
                        isPresentingNewCharacterView = false
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Create") {
                        Task {
                            context.insert(character)
                        }
                        isPresentingNewCharacterView = false
                    }
                }
            }
        }
    }
}

#Preview {
    @State var character: DndCharacter = DndCharacter.emptyCharacter()
    @State var isPresenting = true
    
    return CreateCharacter(isPresentingNewCharacterView: $isPresenting)
}
