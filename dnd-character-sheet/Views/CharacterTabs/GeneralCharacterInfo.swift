//
//  GeneralCharacterInfo.swift
//  dnd-character-sheet
//
//  Created by Benaja on 29.09.2023.
//

import SwiftUI

struct GeneralCharacterInfo: View {
    @Binding var character: DndCharacter
    
    var body: some View {
        VStack (alignment: .leading){
            HStack() {
                Text("Race")
                    .fontWeight(.thin)
                Text(character.race)
            }
            .padding(.bottom)
            HStack() {
                Text("Class")
                    .fontWeight(.thin)
                Text(character.dndClass)
            }
            .padding(.bottom)
            HStack() {
                Text("Level")
                    .fontWeight(.thin)
                Text(character.level)
            }
            .padding(.bottom)
            
            EditableCircularProfileImage(image: $character.profileImage)
            
            
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
    }
}

#Preview {
    GeneralCharacterInfo(character: .constant(DndCharacter.sampleData[0]))
}
