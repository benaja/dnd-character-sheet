//
//  EditCharacterStat.swift
//  dnd-character-sheet
//
//  Created by Benaja on 02.10.2023.
//

import SwiftUI

struct EditAbility: View {
    @Binding var character: DndCharacter
    @Binding var stat: DndCharacter.Stat
    var label: String
    
    @State var showSheet = false
    @Environment(\.modelContext) private var context
    
    @State var statValue: Int? = 0
    @State var savingBonus: Int? = 0
    @State var isProf = false
    var modifier: Int {
        ((statValue ?? 0) / 2) - 5
    }

    var body: some View {
        Button (action: {
            showSheet = true
        }) {
            ZStack (alignment: .leading) {
                Rectangle()
                    .fill(Colors.ElevatedBackground.color)
                    .frame(width: .infinity, height: 100)
                
                VStack (alignment: .leading, spacing: 5) {
                    HStack {
                        Text(label)
                            .bold()
                        Spacer()
                        Text(String(stat.value))
                            .bold()
                            .font(.title2)
                    }
                    HStack {
                        VStack {
                            Text("Mod")
                                .font(.caption2)
                            Text(formattedNumber(stat.modifier))
                                .font(.title)
                        }
                        Spacer()
                        
                        Divider()
                            .frame(height: 40)
                        Spacer()
                        
                        VStack {
                            Text("Sav")
                                .font(.caption2)
                            Text(formattedNumber(stat.savingThrowMod(profBonus: character.profBonus)))
                                .font(.title)
                        }
                    }
                    
                }.padding(.horizontal)
            }
        }
        .frame(maxWidth: .infinity)
        .editSheet(isPresented: $showSheet, applyChanges: applyChanges, presentationDetents: [.height(500)]) {
            VStack(alignment: .leading, spacing: 0) {
                Text("Score")
                    .font(.caption)
                NumberField("", value: $statValue)
                    .padding(.bottom, 20)
                
                Text("Mod")
                    .font(.caption)
                Text(formattedNumber(modifier))
                    .font(.title)
                    .padding(.bottom, 20)
                
                Divider()
                
                Text("Saving Throw")
                    .font(.title2)
                    .padding(.vertical, 20)
                    
                Text("Bonus")
                    .font(.caption)
                    .padding(0)
                NumberField("", value: $savingBonus)
                    .padding(0)
                    
                
                Toggle("Is Prof (+\(character.profBonus))", isOn: $isProf)
                    .frame(maxWidth: 180)
                    .padding(.vertical, 20)
                
                Text("Saving throw mod")
                    .font(.caption)
                Text(formattedNumber(modifier + (savingBonus ?? 0) + (isProf ? character.profBonus : 0 )))
                    .font(.title)

            }
            .navigationTitle(label)
            .onAppear(){
                statValue = stat.value
                savingBonus = stat.bonus
                isProf = stat.prof
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
        stat.value = statValue ?? 0
        stat.bonus = savingBonus ?? 0
        stat.prof = isProf
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
    
    
    return HStack (spacing: 20) {
        EditAbility(character: $character,
                    stat: $character.str, label: "Strength")
        EditAbility(character: $character,
                    stat: $character.dex, label: "Dexterity")
    }.padding().background(Color(UIColor.systemGroupedBackground))
}
