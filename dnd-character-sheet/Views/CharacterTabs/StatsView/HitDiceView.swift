//
//  HitDiceView.swift
//  dnd-character-sheet
//
//  Created by Benaja on 01.10.2023.
//

import SwiftUI
import SwiftData

struct HitDiceView: View {
    @Binding var character: DndCharacter
    @State var showSheet = false
    @State var dice: Dice = .D8
    @State var remainingHitDice: Int = 0
    @Environment(\.modelContext) private var context
    
    
    var body: some View {
        Button(action: {
            showSheet = true
        }) {
            ZStack {
                Image(systemName: "octagon.fill")
                    .resizable(resizingMode: .stretch)
                    .foregroundColor(.gray).opacity(0.3)
                    .scaledToFit()
                
                VStack {
                    Text("Hit Dice")
                        .font(.caption)
                    Text("\(character.remainingHitDice) \(character.hitDice.rawValue)")
                        .font(.title)
                }
                
            }.frame(width: 100, height: 100)
        }
        .foregroundColor(.primary)
        .sheet(isPresented: $showSheet) {
            EditSheet(showSheet: $showSheet, applyChanges: {
                character.hitDice = dice
                character.remainingHitDice = remainingHitDice
                do {
                    try context.save()
                    showSheet = false
                } catch {
                    fatalError(error.localizedDescription)
                }
            }) {
                VStack {
                    HStack {
                        Text("Total Hit dice: \(character.totalLevel)")
                        
                        Picker("Dice", selection: $dice) {
                            ForEach(Dice.allCases) { dice in
                                Text(dice.rawValue).tag(dice)
                            }
                        }.pickerStyle(.menu)
                    }.padding(.bottom, 50.0)
                    
                    Text("Remaining Hit Dice")
                    NumberField("", value: Binding(
                        get: { remainingHitDice },
                        set: { remainingHitDice = $0 ?? 0 }
                    ), min: 0, max: character.totalLevel)

                }.navigationTitle("Hit Dice")
                    .onAppear() {
                        remainingHitDice = character.remainingHitDice
                        dice = character.hitDice
                    }
            }
            .presentationDetents([.height(300)])
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: DndCharacter.self, configurations: config)

    @State var character = DndCharacter.sampleData[1]
    
    return HitDiceView(character: $character)
}
