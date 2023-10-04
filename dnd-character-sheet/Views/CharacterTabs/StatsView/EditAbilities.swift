//
//  CharacterStats.swift
//  dnd-character-sheet
//
//  Created by Benaja on 02.10.2023.
//

import SwiftUI

struct EditAbilities: View {
    @Binding var character: DndCharacter
    @State var showSheet = false
    @State var passiveWisBonus: Int? = 0
    @Environment(\.modelContext) private var context
    
    var body: some View {
        VStack (alignment: .leading) {
            Text("ABILITIES")
                .font(.caption)
                .padding(.horizontal, 20)
            VStack (spacing: 20) {
                HStack (spacing: 20) {
                    EditAbility(character: $character, stat: $character.str, label: "Strength")
                    
                    EditAbility(character: $character, stat: $character.dex, label: "Dexterity")
                }.frame(maxWidth: .infinity)
                
                HStack (spacing: 20) {
                    EditAbility(character: $character, stat: $character.con, label: "Constitution")
                    
                    EditAbility(character: $character, stat: $character.int, label: "Intelligence")
                }
                
                HStack (spacing: 20) {                EditAbility(character: $character, stat: $character.wis, label: "Wisdom")
                    
                    EditAbility(character: $character, stat: $character.cha, label: "Charisma")
                }

            }.frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    let container = previewContainer()
    @State var character = DndCharacter.sampleData[0]
    
    return EditAbilities(character: $character)
        .background(Colors.PrimaryBackground.color)
        .modelContainer(container)
}
