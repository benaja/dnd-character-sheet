//
//  StatsView.swift
//  dnd-character-sheet
//
//  Created by Benaja on 29.09.2023.
//

import SwiftUI
import CoreData

struct StatsView: View {
    @Binding var character: DndCharacter
    var container: NSPersistentContainer!
    
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
                        
                        TextField("AC", text: $character.ac)
                            .font(.title)
                        .multilineTextAlignment(.center)
                    }
                    
                }.frame(width: 100, height: 100)
                
                VStack {
                    ZStack {
                        Rectangle()
                            .fill(.gray)
                            .opacity(0.3)
                            .frame(width: 100, height: 60)
                        
                        VStack {
                            Text("HP")
                                .font(.caption)
                            Text("12")
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
                            Text("21")
                                .font(.subheadline)
                        }
                    }
                }
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
        .onAppear {
            guard container != nil else {
                fatalError("This view needs a persistent container.")
            }
            print("view apperad")
        }
    }
    
}

#Preview {
    StatsView(character: .constant(DndCharacter.sampleData[0]))
}
