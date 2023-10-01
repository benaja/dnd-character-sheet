//
//  AutoSavingTextField.swift
//  dnd-character-sheet
//
//  Created by Benaja on 30.09.2023.
//

import SwiftUI

struct AutoSavingTextField: View {
    var label: String
    @Binding var text: String
    @FocusState var isFocused: Bool
    @Environment(\.modelContext) private var context
    
    init(_ label: String, text: Binding<String>) {
        self.label = label
        self._text = text
    }
    
    var body: some View {
        TextField("AC", text: $text)
            .font(.title)
            .focused($isFocused)
            .onChange(of: isFocused) {
                do {
                    try context.save()
                } catch {
                    fatalError(error.localizedDescription)
                }
            }
    }
}

#Preview {
    AutoSavingTextField("Enter text", text: .constant("hey"))
}
