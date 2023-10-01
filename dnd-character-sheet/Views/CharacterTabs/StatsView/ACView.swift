//
//  ArmorClass.swift
//  dnd-character-sheet
//
//  Created by Benaja on 01.10.2023.
//

import SwiftUI
import SwiftData

struct ACView: View {
    @Binding var character: DndCharacter
    @State var showSheet = false
    @State var ac: String = ""
    @State var acModifier: String = ""
    @Environment(\.modelContext) private var context
    
    var body: some View {
        Button(action: {
            showSheet = true
        }) {
            ZStack {
                Image(systemName: "shield.fill")
                    .resizable(resizingMode: .stretch)
                    .foregroundColor(.gray).opacity(0.3)
                
                VStack {
                    Text("AC")
                        .font(.caption)
                    Text(character.ac + (character.acModifier.isEmpty ? "" : "+\(character.acModifier)"))
                        .font(.title)
//                    AutoSavingTextField("AC", text: $character.ac)
//                        .multilineTextAlignment(.center)
                }
                
            }
        }
        .foregroundColor(.primary)
        .frame(width: 100, height: 100)
            .sheet(isPresented: $showSheet) {
                NavigationStack {
                    VStack (spacing: 20) {
                        LabelTextField("AC", value: $ac)
                            .keyboardType(.numberPad)
                        
                        LabelTextField("AC Modifier", value: $acModifier, placeholder: "0")
                            .keyboardType(.numberPad)
                    }
                        .navigationTitle("AC")
                        .navigationBarTitleDisplayMode(.inline)
                        .padding()
                        .toolbar() {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Cancel") {
                                    showSheet = false
                                }
                            }
                            ToolbarItem(placement: .confirmationAction) {
                                Button("Apply") {
                                    applyChanges()
                                }
                            }
                        }
                        .onAppear(){
                            ac = character.ac
                            acModifier = character.acModifier
                        }
                    
                }
                .presentationDetents([.height(200)])
            }
    }
    
    func applyChanges() {
        character.ac = ac
        character.acModifier = acModifier
        do {
            try context.save()
            showSheet = false
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: DndCharacter.self, configurations: config)
    
    @State var character = DndCharacter.sampleData[0]
    return ACView(character: $character)
}
