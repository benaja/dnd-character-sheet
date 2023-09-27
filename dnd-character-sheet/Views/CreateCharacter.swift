//
//  CreateCharacter.swift
//  dnd-character-sheet
//
//  Created by Benaja on 26.09.23.
//

import SwiftUI

struct CreateCharacter: View {
    @Binding var isPresentingNewCharacterView: Bool
    @State var character: DndCharacter = DndCharacter.emptyCharacter()
    @StateObject private var store = CharacterStore()
    
    
    var body: some View {
        NavigationStack {
            VStack (alignment: .leading) {
                LabelTextField("Name", value: $character.name, placeholder: "My Character")
                    .padding(.bottom)
                LabelTextField("Race", value: $character.race, placeholder: "Human")
                    .padding(.bottom)
                LabelTextField("Class", value: $character.dndClass, placeholder: "Elf")
                    .padding(.bottom)
                LabelTextField("Level",
                               value: Binding(
                                get: { String(character.level) },
                                set: { character.level = Int($0) ?? 0 }
                ), placeholder: "Elf", keyboardType: .numberPad)
                
                EditableCircularProfileImage(image: $character.profileImage)
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
                            do {
                                try await store.save(character: character)
                                character = DndCharacter.emptyCharacter()
                            } catch {
                                fatalError(error.localizedDescription)
                            }
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
