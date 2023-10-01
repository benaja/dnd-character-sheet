//
//  ShowHP.swift
//  dnd-character-sheet
//
//  Created by Benaja on 01.10.2023.
//

import SwiftUI
import SwiftData

struct ShowHP: View {
    @Binding var character: DndCharacter
    @State var showEditSheet = false
    @Environment(\.modelContext) private var context
    
    enum ModifyType: String, CaseIterable, Identifiable {
        case damage
        case heal
        case temp
        
        var id: Self { self }
    }
    
    var body: some View {
        Button(action: {
            showEditSheet = true
        }) {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(.gray)
                        .opacity(0.3)
                        .frame(width: 100, height: 60)
                    
                    VStack {
                        Text("HP")
                            .font(.caption)
                        Text("\(character.hp)")
                            .font(.title)
                    }
                }
                ZStack {
                    Rectangle()
                        .fill(.gray)
                        .opacity(0.3)
                        .frame(width: 100, height: 30)
                    
                    HStack {
                        Text("Max HP")
                            .font(.caption)
                        Text(String(character.maxHp))
                            .font(.subheadline)
                    }
                }
            }
        }
        .foregroundColor(.primary)
        .sheet(isPresented: $showEditSheet) {
            EditHP(character: $character, showEditSheet: $showEditSheet)
                .presentationDetents([.medium])
        }
    }
    
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: DndCharacter.self, configurations: config)
    
    
    return ShowHP(character: .constant(DndCharacter.sampleData[0]))
}
