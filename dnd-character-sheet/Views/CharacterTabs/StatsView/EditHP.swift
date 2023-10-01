//
//  EditHP.swift
//  dnd-character-sheet
//
//  Created by Benaja on 30.09.2023.
//

import SwiftUI
import SwiftData

public struct SelectTextOnEditingModifier: ViewModifier {
    public func body(content: Content) -> some View {
        content
            .onReceive(NotificationCenter.default.publisher(for: UITextField.textDidBeginEditingNotification)) { obj in
                if let textField = obj.object as? UITextField {
                    textField.selectedTextRange = textField.textRange(from: textField.beginningOfDocument, to: textField.endOfDocument)
                }
            }
    }
}

extension View {
    
    /// Select all the text in a TextField when starting to edit.
    /// This will not work with multiple TextField's in a single view due to not able to match the selected TextField with underlying UITextField
    public func selectAllTextOnEditing() -> some View {
        modifier(SelectTextOnEditingModifier())
    }
}


struct EditHP: View {
    @Binding var character: DndCharacter
    @Binding var showEditSheet: Bool
    @State var maxHp: Int? = 0;
    @State var life: Int? = 0;
    @State var modifyType: ModifyType = ModifyType.damage
    @Environment(\.modelContext) private var context
    @FocusState var focusedField: Field?
    
    enum Field: Int, CaseIterable {
        case maxHp
        case life
    }
    
    enum ModifyType: String, CaseIterable, Identifiable {
        case damage
        case heal
        case temp
        
        var id: Self { self }
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 40) {
                HStack {
                    VStack{
                        Text("Current HP")
                            .font(.caption)
                        Text("\(character.hp)")
                            .font(.title)
                    }.frame(minWidth: 0, maxWidth: .infinity)
                    
                    
                    VStack (spacing: 0) {
                        LabelTextField(
                            "Max HP",
                           value: Binding(
                            get: { maxHp != nil ? "\(maxHp!)" : ""},
                            set: { maxHp = Int($0) ?? nil}),
                            placeholder: "",
                            alignment: .center,
                            textFont: .title
                        ).keyboardType(.numberPad)                        
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    
                }
                Picker("Flavor", selection: $modifyType) {
                    ForEach(ModifyType.allCases) { type in
                        Text(type.rawValue.capitalized)
                    }
                }
                .pickerStyle(.segmented)
                
                NumberField("", value: $life, min: 0)
                
                
            }
            .toolbar() {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        showEditSheet = false
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Apply") {
                        applyChanges()
                    }
                }
            }
            .padding()
            .navigationTitle("HP Management")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(){
                maxHp = character.maxHp
                life = 0
                modifyType = .damage
            }
        }
    }
    
    func newHP() -> Int {
        guard let life = life else {
            return character.hp
        }
        switch modifyType {
        case .damage:
            return max(character.hp - life, 0)
        case .heal:
            return min(character.hp + life, character.maxHp)
        case .temp:
            return character.hp + life
        }

    }
    
    func applyChanges() {
        character.hp = newHP()
        if let maxHp = maxHp {
            character.maxHp = maxHp
        }
        do {
            try context.save()
            showEditSheet = false
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: DndCharacter.self, configurations: config)

    
    return EditHP(character: .constant(DndCharacter.sampleData[0]),
                  showEditSheet: .constant(true))
    
}
