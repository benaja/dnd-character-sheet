//
//  CharactersOverview.swift
//  dnd-character-sheet
//
//  Created by Benaja on 26.09.23.
//

import SwiftUI

struct CharactersOverview: View {
    var characters = DndCharacter.sampleData
    @State var showCreateCharacter = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(characters) { character in
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
