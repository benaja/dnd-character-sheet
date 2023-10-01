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
                ZStack {
                    Image(systemName: "shield.fill")
                        .resizable(resizingMode: .stretch)
                        .foregroundColor(.gray).opacity(0.3)
                    
                    VStack {
                        Text("AC")
                            .font(.caption)
//                        AutoSavingTextField("AC", text: $character.ac)
//                            .multilineTextAlignment(.center)
                    }
                    
                }.frame(width: 100, height: 100)
                
                ShowHP(character: $character)
                    .padding(0.0)
                
                ZStack {
                    Image(systemName: "octagon.fill")
                        .resizable(resizingMode: .stretch)
                        .foregroundColor(.gray).opacity(0.3)
                        .scaledToFit()
                    
                    VStack {
                        Text("Hit Dice")
                            .font(.caption)
                        Text("2w8")
                            .font(.title)
                    }
                    
                }.frame(width: 100, height: 100)
            }
        }
    }
    
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: DndCharacter.self, configurations: config)

    
    return StatsView(character: .constant(DndCharacter.sampleData[0]))
        .modelContainer(container)

    
}
