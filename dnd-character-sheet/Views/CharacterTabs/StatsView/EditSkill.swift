//
//  EditCharacterStat.swift
//  dnd-character-sheet
//
//  Created by Benaja on 02.10.2023.
//

import SwiftUI

struct EditSkill: View {
    @Binding var skill: DndCharacter.Skill
    @Binding var stat: DndCharacter.Stat
    @Binding var character: DndCharacter
    
    @State var showSheet = false
    @Environment(\.modelContext) private var context

    
    @State var bonus: Int? = 0
    @State var isProf = false
    @State var isExpert = false
    
    var body: some View {
        Button (action: {
            showSheet = true
        }) {
            HStack {
                Text(skill.name)
                Spacer()
                
                if skill.prof || skill.exp {
                    Image(systemName: "star")
                }
                if skill.exp {
                    Image(systemName: "star")
                }
                Text(formattedNumber(stat.modifier + skill.bonus + (skill.prof ? character.profBonus : 0) + (skill.exp ? character.profBonus * 2 : 0)))
                    .bold()
            }.padding(.vertical, 4)
        }
        .editSheet(isPresented: $showSheet, applyChanges: applyChanges, presentationDetents: [.height(400)]) {
            VStack(alignment: .leading, spacing: 20 ) {
                Text(formattedNumber(stat.modifier + (bonus ?? 0) + (isProf ? character.profBonus : 0) + (isExpert ? character.profBonus * 2 : 0)))
                    .font(.largeTitle)
                    .padding(.bottom, 20)
                
                Text("\(stat.name): \(formattedNumber(stat.modifier))")
                
                VStack (alignment: .leading, spacing: 0) {
                    Text("Bonus")
                        .font(.caption)
                    NumberField("", value: $bonus)
                }
                
               
                Toggle("Is Prof (+\(character.profBonus))", isOn: $isProf)

                Toggle("Is Expert (+\(character.profBonus * 2))", isOn: $isExpert)

                
            }
            .navigationTitle(skill.name)
            .onAppear(){
                bonus = skill.bonus
                isProf = skill.prof
                isExpert = skill.exp
            }
        }
        .onChange(of: isExpert) {
            if isExpert {
                isProf = false
            }
        }
        .onChange(of: isProf) {
            if isProf {
                isExpert = false
            }
        }

    }
    
    func formattedNumber(_ value: Int) -> String {
        if (value >= 0) {
            return "+\(value)"
        }
        
        return String(value)
    }
    
    func applyChanges() {
        skill.bonus = bonus ?? 0
        skill.prof = isProf
        skill.exp = isExpert
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
    
    
    return VStack {
        EditSkill(skill: $character.acrobatics, stat: $character.dex, character: $character)
        Divider()
        EditSkill(skill: $character.animalHandling, stat: $character.wis, character: $character)
    }.padding()
}
