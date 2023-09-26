//
//  LabelTextField.swift
//  dnd-character-sheet
//
//  Created by Benaja on 26.09.23.
//

import SwiftUI

struct LabelTextField: View {
    let placeholder: String
    let label: String?
    let keyboardType: UIKeyboardType
    @Binding var value: String
    
    
    var body: some View {
        VStack (alignment: .leading) {
            if (label != nil) {
                Text(label!)
                    .font(.caption)
            }
            TextField(placeholder, text: $value)
                .keyboardType(keyboardType)
        }
    }
    
    init(_ label: String?, 
         value: Binding<String>,
         placeholder: String = "Enter text...",
         keyboardType: UIKeyboardType = UIKeyboardType.default) {
        self.label = label
        self._value = value
        self.placeholder = placeholder
        self.keyboardType = keyboardType
    }
}


#Preview {
    @State var text: String = ""
    
    return LabelTextField("Label", value: $text, placeholder: "Type some Text")
}
