//
//  CharactersOverview.swift
//  dnd-character-sheet
//
//  Created by Benaja on 26.09.23.
//

import SwiftUI
import SwiftData

struct CharactersOverview: View {
    @Environment(\.modelContext) private var context
    @Query private var characters: [DndCharacter]
//    @Binding var characters: [DndCharacter]
    @State var showCreateCharacter = false
    
    var body: some View {
        NavigationStack {
            List (characters, id: \.id) { character in
                NavigationLink(destination: {
                    CharacterView(character: character)
                })
                {
                    VStack (alignment: .leading) {
                        HStack {
                            VStack (alignment: .leading) {
                                Text(character.name)
                                Text("Race: \(character.race), Class: \(character.dndClass)")
                                    .font(.caption)
                            }
                            Spacer()
                            Text("Level: \(character.level)")
                                .font(.caption)
                        }
                    }
                }
                
            }
            .navigationTitle("Characters")
            .toolbar{
                Button(action: {
                    showCreateCharacter = true
                }) {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showCreateCharacter) {
                CreateCharacter(isPresentingNewCharacterView: $showCreateCharacter)
            }
        }
    }
}

#Preview {
    CharactersOverview()
}
