//
//  CharacterView.swift
//  dnd-character-sheet
//
//  Created by Benaja on 27.09.23.
//

import SwiftUI

struct CharacterView: View {
    @Binding var character: DndCharacter
    
    var body: some View {
        VStack (alignment: .leading){
            HStack() {
                Text("Race")
                    .fontWeight(.thin)
                Text(character.race)
            }
            HStack() {
                Text("Class")
                    .fontWeight(.thin)
                Text(character.dndClass)
            }
            HStack() {
                Text("Level")
                    .fontWeight(.thin)
                Text(character.level)
            }
            
            EditableCircularProfileImage(image: $character.profileImage)
            
            LabelTextField("Prof Bons", value: Binding(get: {"\($character.profBonus)"}, set: {character.profBonus = Int($0) ?? 0}))
            
            Text("\(character.profBonus)")
            
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .padding()
        .navigationTitle(character.name)
        .toolbar {
            Button("Edit") {}
        }
    }
}

#Preview {
    NavigationStack {
        CharacterView(character: .constant(DndCharacter.sampleData[0]))
    }
}
