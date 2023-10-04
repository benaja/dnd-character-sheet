//
//  StatsView.swift
//  dnd-character-sheet
//
//  Created by Benaja on 29.09.2023.
//

import SwiftUI
import SwiftData


struct StatsView: View {
    @Binding var character: DndCharacter
    @Environment(\.modelContext) private var context
    
    var body: some View {
        ScrollView () {
                VStack (alignment: .leading) {
                    HStack(spacing: 20) {
                        ACView(character: $character)
                        
                        ShowHP(character: $character)
                            .padding(0.0)
                        
                        HitDiceView(character: $character)
                    }
                    
                    MainStats(character: $character)
                        .padding(.vertical, 20)
                    
                    
                    EditAbilities(character: $character)
                    
                    
                    
                    EditSkills(character: $character)
                        .padding(.top, 20)
                }
            .padding()
        }.background(Colors.PrimaryBackground.color.ignoresSafeArea())
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: DndCharacter.self, configurations: config)
    
    @State var offset = CGFloat.zero

    
    return NavigationStack {
        StatsView(character: .constant(DndCharacter.sampleData[0]))
            .modelContainer(container)
            .navigationTitle("hey there")
    }

    
}
