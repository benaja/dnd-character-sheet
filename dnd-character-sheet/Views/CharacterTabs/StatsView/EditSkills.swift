//
//  CharacterStats.swift
//  dnd-character-sheet
//
//  Created by Benaja on 02.10.2023.
//

import SwiftUI

struct EditSkills: View {
    @Binding var character: DndCharacter
    @State var showSheet = false
    @State var passiveWisBonus: Int? = 0
    @Environment(\.modelContext) private var context
    
    var body: some View {
        VStack (alignment: .leading) {
            Text("SKILLS")
                .font(.caption)
                .padding(.horizontal, 20)
            
            VStack {
                VStack {
                    EditSkill(skill: $character.acrobatics, stat: $character.dex, character: $character)
                    Divider()
                    EditSkill(skill: $character.animalHandling, stat: $character.wis, character: $character)
                    Divider()
                    EditSkill(skill: $character.arcana, stat: $character.int, character: $character)
                    Divider()
                    EditSkill(skill: $character.athletics, stat: $character.str, character: $character)
                    Divider()
                    EditSkill(skill: $character.deception, stat: $character.dex, character: $character)
                    Divider()
                    EditSkill(skill: $character.history, stat: $character.cha, character: $character)
                    Divider()
                    EditSkill(skill: $character.insight, stat: $character.wis, character: $character)
                    Divider()
                    EditSkill(skill: $character.intimidation, stat: $character.cha, character: $character)
                    Divider()
                    EditSkill(skill: $character.investigation, stat: $character.int, character: $character)
                    Divider()
                    EditSkill(skill: $character.medicine, stat: $character.wis, character: $character)
                    Divider()
                    EditSkill(skill: $character.nature, stat: $character.int, character: $character)
                    Divider()
                    EditSkill(skill: $character.perception, stat: $character.wis, character: $character)
                    Divider()
                    EditSkill(skill: $character.performance, stat: $character.cha, character: $character)
                    Divider()
                    EditSkill(skill: $character.persuasion, stat: $character.cha, character: $character)
                    Divider()
                    EditSkill(skill: $character.religion, stat: $character.int, character: $character)
                    Divider()
                    EditSkill(skill: $character.sleigthOfHand, stat: $character.dex, character: $character)
                    Divider()
                    EditSkill(skill: $character.stealth, stat: $character.dex, character: $character)
                    Divider()
                    EditSkill(skill: $character.survical, stat: $character.wis, character: $character)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                .background(Colors.ElevatedBackground.color)
            }
            .cornerRadius(12)
        }
    }
}

#Preview {
    let container = previewContainer()
    @State var character = DndCharacter.sampleData[0]
    
    return ScrollView {
        VStack (alignment: .leading) {
            EditSkills(character: $character)
                .modelContainer(container)
        }.padding()
            .background(Colors.PrimaryBackground.color)
    }.background()
}
