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
        VStack  {
            HStack(spacing: 20) {
                ACView(character: $character)
                
                ShowHP(character: $character)
                    .padding(0.0)
                
                HitDiceView(character: $character)
            }
            
            MainStats(character: $character)
        }
    }
    
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: DndCharacter.self, configurations: config)

    
    return StatsView(character: .constant(DndCharacter.sampleData[0]))
        .modelContainer(container)

    
}
