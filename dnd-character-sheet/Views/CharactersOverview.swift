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
            List {
                ForEach(characters) {character in
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
                .onDelete(perform: { offsets in
                    for index in offsets {
//                        guard let character = characters[index] else {
//                            fatalError("item not found")
//                        }
                        
                        
                        context.delete(characters[index])
                    }
                    
                })
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
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: DndCharacter.self, configurations: config)
    
    let context = container.mainContext
    
    DndCharacter.sampleData.forEach { character in
        context.insert(character)
    }

    
    return CharactersOverview()
        .modelContainer(container)
//        .context
}
